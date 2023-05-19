using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;
using System.Net;

namespace CMS.Services
{
    public class Candidate : ICandidate
	{

		public RestResponse AddCandidate(CandidateMasterEntity candidateModel)
		{
			try

			{
				var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.insertCandidates);//change webapiurl
				RestRequest request = new RestRequest() { Method = Method.Post };
				request.AddHeader("Content-Type", "application/json");
				request.AddParameter("application/json", JsonConvert.SerializeObject(candidateModel), ParameterType.RequestBody);
				// Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
				var response = client.Execute<CandidateMasterEntity>(request);
				return response;
			}
			catch (Exception ex)
			{
				throw new ArgumentNullException("FAILED TO INSERT Candidate.", ex);

			}
		}

        //Admin---
        public RestResponse GetCandidateList(int pageNumber, int pageSize, out int totalItems)
        {
            try
            {
                var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.candidateList);
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
                    throw new Exception("Failed to retrieve the candidate list from the Web API.");
                }
            }
            catch (Exception ex)
            {
                throw new ArgumentNullException("FAILED TO View CANDIDATE", ex);
            }
        }
    }
}