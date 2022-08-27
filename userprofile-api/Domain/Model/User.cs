using Amazon.DynamoDBv2.DataModel;

namespace Domain.Model;

[DynamoDBTable("User")]
public class User
{
    [DynamoDBHashKey]
    public string Id { get; set; }
    
    [DynamoDBProperty]
    public string UserName { get; set; }
    
    [DynamoDBProperty]
    public string Email { get; set; }
}