using CMSWebApi.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Reflection.Emit;
using System.Xml.Linq;

namespace CMS.Models
{
    public class LoginResponse
    {
        public int Id { get; set; }
        public string EmailId { get; set; }
        public string Token { get; set; }
        public int AccessToken { get; set; }
        public string Error { get; set; }
        public string UserFullName { get; set; }
        public string UserRoleName { get; set; }
    }
    
}
