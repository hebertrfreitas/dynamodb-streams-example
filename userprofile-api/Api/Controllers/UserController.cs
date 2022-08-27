using Domain.Model;
using Domain.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {

        private readonly IUserRepository _userRepository;

        public UserController(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        [HttpPost]
        public ActionResult<User> CreateUser(CreateUserRequest createUserRequest)
        {
            var createUserTask = _userRepository.CreateNewUser(createUserRequest);
            return Ok(createUserTask.Result);
        }


    }
}
