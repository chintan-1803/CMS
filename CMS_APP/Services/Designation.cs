using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;

namespace CMS.Services
{
    public class Designation : IDesignation
    {
   
        public  RestResponse Designationlist()
        {
            
                var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.DesignationPath);
                RestRequest request = new RestRequest() { Method = Method.Get };
                request.AddHeader("Content-Type", "application/json");
                // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
                RestResponse response = client.Execute(request);
                return response;
       
        }

        public RestResponse AddDesignationlist(DesignationModel designationData)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.AddDesignation);
            RestRequest request = new RestRequest() { Method = Method.Post };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(designationData), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<DesignationModel>(request);
            return response;

        }

        public RestResponse UpdateDesignationlist(DesignationModel updatedesignationData)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.UpdateDesignation);
            RestRequest request = new RestRequest() { Method = Method.Put };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(updatedesignationData), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<DesignationModel>(request);
            return response;

        }

		public RestResponse DeleteDesignationitem(DesignationModel Designation_ID)
		{
			var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.DeleteDesignation);
			RestRequest request = new RestRequest() { Method = Method.Put };
			request.AddHeader("Content-Type", "application/json");
			request.AddParameter("application/json", JsonConvert.SerializeObject(Designation_ID), ParameterType.RequestBody);
			// Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
			var response = client.Execute<DesignationModel>(request);
			return response;
		}


	}
}
