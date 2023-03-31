using CMS.ApplicationHelpers;
using CMS.Interfaces;
using RestSharp;

namespace CMS.Services
{
	public class MasterData : IMasterData
	{
		public RestResponse AllMasterDatalist()
		{

			var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.MasterDatalist);
			RestRequest request = new RestRequest() { Method = Method.Get };
			request.AddHeader("Content-Type", "application/json");
			// Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
			RestResponse response = client.Execute(request);
			return response;

		}
	}
}
