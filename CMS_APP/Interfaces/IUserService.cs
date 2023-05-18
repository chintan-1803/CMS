using CMS.Models;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CMS.Interfaces
{
    public interface IUserService
    {
        LoginResponse AuthenticateLogin(UserLoginEntity loginRequest);

        public RestResponse UserEmail(string email);


		public RestResponse ResetPassword(ForgotPassword forgotPassword);
    }
}
