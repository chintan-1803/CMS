using CMS.Models;
using CMSWebApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CMSWebApi.Interfaces
{
    public interface IUserApiService
    {
        AuthenticateResponse AuthenticateUser(WebApiUserLoginEntity loginRequest);
        LoginResponse GetById(int userId);

        //public WebApiUserLoginEntity ResetPasswordData(ForgotPassword model);

        public int ResetPasswordData(ForgotPassword model);

        public AuthenticateResponse UserByEmail(string email);
        Task<string> SendEmail(string toEmail, string subject, string body, EmailConfiguration emailConfiguration);

	}
}
