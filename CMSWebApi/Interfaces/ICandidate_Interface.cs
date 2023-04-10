using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
	public interface ICandidate_Interface
	{
		string AddCandidate(CandidateMasterEntity candidateModel);
	}
}
