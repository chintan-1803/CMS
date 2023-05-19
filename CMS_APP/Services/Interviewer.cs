using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;
using System.Data;
using System.Data.SqlClient;
using System.Net;

namespace CMS.Services
{
    public class Interviewer : IInterviewer
    {
        public RestResponse Interviewerlist(int pageNumber, int pageSize, out int totalItems)
        {
            try
            {
                var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.InterviewerPath);
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
                    throw new Exception("Failed to retrieve the interviewer list from the Web API.");
                }
            }
            catch (Exception ex)
            {
                throw new ArgumentNullException("FAILED TO VIEW INTERVIEWER", ex);
            }
        }

		public RestResponse AddInterviewerlist(InterviewerModel InterviewerData)
		{
			try
			{
				var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.AddInterviewer);
				RestRequest request = new RestRequest() { Method = Method.Post };
				request.AddHeader("Content-Type", "application/json");
				request.AddParameter("application/json", JsonConvert.SerializeObject(InterviewerData), ParameterType.RequestBody);
				var response = client.Execute<InterviewerModel>(request);
				return response;
			}
			catch (Exception ex)
			{
				// Handle the exception or log the error
				throw new Exception("Failed to add interviewer", ex);
			}
		}

		public RestResponse UpdateInterviewerlist(InterviewerModel updateInterviewerData)
		{
			try
			{
				var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.UpdateInterviewer);
				RestRequest request = new RestRequest() { Method = Method.Put };
				request.AddHeader("Content-Type", "application/json");
				request.AddParameter("application/json", JsonConvert.SerializeObject(updateInterviewerData), ParameterType.RequestBody);
				var response = client.Execute<InterviewerModel>(request);
				return response;
			}
			catch (Exception ex)
			{
				// Handle the exception or log the error
				throw new Exception("Failed to update interviewer", ex);
			}
		}

		public RestResponse DeleteIntervieweritem(InterviewerModel InterviewerId)
		{
			try
			{
				var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.DeleteInterviewer);
				RestRequest request = new RestRequest() { Method = Method.Put };
				request.AddHeader("Content-Type", "application/json");
				request.AddParameter("application/json", JsonConvert.SerializeObject(InterviewerId), ParameterType.RequestBody);
				var response = client.Execute<InterviewerModel>(request);
				return response;
			}
			catch (Exception ex)
			{
				// Handle the exception or log the error
				throw new Exception("Failed to delete interviewer", ex);
			}
		}

	}
}
