using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;
using System.Net;

namespace CMS.Services
{
    public class Role : IRole
    {
		public RestResponse Rolelist(int pageNumber, int pageSize, out int totalItems)
		{
			try
			{
				var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.RolePath);
				RestRequest request = new RestRequest() { Method = Method.Get };
				request.AddHeader("Content-Type", "application/json");
				request.AddParameter("pageNumber", pageNumber);
				request.AddParameter("pageSize", pageSize);
				var response = client.Execute(request);

				if (response.StatusCode == HttpStatusCode.OK)
				{
					var responseBody = response.Content;
					var data = JsonConvert.DeserializeObject<AllPaginationModel>(responseBody);

					totalItems = data.TotalItems;

					return response;
				}
				else
				{
					throw new Exception("Failed to retrieve the role list from the Web API.");
				}
			}
			catch (Exception ex)
			{
				throw new ArgumentNullException("FAILED TO VIEW ROLES", ex);
			}
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
