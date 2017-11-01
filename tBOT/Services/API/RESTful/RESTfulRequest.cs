
using tBOT.Services.API.Test;

namespace tBOT.Services.API.RESTful
{
    public class RESTfulRequest
    {
        public string AuthType { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Accept { get; set; }
        public string ContentType { get; set; }
        public string LanguageCode { get; set; }
        public string RequestMethod { get; set; }
        public string RequestUrl { get; set; }
        public string RequestBody { get; set; }
        public string EndPoint { get; set; }
        public string EndPointObjectId { get; set; }
    }
}