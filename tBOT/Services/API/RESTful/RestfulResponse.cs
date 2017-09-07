using Newtonsoft.Json.Linq;
using System.Collections.Generic;

namespace tBOT.Services.API.RESTful
{
    public class RESTfulResponse
    {
        public JArray ResponseArray { get; set; }
        public dynamic ResponseBody { get; set; }
        public KeyValuePair<string, IEnumerable<string>>[] ResponseHeaders { get; set; }
        public int StatusCode { get; set; }
        public string ResponsePhrase { get; set; }
        public string ErrorMessage { get; set; }
        public string Description { get; set; }
    }

}