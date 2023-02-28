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
    }
}
