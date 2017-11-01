using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace tBOT.Services.API.Test
{
    public class TestRequest
    {
        public string ApiEndPoint { get; set; }
        public string TestCaseName { get; set; }
        public string TestCaseCondition { get; set; }
    }
}