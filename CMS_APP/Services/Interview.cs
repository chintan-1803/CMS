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
    public class Interview : IInterview
    {
        internal DateTime ScheduledTime;
        internal int CandidateId;

        public RestResponse GetInterviewList(int pageNumber, int pageSize, out int totalItems)
        {
            try
            {
                var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.InterviewPath);
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
                    throw new Exception("Failed to retrieve the interview list from the Web API.");
                }
            }
            catch (Exception ex)
            {
                throw new ArgumentNullException("FAILED TO View INTERVIEW", ex);
            }
        }

		public RestResponse AddInterview(InterviewModel interviewData)
		{
			try
			{
				var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.AddInterview);
				RestRequest request = new RestRequest() { Method = Method.Post };
				request.AddHeader("Content-Type", "application/json");
				request.AddParameter("application/json", JsonConvert.SerializeObject(interviewData), ParameterType.RequestBody);
				var response = client.Execute<InterviewModel>(request);
				return response;
			}
			catch (Exception ex)
			{
				throw new Exception("Failed to add the interview", ex);
			}
		}

		public RestResponse UpdateInterview(InterviewModel updateInterviewData)
		{
			try
			{
				var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.UpdateInterview);
				RestRequest request = new RestRequest() { Method = Method.Put };
				request.AddHeader("Content-Type", "application/json");
				request.AddParameter("application/json", JsonConvert.SerializeObject(updateInterviewData), ParameterType.RequestBody);
				var response = client.Execute<InterviewModel>(request);
				return response;
			}
			catch (Exception ex)
			{
				throw new Exception("Failed to update the interview", ex);
			}
		}

		public RestResponse DeleteInterview(InterviewModel interviewId)
		{
			try
			{
				var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.DeleteInterview);
				RestRequest request = new RestRequest() { Method = Method.Put };
				request.AddHeader("Content-Type", "application/json");
				request.AddParameter("application/json", JsonConvert.SerializeObject(interviewId), ParameterType.RequestBody);
				var response = client.Execute<InterviewModel>(request);
				return response;
			}
			catch (Exception ex)
			{
				throw new Exception("Failed to delete the interview", ex);
			}
		}

		public RestResponse AddInterviewRound(InterviewRoundModel interviewRoundData)
		{
			try
			{
				var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.AddInterviewRound);
				RestRequest request = new RestRequest() { Method = Method.Post };
				request.AddHeader("Content-Type", "application/json");
				request.AddParameter("application/json", JsonConvert.SerializeObject(interviewRoundData), ParameterType.RequestBody);
				var response = client.Execute(request);

				return response.IsSuccessful ? response : new RestResponse { IsSuccessful = false, ErrorMessage = response.ErrorMessage };
			}
			catch (Exception ex)
			{
				throw new Exception("Failed to add interview round", ex);
			}
		}

		public RestResponse ViewInterviewRound(int interviewId)
		{
			try
			{
				var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.InterviewRoundPath + "/" + interviewId);
				RestRequest request = new RestRequest() { Method = Method.Get };
				request.AddHeader("Content-Type", "application/json");
				var response = client.Execute(request);
				return response;
			}
			catch (Exception ex)
			{
				throw new Exception("Failed to view interview round", ex);
			}
		}
	}
}
