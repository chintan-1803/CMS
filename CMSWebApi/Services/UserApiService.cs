using CMS.ApplicationHelpers;
//using CMS.Interfaces;
using CMS.Models;
using CMSWebApi.Dapper;
using CMSWebApi.DataHelper;
using CMSWebApi.Interfaces;
using Dapper;
using Microsoft.AspNetCore.Html;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Security.Claims;
using System.Text;
using System.Net.Http;
using MimeKit;
using Org.BouncyCastle.Utilities.Net;
using MailKit.Net.Smtp;
using Microsoft.AspNetCore.Mvc;
using CMSWebApi.Models;

namespace CMSWebApi.Services
{
    public class UserApiService : IUserApiService
    {
        private readonly AppSettings _appSettings;
        private readonly IDapper _dapper;
        private readonly ICipherService _cipherService;
        private readonly IConfiguration _configuration;

        public UserApiService(IOptions<AppSettings> appSettings, IDapper dapper, ICipherService cipherService, IConfiguration configuration)
        {
            _appSettings = appSettings.Value;
            _dapper = dapper;
            _cipherService = cipherService;
            _configuration = configuration;
        }

        public AuthenticateResponse AuthenticateUser(WebApiUserLoginEntity model)
        {
            //string testPassword = _cipherService.Decrypt("Cdu8ugFusrwvh7Yli/ZlkQ==");
            var connectDbparams = new DynamicParameters();
            connectDbparams.Add("email", model.Email, DbType.String);
            connectDbparams.Add("password", _cipherService.Encrypt(model.Password), DbType.String);


            var user = _dapper.Get<LoginResponse>(StoreProcedureName.AuthenticateUserExistsORNot, connectDbparams, System.Data.CommandType.StoredProcedure);

            if (user == null)
            {
                return new AuthenticateResponse() { Error = "Invalid Username And Password !!" };
            }


            // authentication successful so generate jwt token
            //GenerateJwtToken objGenerateJwtToken = new GenerateJwtToken((IOptions<AppSettings>)_appSettings);

            var token = generateJwtToken(user);

            return new AuthenticateResponse(user, token);
        }

        public AuthenticateResponse UserByEmail(string email)
        {
            //string testPassword = _cipherService.Decrypt("Cdu8ugFusrwvh7Yli/ZlkQ==");
            var connectDbparams = new DynamicParameters();
            connectDbparams.Add("email", email, DbType.String);

            var user = _dapper.Get<LoginResponse>(StoreProcedureName.GetUserByEmail, connectDbparams, System.Data.CommandType.StoredProcedure);

            if (user == null)
            {
                return new AuthenticateResponse() { Error = "Invalid Email!!" };
            }
            return new AuthenticateResponse(user, "");

        }

        public int ResetPasswordData(ForgotPassword model)
        {
            
            var connectDbparams = new DynamicParameters();
            connectDbparams.Add("@EmaillId", model.EmailId, DbType.String);
            connectDbparams.Add("@Password", _cipherService.Encrypt(model.Password), DbType.String);

            var user = _dapper.Execute(StoreProcedureName.ResetPassword, connectDbparams, System.Data.CommandType.StoredProcedure);


            // authentication successful so generate jwt token
            //GenerateJwtToken objGenerateJwtToken = new GenerateJwtToken((IOptions<AppSettings>)_appSettings);

            //var token = generateJwtToken(user);

            return user;

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


        public async Task<string> SendEmail(string toEmail, string subject, string body, EmailConfiguration emailConfiguration)
        {
            try
            {
                var emailConfig = _configuration.GetSection("EmailConfiguration").Get<EmailConfiguration>();
                var mimeMessage = new MimeMessage();

                mimeMessage.From.Add(new MailboxAddress(emailConfig.From, emailConfig.From));

                mimeMessage.To.Add(new MailboxAddress(toEmail, toEmail));

                mimeMessage.Subject = subject; //Subject  

                mimeMessage.Body = new TextPart("plain"){
                    Text = body
                };

                using (var client = new SmtpClient())

                {
                     
                    client.Connect(emailConfig.SmtpServer, emailConfig.Port, true);

                    client.Authenticate(emailConfig.From, emailConfig.Password);

                    await client.SendAsync(mimeMessage);

                    Console.WriteLine("The mail has been sent successfully !!");

                    Console.ReadLine();

                    await client.DisconnectAsync(true);

                }
               
            }
            catch (Exception) { }
            return "";
        }


    }
}
