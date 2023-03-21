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
    public class Interviewer_Service : IInterviewer_Interface
    {
        private readonly AppSettings _appSettings;
        private readonly IDapper _dapper;
        private readonly ICipherService _cipherService;

        public Interviewer_Service(IOptions<AppSettings> appSettings, IDapper dapper, ICipherService cipherService)
        {
            _appSettings = appSettings.Value;
            _dapper = dapper;
            _cipherService = cipherService;
        }

        #region GetInterviewer Data
        public Task<List<InterviewerModel>> GetAllInterviewerDetails()
        {
            var model = _dapper.GetAll<InterviewerModel>(StoreProcedureName.InterviewerData, null, System.Data.CommandType.StoredProcedure);
            return Task.FromResult(model);
        }
        #endregion

        #region AddInterviewer Data
        public Task<InterviewerModel> AddInterviewer([FromBody] InterviewerModel interviewerModel)
        {
            var parameters = new DynamicParameters();
            //parameters.Add("@InterviewerId", interviewerModel.InterviewerId, DbType.Int32);
            parameters.Add("@FirstName", interviewerModel.FirstName, DbType.String);
            parameters.Add("@LastName", interviewerModel.LastName, DbType.String);
            parameters.Add("@Email", interviewerModel.Email, DbType.String);
            parameters.Add("@Technology", interviewerModel.Technology, DbType.String);
            parameters.Add("@YearOfExperiance", interviewerModel.YearOfExperiance, DbType.Int32);
            parameters.Add("@Designation", interviewerModel.Designation, DbType.String);
            parameters.Add("@TotalInterviewsConducted", interviewerModel.TotalInterviewsConducted, DbType.Int32);
            parameters.Add("@create_user", interviewerModel.create_User, DbType.String);

            var result = _dapper.Insert<InterviewerModel>(StoreProcedureName.InsertInterviewer, parameters, CommandType.StoredProcedure);

            if (result == null)
            {
                throw new Exception("Failed to insert Interviewer Data.");
            }

            return Task.FromResult(result);
        }
        #endregion

        #region UpdateInterviewer Details
        public int UpdateInterviewer(InterviewerModel interviewerModel)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@InterviewerId", interviewerModel.InterviewerId, DbType.Int32);
            parameters.Add("@FirstName", interviewerModel.FirstName, DbType.String);
            parameters.Add("@LastName", interviewerModel.LastName, DbType.String);
            //parameters.Add("@Email", interviewerModel.Email, DbType.String);
            parameters.Add("@Technology", interviewerModel.Technology, DbType.String);
            parameters.Add("@YearOfExperience", interviewerModel.YearOfExperiance, DbType.Int32);
            parameters.Add("@Designation", interviewerModel.Designation, DbType.String);
            parameters.Add("@TotalInterviewsConducted", interviewerModel.TotalInterviewsConducted, DbType.Int32);
            parameters.Add("@change_user", interviewerModel.Change_user, DbType.String);
            // parameters.Add("@IsDelete", InterviewerModel.IsDelete=false, DbType.String);

            var result = _dapper.Execute(StoreProcedureName.UpdateInterviewer, parameters, CommandType.StoredProcedure);

            return result;
        }
        #endregion

        #region DeleteInterviewer By Id
        public int DeleteInterviewerByid(int InterviewerId)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@InterviewerId", InterviewerId, DbType.Int32);

            var result = _dapper.Execute(StoreProcedureName.DeleteInterviewer, parameters, CommandType.StoredProcedure);

            if (result == 0)
            {
                throw new Exception("Failed to insert designation.");
            }
            return result;
        }
        #endregion
    }
}

