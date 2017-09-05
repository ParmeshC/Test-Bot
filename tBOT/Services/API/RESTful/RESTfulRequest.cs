
using tBOT.Services.API.Test;

namespace tBOT.Services.API.RESTful
{
    public class RESTfulRequest
    {
        public TestEnvironment Environment { get; set; }
        public TestAuthorization Authorization { get; set; }
        public string Accept { get; set; }
        public string ContentType { get; set; }
        public string LanguageCode { get; set; }
        public string RequestMethod { get; set; }
        public string RequestUrl { get; set; }
        public string RequestBody { get; set; }
        public string EndPoint { get; set; }


    }
}