﻿using CMS.ApplicationHelpers;
using CMSWebApi.Dapper;
using CMSWebApi.DataHelper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using System.Data;
using System.Reflection;

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
        public Task<List<InterviewerModel>> GetAllInterviewerDetails(int pageNumber, int pageSize, out int totalItems)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@PageNumber", pageNumber);
                parameters.Add("@PageSize", pageSize);
                parameters.Add("@TotalItems", dbType: DbType.Int32, direction: ParameterDirection.Output);

                var model = _dapper.GetAll<InterviewerModel>(StoreProcedureName.InterviewerData, parameters, CommandType.StoredProcedure);
                totalItems = parameters.Get<int>("@TotalItems");

                return Task.FromResult(model);
            }
            catch (Exception ex)
            {
                throw new Exception("Error occurred while retrieving all interviewers.", ex);
            }
        }
        #endregion

        #region AddInterviewer Data
        public string AddInterviewer([FromBody] InterviewerModel interviewerModel)
        {
            try
            {
                var parameters = new DynamicParameters();
                //parameters.Add("@InterviewerId", interviewerModel.InterviewerId, DbType.Int32);
                parameters.Add("@FirstName", interviewerModel.FirstName, DbType.String);
                parameters.Add("@LastName", interviewerModel.LastName, DbType.String);
                parameters.Add("@Email", interviewerModel.Email, DbType.String);
                parameters.Add("@Password", _cipherService.Encrypt(interviewerModel.Password), DbType.String);
                //parameters.Add("@Password", interviewerModel.Password, DbType.String);
                parameters.Add("@TechnologyId", interviewerModel.TechnologyId, DbType.String);
                parameters.Add("@YearOfExperience", interviewerModel.YearOfExperience, DbType.Double);
                parameters.Add("@DesignationId", interviewerModel.DesignationId, DbType.String);
                parameters.Add("@TotalInterviewsConducted", interviewerModel.TotalInterviewsConducted, DbType.Int32);
                parameters.Add("@create_user", interviewerModel.create_User, DbType.String);

                var result = _dapper.Insert<string>(StoreProcedureName.InsertInterviewer, parameters, CommandType.StoredProcedure);

                if (result == null)
                {
                    throw new Exception("Failed to insert Interviewer Data.");
                }

                return result;
            }
            catch (Exception ex)
            {
                throw new Exception("Error occurred while retrieving all interviewers.", ex);
            }
        }

        #endregion

        #region UpdateInterviewer Details
        public int UpdateInterviewer(InterviewerModel interviewerModel)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@InterviewerId", interviewerModel.InterviewerId, DbType.Int32);
                parameters.Add("@FirstName", interviewerModel.FirstName, DbType.String);
                parameters.Add("@LastName", interviewerModel.LastName, DbType.String);
                parameters.Add("@Email", interviewerModel.Email, DbType.String);
                parameters.Add("@Password", _cipherService.Encrypt(interviewerModel.Password), DbType.String);
                //parameters.Add("@Password", interviewerModel.Password, DbType.String);
                parameters.Add("@TechnologyId", interviewerModel.TechnologyId, DbType.String);
                parameters.Add("@YearOfExperience", interviewerModel.YearOfExperience, DbType.Double);
                parameters.Add("@DesignationId", interviewerModel.DesignationId, DbType.String);
                parameters.Add("@TotalInterviewsConducted", interviewerModel.TotalInterviewsConducted, DbType.Int32);
                parameters.Add("@change_user", interviewerModel.change_user, DbType.String);
                parameters.Add("@IsDeleted", interviewerModel.IsDeleted, DbType.Int32);

                var result = _dapper.Execute(StoreProcedureName.UpdateInterviewer, parameters, CommandType.StoredProcedure);

                return result;
            }
            catch (Exception ex)
            {
                throw new Exception("Error occurred while updating interviewer.", ex);
            }
        }
        #endregion

        #region DeleteInterviewer By Id
        public int DeleteInterviewerByid(InterviewerModel Interviewer_Id)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@InterviewerId", Interviewer_Id.InterviewerId, DbType.Int32);

                var result = _dapper.Execute(StoreProcedureName.DeleteInterviewer, parameters, CommandType.StoredProcedure);

                if (result == 0)
                {
                    throw new Exception("Failed to insert designation.");
                }
                return result;
            }
            catch (Exception ex)
            {
                throw new Exception("Error occurred while deleting interviewer.", ex);
            }
        }
        #endregion
    }
}

