using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;

namespace CMS.Services
{
    public class UserService : IUserService
    {
        public LoginResponse AuthenticateLogin(UserLoginEntity objUserLogin)
        {
            try
            {
                var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.LoginPath);
                RestRequest request = new RestRequest() { Method = Method.Post };
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", JsonConvert.SerializeObject(objUserLogin), ParameterType.RequestBody);
                var response = client.Execute<LoginResponse>(request);
                return response.IsSuccessful ? response?.Data : new LoginResponse();
            }
            catch (Exception)
            {
                return new LoginResponse();
            }
            finally
            {
                GC.Collect();
            }
        }

        public RestResponse UserEmail(string email)
        {
            try
            {
                var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.ForgotPasswordPath+""+ email + "");
                RestRequest request = new RestRequest() { Method = Method.Post };
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", JsonConvert.SerializeObject(email), ParameterType.RequestBody);
                var response = client.Execute<LoginResponse>(request);
                return response;
            }
            catch (Exception ex)
            {
				throw new ArgumentNullException("FAILED TO CHANGED ResetPassword.", ex);
			}
            finally
            {
                GC.Collect();
            }
        }

        public RestResponse ResetPassword(ForgotPassword  forgotPassword)
        {
            try
            {
                var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.ResetPasswordPath);
                RestRequest request = new RestRequest() { Method = Method.Post };
                request.AddHeader("Content-Type", "application/json");
                request.AddParameter("application/json", JsonConvert.SerializeObject(forgotPassword), ParameterType.RequestBody);
                var response = client.Execute<ForgotPassword>(request);
                return response;
            }
            catch (Exception ex)
            {

                throw new ArgumentNullException("FAILED TO CHANGED ResetPassword.", ex);
            }
            finally
            {
                GC.Collect();
            }
        }


    }
}
