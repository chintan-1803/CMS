﻿using CMS.ApplicationHelpers;
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
    public class Interviews_Service : IInterviews_Interface
    {
        private readonly AppSettings _appSettings;
        private readonly IDapper _dapper;

        public Interviews_Service(IOptions<AppSettings> appSettings, IDapper dapper)
        {
            _appSettings = appSettings.Value;
            _dapper = dapper;
        }

        public Task<List<InterviewsModel>> GetAllInterviewsData()
        {
            try
            {
                var model = _dapper.GetAll<InterviewsModel>(StoreProcedureName.InterviewsData, null, CommandType.StoredProcedure);
                return Task.FromResult(model);
            }
            catch (ArgumentNullException ex)
            {
                throw new ArgumentNullException("NULL VALUE", ex);
            }
        }

        public string AddInterviewData([FromBody] InterviewsModel interviewsModel)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@CandidateId", interviewsModel.CandidateId, DbType.Int32);
                parameters.Add("@InterviewerId", interviewsModel.InterviewerId, DbType.Int32);
                parameters.Add("@TechnologyId", interviewsModel.TechnologyId, DbType.Int32);
                parameters.Add("@InterviewURL", interviewsModel.InterviewURL, DbType.String);
                parameters.Add("@ScheduledTime", interviewsModel.ScheduledTime, DbType.DateTime);
                parameters.Add("@StatusID", interviewsModel.StatusID, DbType.Int32);
                parameters.Add("@Description", interviewsModel.Description, DbType.String);
                parameters.Add("@ReasonID", interviewsModel.ReasonID, DbType.Int32);
                parameters.Add("@create_user", interviewsModel.create_user, DbType.String);
                //parameters.Add("@create_date", interviewsModel.create_date, DbType.DateTime);
                //parameters.Add("@change_user", interviewsModel.change_user, DbType.String);
                //parameters.Add("@change_date", interviewsModel.change_date, DbType.DateTime);
                //parameters.Add("@IsDeleted", interviewsModel.IsDeleted, DbType.Boolean);

                var result = _dapper.Insert<string>(StoreProcedureName.InsertInterview, parameters, CommandType.StoredProcedure);
                return result;
            }
            catch (ArgumentNullException ex)
            {
                throw new ArgumentNullException("FAILED TO INSERT INTERVIEW DATA.", ex);
            }
        }

        public int UpdateInterviewData(InterviewsModel interviewsModel)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@InterviewId", interviewsModel.InterviewId, DbType.Int32);
                parameters.Add("@CandidateId", interviewsModel.CandidateId, DbType.Int32);
                parameters.Add("@InterviewerId", interviewsModel.InterviewerId, DbType.Int32);
                parameters.Add("@TechnologyId", interviewsModel.TechnologyId, DbType.Int32);
                parameters.Add("@InterviewURL", interviewsModel.InterviewURL, DbType.String);
                parameters.Add("@ScheduledTime", interviewsModel.ScheduledTime, DbType.DateTime);
                parameters.Add("@StatusID", interviewsModel.StatusID, DbType.Int32);
                parameters.Add("@Description", interviewsModel.Description, DbType.String);
                parameters.Add("@ReasonID", interviewsModel.ReasonID, DbType.Int32);
                parameters.Add("@change_user", interviewsModel.change_user, DbType.String);
                //parameters.Add("@change_date", interviewsModel.change_date, DbType.DateTime);
                parameters.Add("@IsDeleted", interviewsModel.IsDeleted, DbType.Boolean);

                var result = _dapper.Execute(StoreProcedureName.UpdateInterview, parameters, CommandType.StoredProcedure);
                return result;
            }
            catch (ArgumentNullException ex)
            {
                throw new ArgumentNullException("FAILED TO UPDATE INTERVIEW DATA.", ex);
            }
        }

        public int DeleteInterviewDataById(InterviewsModel InterviewID)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@InterviewId", InterviewID.InterviewId, DbType.Int32);

                var result = _dapper.Execute(StoreProcedureName.DeleteInterview, parameters, CommandType.StoredProcedure);
                return result;
            }
            catch (ArgumentNullException ex)
            {
                throw new ArgumentNullException("FAILED TO DELETE INTERVIEW DATA.", ex);
            }
        }
    }
}
