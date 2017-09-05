using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace tBOT.Services.API.Test
{
    public class TestResponse
    {
        public string EndPoint { get; set; }
        public Boolean PassStatus { get { return PassCount == TotalCount ? true : false; } }
        public int PassCount { get; set; }
        public int TotalCount { get; set; }
        public List<TestCase> TestCasesList { get; set; }

    }
}