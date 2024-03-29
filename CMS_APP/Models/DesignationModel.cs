﻿using CMS.Services;
using System.ComponentModel.DataAnnotations;
using System.Reflection;

namespace CMS.Models
{
  
    public class DesignationModel
    {
        public int DesignationID { get; set; }
        public string ? Designation { get; set; }
        public string ?create_User { get; set; }
        public DateTime ?create_Date { get; set; }
        public string? Change_user { get; set; }
        public DateTime? change_Date { get; set; }
        public bool IsDelete { get; set; } = false;
    }
	public class DesignationViewModel
	{
		public List<DesignationModel>? Designations { get; set; }
		public AllPaginationModel? PaginationModel { get; set; }
	}
}
