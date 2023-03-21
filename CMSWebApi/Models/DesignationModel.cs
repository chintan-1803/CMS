using Newtonsoft.Json;
using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace CMSWebApi.Models
{
    public class DesignationModel
    {
       public int  DesignationID { get; set; }
       public string ? Designation { get; set; }         
       public string ? create_User { get; set; }        
       public DateTime ? create_Date { get; set; }

       public string? Change_user { get; set; }         
       public DateTime ? change_Date { get; set; }  
       public bool IsDelete { get; set; } = false;
    }
   
}
