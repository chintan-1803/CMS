namespace CMS.Models
{
    public class RoundModel
    {
        public int RoundID { get; set; }
        public string ?Round_Name { get; set; }
        public string ?create_User { get; set; }
        public DateTime ?create_Date { get; set; }
        public string ? Change_user { get; set; }
        public DateTime ? change_Date { get; set; }
        public bool IsDelete { get; set; }
    }
}
