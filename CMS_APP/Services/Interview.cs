using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;
using System.Data;
using System.Data.SqlClient;

namespace CMS.Services
{
    public class Interview : IInterview
    {
        public RestResponse GetInterviewList()
        {
            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.InterviewPath);
            RestRequest request = new RestRequest() { Method = Method.Get };
            request.AddHeader("Content-Type", "application/json");
            RestResponse response = client.Execute(request);
            return response;
        }

        public RestResponse AddInterview(InterviewModel interviewData)
        {
            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.AddInterview);
            RestRequest request = new RestRequest() { Method = Method.Post };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(interviewData), ParameterType.RequestBody);
            var response = client.Execute<InterviewModel>(request);
            return response;
        }

        public RestResponse UpdateInterview(InterviewModel updateInterviewData)
        {
            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.UpdateInterview);
            RestRequest request = new RestRequest() { Method = Method.Put };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(updateInterviewData), ParameterType.RequestBody);
            var response = client.Execute<InterviewModel>(request);
            return response;
        }

        public RestResponse DeleteInterview(InterviewModel interviewId)
        {
            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.DeleteInterview);
            RestRequest request = new RestRequest() { Method = Method.Put };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(interviewId), ParameterType.RequestBody);
            var response = client.Execute<InterviewModel>(request);
            return response;
        }
    }
}
