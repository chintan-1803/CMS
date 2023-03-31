using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;
using System.Data;
using System.Data.SqlClient;

namespace CMS.Services
{
    public class Interviewer : IInterviewer
    {
        
        public RestResponse Interviewerlist()
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.InterviewerPath);
            RestRequest request = new RestRequest() { Method = Method.Get };
            request.AddHeader("Content-Type", "application/json");
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            RestResponse response = client.Execute(request);
            return response;

        }

        public RestResponse AddInterviewerlist(InterviewerModel InterviewerData)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.AddInterviewer);
            RestRequest request = new RestRequest() { Method = Method.Post };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(InterviewerData), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<InterviewerModel>(request);
            return response;

        }

        public RestResponse UpdateInterviewerlist(InterviewerModel updateInterviewerData)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.UpdateInterviewer);
            RestRequest request = new RestRequest() { Method = Method.Put };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(updateInterviewerData), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<InterviewerModel>(request);
            return response;

        }

        public RestResponse DeleteIntervieweritem(InterviewerModel InterviewerId)
        {
            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.DeleteInterviewer);
            RestRequest request = new RestRequest() { Method = Method.Put };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(InterviewerId), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<InterviewerModel>(request);
            return response;
        }
    }
}
