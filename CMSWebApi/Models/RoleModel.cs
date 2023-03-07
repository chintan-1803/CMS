using Newtonsoft.Json;

namespace CMSWebApi.Models
{
    public class RoleModel
    {
        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public string create_User { get; set; }
        public DateTime create_Date { get; set; }
        public string Change_user { get; set; }
        public DateTime change_Date { get; set; }
        public bool IsDelete { get; set; }
    }
}
