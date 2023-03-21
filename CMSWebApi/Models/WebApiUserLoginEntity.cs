using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace CMS.Models
{
    public class WebApiUserLoginEntity
    {
        [Display(Name = "Email")]
        [Required(ErrorMessage = "Email is required")]
        [RegularExpression("^[a-zA-Z0-9_\\.-]+@([a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$", ErrorMessage = "Please enter valid Email.")]
        //[EmailAddress(ErrorMessage = "Please enter valid Email.")]
        public string Email { set; get; }

        [Display(Name = "Password")]
        [Required(ErrorMessage = "Password is required")]
        [DataType(DataType.Password)]
        [RegularExpression("([a-z]|[A-Z]|[0-9]|[\\W]){4}[a-zA-Z0-9\\W]{3,11}", ErrorMessage = "Please enter valid password format")]        
        public string Password { set; get; }
    }
}
