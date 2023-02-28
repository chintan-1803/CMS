using CMS.Models;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace CMSWebApi.DataHelper
{
    public class GenerateJwtToken
    {
        private readonly AppSettings _appSettings;

        public  GenerateJwtToken(IOptions<AppSettings> appSettings)
        {
            _appSettings = appSettings.Value;
        }

        public string GetGenerateJwtToken(LoginResponse user)
        {
            // generate token that is valid for 1 days
            var tokenHandler = new JwtSecurityTokenHandler();

            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                  new Claim("EmailId",  !string.IsNullOrEmpty(user.EmailId) ? user.EmailId.ToString():string.Empty),
                  new Claim("UserFullName",  !string.IsNullOrEmpty(user.UserFullName) ? user.UserFullName.ToString():string.Empty),
            }),
                Expires = DateTime.UtcNow.AddDays(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}
