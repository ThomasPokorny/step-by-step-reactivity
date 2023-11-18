const express = require('express');
const redis = require('redis');

const app = express();
app.use(express.json());
const port = 3001;

// Redis configuration
const redisConfig = {
    host: 'localhost',
    port: 6379,
};

// Create a Redis client with the specified configuration
const redisClient = redis.createClient(redisConfig);
redisClient.connect().then(() => {
    console.log('Connected to Redis');
    startAnalyticsService();
});

function processTotalUserRevenue(order) {
    const userAggregateKey = `user:${order.user.id}`;
    redisClient.hGet(userAggregateKey, 'totalSpent')
        .then((totalSpent) => {
            totalSpent = totalSpent ? parseFloat(totalSpent) : 0;
            const orderRevenue = order.totalPrice || 0; // Assuming order.totalPrice is the total order amount

            const newTotalSpent = totalSpent + orderRevenue;

            // Update the Redis cache with the new total spent
            void redisClient.hSet(userAggregateKey, 'totalSpent', newTotalSpent);
            void redisClient.hSet(userAggregateKey, 'name', order.user.name);

            console.log(`User ${order.user.name}: Total spent: ${newTotalSpent}`);
        }).catch((err) => {
        console.error(`Error getting total spent for user ${order.user.id} from Redis: ${err}`);
    });
}

function startAnalyticsService() {

    // Endpoint to handle incoming orders
    app.put('/orders', (req, res) => {
        const order = req.body;

        // Process the order and update the Redis cache
        processOrder(order);

        res.status(200).json({message: 'Order processed successfully'});
    });

    // Endpoint to get total number of orders
    app.get('/total-number-of-orders', (req, res) => {
        redisClient.get('total_orders').then((numberOfOrders) => {
            res.json({numberOfOrders: parseFloat(numberOfOrders) || 0});
        });
    });


    // Endpoint to get total revenue
    app.get('/total-revenue', (req, res) => {
        redisClient.get('total_revenue').then((totalRevenue) => {
            res.json({totalRevenue: parseFloat(totalRevenue) || 0});
        });
    });

    // Endpoint to get aggregate information on products
    app.get('/product-aggregates', (req, res) => {
        const productKeysPattern = 'product:*';

        redisClient.keys(productKeysPattern).then((productKeys) => {

            // Fetch details for each product key
            const productAggregates = [];

            productKeys.forEach((productKey) => {
                redisClient.hGetAll(productKey).then((productInfo) => {
                    if (productInfo) {
                        const product = JSON.parse(productInfo[productKey]);
                        productAggregates.push({
                            productId: product.id,
                            productName: product.name,
                            amount: product.amount,
                            revenue: product.revenue,
                        });
                    }

                    if (productAggregates.length === productKeys.length) {
                        res.json({ products: productAggregates });
                    }
                });
            });
        });
    });

    // Function to process the order and update the aggregates in the  Redis cache
    function processOrder(order) {
        order.products.forEach((product) => {
            processProduct(product);
        });

        processTotalOrderAmount();

        processTotalRevenue(order);

        processTotalUserRevenue(order);
    }

    app.listen(port, () => {
        console.log(`AnalyticsService is running on port ${port}`);
    });
}

function processProduct(product) {
    const key = `product:${product.id}`;
    const field = `product:${product.id}`;

    redisClient.hGet(key, field).then((result) => {
        const existingAmount = result ? JSON.parse(result).amount : 0;
        const newAmount = existingAmount + product.amount;

        const existingRevenue = result ? JSON.parse(result).revenue : 0;
        const newRevenue = existingRevenue + product.price * product.amount;

        // Update the Redis cache with the new amount
        redisClient.hSet(key, field, JSON.stringify({id:product.id, name: product.name, amount: newAmount, revenue: newRevenue}));

        console.log(`Updated ${key}, field ${field} to ${newAmount} items of ${product.name}, with total revenue: ${newRevenue} €`);
    }).catch(() => console.log(`Updated ${key}, field ${field} to ${newAmount} items of ${product.name}`));
}

function processTotalOrderAmount() {
    redisClient.incr('total_orders').then((totalOrders) => {
        console.log(`Total number of orders: ${totalOrders}`);
    }).catch((err) => {
        console.error(`Error incrementing total orders in Redis: ${err}`);
    });
}

function processTotalRevenue(order) {
    const totalRevenueKey = 'total_revenue';
    redisClient.get(totalRevenueKey)
        .then((totalRevenue) => {
            totalRevenue = totalRevenue ? parseFloat(totalRevenue) : 0;
            const orderRevenue = order.totalPrice || 0; // Assuming order.totalPrice is the total order amount

            const newTotalRevenue = totalRevenue + orderRevenue;

            // Update the Redis cache with the new total revenue
            redisClient.set(totalRevenueKey, newTotalRevenue);

            console.log(`Total revenue: ${newTotalRevenue} €`);
        }).catch((err) => {
        console.error(`Error getting total revenue from Redis: ${err}`);
    });
}