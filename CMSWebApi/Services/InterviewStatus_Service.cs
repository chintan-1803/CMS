using CMS.ApplicationHelpers;
using CMSWebApi.Dapper;
using CMSWebApi.DataHelper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace CMSWebApi.Services
{
    public class InterviewStatus_Service : IInterviewStatus_Interface
    {
        private readonly AppSettings _appSettings;
        private readonly IDapper _dapper;
        private readonly ICipherService _cipherService;

        public InterviewStatus_Service(IOptions<AppSettings> appSettings, IDapper dapper, ICipherService cipherService)
        {
            _appSettings = appSettings.Value;
            _dapper = dapper;
            _cipherService = cipherService;
        }

        #region GetInterviewStatus
        public Task<List<InterviewStatusModel>> GetAllInterviewStatus()
        {
            try
            {
                var model = _dapper.GetAll<InterviewStatusModel>(StoreProcedureName.InterviewStatusData, null, System.Data.CommandType.StoredProcedure);
                return Task.FromResult(model);
            }
            catch (ArgumentNullException ex)
            {

                throw new ArgumentNullException("NULL VALUE", ex);
            }
        }
        #endregion

        #region AddInterviewStatus
       public string AddInterviewStatus( InterviewStatusModel interviewStatusModel)
       {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@Name", interviewStatusModel.Name, DbType.String);
                //parameters.Add("@IsDeleted", interviewStatusModel.IsDeleted, DbType.Boolean);
                parameters.Add("@create_user", interviewStatusModel.create_user, DbType.String);
                //parameters.Add("@create_date", interviewStatusModel.create_date, DbType.DateTime);

                var result = _dapper.Insert<string>(StoreProcedureName.InsertInterviewStatus, parameters, CommandType.StoredProcedure);
                return result;
            }
            catch (Exception ex)
            {
				throw new Exception("FAILED TO INSERT INTERVIEW STATUS.", ex);
            }
       }
        #endregion

        #region UpdateInterviewStatus
         public int UpdateInterviewStatus(InterviewStatusModel interviewStatusModel)
         {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@StatusID", interviewStatusModel.StatusID, DbType.Int32);
                parameters.Add("@Name", interviewStatusModel.Name, DbType.String);
                //parameters.Add("@IsDeleted", interviewStatusModel.IsDeleted, DbType.Boolean);
                parameters.Add("@change_user", interviewStatusModel.change_user, DbType.String);
                //parameters.Add("@change_date", interviewStatusModel.change_date, DbType.DateTime);

                var result = _dapper.Execute(StoreProcedureName.UpdateInterviewStatus, parameters, CommandType.StoredProcedure);
                return result;
            }
            catch (Exception ex) 
            {
                throw new Exception("FAILED TO UPDATE INTERVIEW STATUS.", ex);
            }
         }
        #endregion

        #region DeleteInterviewStatus
        public int DeleteInterviewStatusById(InterviewStatusModel StatusID)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@StatusID", StatusID.StatusID, DbType.Int32);

                var result = _dapper.Execute(StoreProcedureName.DeleteInterviewStatus, parameters, CommandType.StoredProcedure);
                return result;
            }
            catch (Exception ex)
            {
                throw new Exception("FAILED TO DELETE INTERVIEW STATUS.", ex);
            }
        }
        #endregion
    }
}