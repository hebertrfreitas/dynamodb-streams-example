using Amazon;
using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DataModel;
using Amazon.Runtime;
using Domain.Repositories;
using Infra.Repositories;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddScoped<IUserRepository, UserRepository>();
builder.Services.AddSingleton<IAmazonDynamoDB>(p =>
        new AmazonDynamoDBClient(
            new BasicAWSCredentials("test_key", "test_secret"), 
            new AmazonDynamoDBConfig
            {
              RegionEndpoint = RegionEndpoint.SAEast1,
              ServiceURL = "http://localhost:4566",
              UseHttp = true
            })
);
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
