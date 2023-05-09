using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using CMSWebApi.Models;
using Dapper;
using Microsoft.Extensions.Configuration;



namespace CMSWebApi.Dapper
{
    public class Dappers : IDapper
    {
        private readonly IConfiguration _config;
        private readonly string Connectionstring = "DefaultConnection";

        public Dappers(IConfiguration config)
        {
            _config = config;
        }

        public DbConnection GetDbconnection()
        {
            return new SqlConnection(_config.GetConnectionString(Connectionstring));
        }

        public List<T> GetAll<T>(string sp, DynamicParameters parms, CommandType commandType = CommandType.StoredProcedure)
        {
            using IDbConnection db = GetDbconnection();
            return db.Query<T>(sp, parms, commandType: commandType, commandTimeout: 0).ToList();
        }

        public int Execute(string sp, DynamicParameters parms, CommandType commandType = CommandType.StoredProcedure)
        {
            using IDbConnection db = GetDbconnection();
            return db.Execute(sp, parms, commandType: commandType, commandTimeout: 0);
        }

        public T Get<T>(string sp, DynamicParameters parms, CommandType commandType = CommandType.Text)
        {
            using IDbConnection db = GetDbconnection();
            return db.Query<T>(sp, parms, commandType: commandType, commandTimeout: 0).FirstOrDefault();
        }

        public T Insert<T>(string sp, DynamicParameters parms, CommandType commandType = CommandType.StoredProcedure)
        {
            T result;
            using IDbConnection db = GetDbconnection();
            try

            {
                if (db.State == ConnectionState.Closed)
                    db.Open();

                using var tran = db.BeginTransaction();
                try
                {
                    result = db.Query<T>(sp, parms, commandType: commandType, transaction: tran, commandTimeout: 0).FirstOrDefault();
                    tran.Commit();
                }
                catch (Exception)
                {
                    tran.Rollback();
                    throw;
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                if (db.State == ConnectionState.Open)
                    db.Close();
            }

            return result;
        }

		// using IDbConnection db = GetDbconnection();
		//var data = db.QueryMultiple("ESP_GetDocumentCertificate", parms, commandType: CommandType.StoredProcedure);
		//public List<T> GetAllMaster<T>(string sp, DynamicParameters parms, CommandType commandType = CommandType.StoredProcedure)
		//{
		//	using IDbConnection db = GetDbconnection();
		//          return db.QueryMultiple(sp, parms, commandType: commandType);
		//}

		//public List<object> GetAll(string sp, DynamicParameters parms, CommandType commandType = CommandType.StoredProcedure)
		//{
		//    using IDbConnection db = GetDbconnection();
		//    var results = new List<object>();
		//    var reader = db.QueryMultiple(sp, parms, commandType: commandType);
		//    while (!reader.IsConsumed)
		//    {
		//        results.Add(reader.Read<object>());
		//    }
		//    return results;
		//}

		public (List<DesignationModel>, List<ReasonModel>, List<RoleModel>, List<RoundModel>, List<TechnologyModel>, List<InterviewStatusModel>, List<InterviewerModel>, List<CandidateMasterEntity>, List<RoundStatusModel>) GetAllMasterData(string sp, DynamicParameters parms, CommandType commandType = CommandType.StoredProcedure)
		{
			using IDbConnection db = GetDbconnection();
			List<DesignationModel> DesignationData;
			List<ReasonModel> ReasonData;
			List<RoleModel> RoleData;
			List<RoundModel> RoundData;
			List<TechnologyModel> TechnologyData;
			List<InterviewStatusModel> InterviewStatusData;
			List<InterviewerModel> InterviewerData;
			List<CandidateMasterEntity> CandidateMasterData;
			List<RoundStatusModel> RoundStatusData;



			using (var reader = db.QueryMultiple(sp, parms, commandType: commandType))
			{
				DesignationData = reader.Read<DesignationModel>().ToList();
				ReasonData = reader.Read<ReasonModel>().ToList();
				RoleData = reader.Read<RoleModel>().ToList();
				RoundData = reader.Read<RoundModel>().ToList();
				TechnologyData = reader.Read<TechnologyModel>().ToList();
				InterviewStatusData = reader.Read<InterviewStatusModel>().ToList();
				InterviewerData = reader.Read<InterviewerModel>().ToList();
				CandidateMasterData = reader.Read<CandidateMasterEntity>().ToList();
				RoundStatusData = reader.Read<RoundStatusModel>().ToList();
			}
			return (DesignationData, ReasonData, RoleData, RoundData, TechnologyData, InterviewStatusData, InterviewerData, CandidateMasterData, RoundStatusData);
		}




	}
}
