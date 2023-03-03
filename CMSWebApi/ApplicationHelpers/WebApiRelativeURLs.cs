using CMS.Models;

namespace CMS.ApplicationHelpers
{
    public class WebApiRelativeURLs
    {
        /// <summary>
        /// Base URL based on environment is set here: Refer program.cs for set or change 
        /// </summary>
        public static string BaseURL = string.Empty;

        public const string LoginPath = "/LoginApi/authenticate";
    }
}
