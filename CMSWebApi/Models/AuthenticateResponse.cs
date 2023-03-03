using Newtonsoft.Json.Linq;
using System.Reflection.Emit;
using System.Xml.Linq;

namespace CMS.Models
{
    public class AuthenticateResponse
    {
        public int Id { get; set; }
        public string EmailId { get; set; }
        public string Token { get; set; }
        public int AccessToken { get; set; }
        public string Error { get; set; }
        public string UserFullName { get; set; }
        public string UserRoleName { get; set; }

        /*public AuthenticateResponse()
        {

        }*/

        public AuthenticateResponse(LoginResponse user, string token) : base()
        {
            Id = user.Id;
            EmailId = user.EmailId;
            Token = user.Token;
            AccessToken = user.AccessToken;
            Error = user.Error;
            UserFullName = user.UserFullName;
            UserRoleName = user.UserRoleName;
        }
    }

    
}
