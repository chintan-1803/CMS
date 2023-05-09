using CMS.ApplicationHelpers;
using CMSWebApi.Dapper;
using CMSWebApi.DataHelper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace CMSWebApi.Services
{
    public class InterviewRound_Service : IInterviewRound_Interface
    {
        private readonly AppSettings _appSettings;
        private readonly IDapper _dapper;
        private readonly ICipherService _cipherService;

        public InterviewRound_Service(IOptions<AppSettings> appSettings, IDapper dapper, ICipherService cipherService)
        {
            _appSettings = appSettings.Value;
            _dapper = dapper;
            _cipherService = cipherService;
        }

        public Task<List<InterviewRoundModel>> GetAllInterviewRoundData(int Interview_Id)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@interviewId", Interview_Id, DbType.Int32);

                var result = _dapper.GetAll<InterviewRoundModel>(StoreProcedureName.InterviewRoundsData, parameters, CommandType.StoredProcedure);

                return Task.FromResult(result);
            }
            catch (Exception ex)
            {
                throw new Exception("FAILED TO GET INTERVIEW ROUND DATA.", ex);
            }
        }

        public string AddInterviewRoundData([FromBody] InterviewRoundModel interviewRoundModel)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@interviewId", interviewRoundModel.interviewId, DbType.Int32);
                parameters.Add("@roundNumberId", interviewRoundModel.roundNumberId, DbType.Int32);
                parameters.Add("@roundStatusId", interviewRoundModel.roundStatusId, DbType.Int32);
                parameters.Add("@scheduledAt", interviewRoundModel.scheduledAt, DbType.DateTime);
                parameters.Add("@roundFeedback", interviewRoundModel.roundFeedback, DbType.String);
                parameters.Add("@create_user", interviewRoundModel.create_user, DbType.String);

                var result = _dapper.Insert<string>(StoreProcedureName.InsertInterviewRound, parameters, CommandType.StoredProcedure);

                return result;
            }
            catch (ArgumentNullException ex)
            {
                throw new ArgumentNullException("FAILED TO INSERT INTERVIEW ROUND.", ex);
            }
        }

        public int UpdateInterviewRoundData(InterviewRoundModel interviewRoundModel)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@InterviewRoundId", interviewRoundModel.interviewRoundId, DbType.Int32);
                parameters.Add("@RoundNumberId", interviewRoundModel.roundNumberId, DbType.Int32);
                parameters.Add("@RoundStatusId", interviewRoundModel.roundStatusId, DbType.Int32);
                parameters.Add("@ScheduledAt", interviewRoundModel.scheduledAt, DbType.DateTime);
                parameters.Add("@RoundFeedback", interviewRoundModel.roundFeedback, DbType.String);
                parameters.Add("@change_user", interviewRoundModel.change_user, DbType.String);
                //parameters.Add("@IsDeleted", interviewRoundModel.IsDeleted, DbType.Boolean);

                var result = _dapper.Execute(StoreProcedureName.UpdateInterviewRound, parameters, CommandType.StoredProcedure);

                return result;
            }
            catch (ArgumentNullException ex)
            {
                throw new ArgumentNullException("FAILED TO UPDATE INTERVIEW ROUND.", ex);
            }
        }

        public int DeleteInterviewRoundDataById(InterviewRoundModel interviewRound_Id)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@InterviewRoundId", interviewRound_Id.interviewRoundId, DbType.Int32);

                var result = _dapper.Execute(StoreProcedureName.DeleteInterviewRound, parameters, CommandType.StoredProcedure);

                return result;
            }
            catch (ArgumentNullException ex)
            {
                throw new ArgumentNullException("FAILED TO DELETE INTERVIEW ROUND.", ex);
            }
        }
    }
}
