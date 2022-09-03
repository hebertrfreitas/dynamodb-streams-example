using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DataModel;
using Domain.Model;
using Domain.Repositories;

namespace Infra.Repositories;

public class UserRepository : IUserRepository
{
    private readonly IDynamoDBContext _dynamoDbContext;

    public UserRepository(IAmazonDynamoDB dynamoDb)
    {
        _dynamoDbContext = new DynamoDBContext(dynamoDb);
    }

    public async Task<User> CreateNewUser(CreateUserRequest createUserRequest)
    {
        var user = new User
        {
            Id = Guid.NewGuid().ToString(),
            UserName = createUserRequest.username,
            Email = createUserRequest.email
        };
        
        
        await _dynamoDbContext.SaveAsync(user);
        return user;
    }
}
