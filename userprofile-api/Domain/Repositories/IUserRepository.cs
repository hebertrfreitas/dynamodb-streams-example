using Domain.Model;

namespace Domain.Repositories;

public interface IUserRepository
{
     Task<User> CreateNewUser(CreateUserRequest createUserRequest);
}    