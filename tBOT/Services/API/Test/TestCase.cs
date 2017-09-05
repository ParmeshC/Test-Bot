using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace tBOT.Services.API.Test
{

    public interface ITestCaseCondition
    {

    }

    public interface ITestCaseResult
    {
        Boolean Status { get; }
    }



    public class TestCase
    {
        public string ApiEndPoint { get; set; }
        public string TestCaseName { get; set; }
        public ITestCaseCondition TestCaseCondition { get; set; }
        public ITestCaseResult TestCaseResult { get; set; }

    }
}