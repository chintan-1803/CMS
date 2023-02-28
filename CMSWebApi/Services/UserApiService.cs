using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using CMSWebApi.Dapper;
using CMSWebApi.DataHelper;
using CMSWebApi.Interfaces;
using Dapper;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace CMSWebApi.Services
{
    public class UserApiService : IUserApiService
    {
        private readonly AppSettings _appSettings;
        private readonly IDapper _dapper;
        private readonly ICipherService _cipherService;

        public UserApiService(IOptions<AppSettings> appSettings, IDapper dapper, ICipherService cipherService)
        {
            _appSettings = appSettings.Value;
            _dapper = dapper;
            _cipherService = cipherService;
        }

        public AuthenticateResponse AuthenticateUser(UserLoginEntity model)
        {

            var connectDbparams = new DynamicParameters();
            connectDbparams.Add("email", model.Email, DbType.String);
            connectDbparams.Add("password", _cipherService.Encrypt(model.Password), DbType.String);
            

            var user = _dapper.Get<LoginResponse>(StoreProcedureName.AuthenticateUserExistsORNot, connectDbparams, System.Data.CommandType.StoredProcedure);

           /* if (user == null)
            {
                return new AuthenticateResponse() { Error = "Invalid Username And Password !!" };
            }*/


            // authentication successful so generate jwt token
            //GenerateJwtToken objGenerateJwtToken = new GenerateJwtToken((IOptions<AppSettings>)_appSettings);

            var token = generateJwtToken(user);

            return new AuthenticateResponse(user, token);
        }

        private string generateJwtToken(LoginResponse user)
        {
            // generate token that is valid for 7 days
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

        public LoginResponse GetById(int userId)
        {
            return new LoginResponse();
        }

    }
}
