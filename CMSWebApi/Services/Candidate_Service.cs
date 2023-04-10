using CMS.ApplicationHelpers;
using CMSWebApi.Dapper;
using CMSWebApi.DataHelper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using System.Data;

namespace CMSWebApi.Services
{
	public class Candidate_Service : ICandidate_Interface
	{
		private readonly IDapper _dapper;

		public Candidate_Service(IDapper dapper)
		{			_dapper = dapper;
		}
		public string AddCandidate(CandidateMasterEntity candidatedata)
		{
			try
			{
				var parameters = new DynamicParameters();
				parameters.Add("@firstName", candidatedata.firstName, DbType.String);
				parameters.Add("@lastName", candidatedata.lastName, DbType.String);
				parameters.Add("@Email", candidatedata.Email, DbType.String);
				parameters.Add("@ContactNo", candidatedata.ContactNo, DbType.String);
				parameters.Add("@Skills", candidatedata.Skills, DbType.String);
				parameters.Add("@AgreeForChangeLocation", candidatedata.AgreeForChangeLocation, DbType.String);
				parameters.Add("@City", candidatedata.City, DbType.String);
				parameters.Add("@State", candidatedata.State, DbType.String);
				parameters.Add("@Address", candidatedata.Address, DbType.String);
				parameters.Add("@PR_10", candidatedata.PR_10, DbType.String);
				parameters.Add("@PR_12", candidatedata.PR_12, DbType.String);
				parameters.Add("@areaofstudy", candidatedata.areaofstudy, DbType.String);
				parameters.Add("@College_CGPA", candidatedata.College_CGPA, DbType.String);
				parameters.Add("@backlog", candidatedata.backlog, DbType.String);
				parameters.Add("@TechnologyId", candidatedata.TechnologyId, DbType.String);
				parameters.Add("@IsExperience", candidatedata.IsExperience, DbType.String);
				parameters.Add("@TotalExperience", candidatedata.TotalExperience, DbType.String);
				parameters.Add("@CurrentCTC", candidatedata.CurrentCTC, DbType.String);
				parameters.Add("@ExpectedCTC", candidatedata.ExpectedCTC, DbType.String);
				parameters.Add("@ReasoneForChange", candidatedata.ReasoneForChange, DbType.String);
				parameters.Add("@Reference", candidatedata.Reference, DbType.String);
				parameters.Add("@resume", candidatedata.resume, DbType.String);
				parameters.Add("@create_User", candidatedata.create_User, DbType.String);
				


				var result = _dapper.Insert<string>(StoreProcedureName.insertCandidateData, parameters, CommandType.StoredProcedure);

				return result;

			}
			catch (Exception ex)
			{

				throw new ArgumentNullException("FAILED TO INSERT DESIGNATION.", ex);
			}

		}
	}
}
