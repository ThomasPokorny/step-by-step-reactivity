using KafkaFlow;
using KafkaFlow.Producers;
using KafkaFlow.Serializer.SchemaRegistry;
using static Microsoft.AspNetCore.Http.Results;

var builder = WebApplication.CreateBuilder(args);

const string topicName = "products";
const string producerName = "product-management";

builder.Services.AddKafka(kafka =>
{
    kafka.UseConsoleLog()
        .AddCluster(
            cluster =>
            {
                cluster
                    .WithBrokers(new[] { builder.Configuration.GetConnectionString("Kafka") })
                    .CreateTopicIfNotExists(topicName, 1, 1)
                    .AddProducer(producerName, producer =>
                    {
                        producer.DefaultTopic(topicName)
                            .AddMiddlewares(m => m.AddSerializer<ConfluentAvroSerializer>());
                    });
            });
});

var app = builder.Build();

var todosApi = app.MapGroup("/foods");

todosApi.MapPost("/", async (AddFoodDto foodDto, IProducerAccessor producerAccessor) =>
{
    var food = new FoodAdded(Guid.NewGuid(), foodDto.Name);

    var producer = producerAccessor.GetProducer(producerName);

    await producer.ProduceAsync(topicName, food.Id.ToString(), food);

    return Ok(food);
});

app.Run();

public record FoodAdded(Guid Id, string Name);

public record AddFoodDto(string Name);
