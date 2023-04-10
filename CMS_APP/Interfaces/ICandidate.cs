using CMS.Models;
using RestSharp;

namespace CMS.Interfaces
{
	public interface ICandidate
	{
		public RestResponse AddCandidate(CandidateMasterEntity candidateModel);
	}
}
