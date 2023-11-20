# step-by-step-reactivity

Work in Progress 🚧

### Prerequisites
- Ensure you have [Docker](https://www.docker.com/) installed.

### Crete containers 

```cli
docker-compose up
```

#### Create orders topic:

```cli
docker exec -it step-by-step-reactivity-redpanda-1 rpk topic create orders --partitions 1
```

Produce order message:
```cli
docker exec -it step-by-step-reactivity-redpanda-1 rpk topic produce orders
{  "id": "neworderid",  "products": [    {"id": "#3", "name": "newproduct", "price": 25, "amount": 3}  ],  "totalPrice": 75,  "user": {"id": "54321", "name": "John Doe"}}
```
