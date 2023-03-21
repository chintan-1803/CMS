using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;

namespace CMS.Services
{
    public class Role : IRole
    {
        public RestResponse Rolelist()
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.RolePath);
            RestRequest request = new RestRequest() { Method = Method.Get };
            request.AddHeader("Content-Type", "application/json");
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            RestResponse response = client.Execute(request);
            return response;

        }
        public RestResponse AddRolelist(RoleModel roleModel)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.AddRole);
            RestRequest request = new RestRequest() { Method = Method.Post };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(roleModel), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<RoleModel>(request);
            return response;

        }

        public RestResponse UpdateRolelist(RoleModel roleModel)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.UpdateRole);
            RestRequest request = new RestRequest() { Method = Method.Put };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(roleModel), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<RoleModel>(request);
            return response;

        }

        public RestResponse DeleteRoleitem(RoleModel Role_ID)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.DeleteRole);
            RestRequest request = new RestRequest() { Method = Method.Put };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(Role_ID), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<RoleModel>(request);
            return response;

        }
    }
}
