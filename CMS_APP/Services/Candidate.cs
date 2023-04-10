using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;

namespace CMS.Services
{
	public class Candidate : ICandidate
	{

		public RestResponse AddCandidate(CandidateMasterEntity candidateModel)
		{

			var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.insertCandidates);//change webapiurl
			RestRequest request = new RestRequest() { Method = Method.Post };
			request.AddHeader("Content-Type", "application/json");
			request.AddParameter("application/json", JsonConvert.SerializeObject(candidateModel), ParameterType.RequestBody);
			// Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
			var response = client.Execute<CandidateMasterEntity>(request);
			return response;

		}
	}
}
