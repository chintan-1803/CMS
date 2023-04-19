using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
	public interface ICandidate_Interface
	{
		public string addCandidate(CandidateMasterEntity candidatedata);

		//Admin--
		public Task<List<CandidateMasterEntity>> GetAllCandidates();
	}
}
