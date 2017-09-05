using System;
using System.Globalization;
using tBOT.Services.API.RESTful;

namespace tBOT.Services.API.Test
{
    public class InvalidGuidHeaderMessage : TestCaseTemplate, ITestCaseTemplate<InvalidGuidHeaderMessageCondition, InvalidGuidHeaderMessageResult>
    {
        public InvalidGuidHeaderMessageResult Execute(InvalidGuidHeaderMessageCondition condition)
        {


            TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;

            InvalidGuidHeaderMessageResult result = new InvalidGuidHeaderMessageResult
            {
                Status = false,
                ExpectedInvalidGuidHeaderMessage = textInfo.ToTitleCase(SingularizeEndPoint(condition.Request.EndPoint).Replace("-", " ")) + " not found",
                InvalidGuid = "invalid-Guid-0123"
            };
            
                condition.Request.RequestUrl = condition.Request.RequestUrl + @"/" + result.InvalidGuid;
                result.Response = RESTfulOperation.GetResponse(condition.Request);

                result.InvalidGuidHeaderMessage = GetResponseHeaderValue(result.Response.ResponseHeaders, "X-hedtech-message");
                result.Status = CheckHeaderMessage(result.InvalidGuidHeaderMessage, result.ExpectedInvalidGuidHeaderMessage);
                return result;
        }

    }
    public class InvalidGuidHeaderMessageResult : ITestCaseResult
    {
        public string InvalidGuid { get; set; }
        public string InvalidGuidHeaderMessage { get; set; }
        public string ExpectedInvalidGuidHeaderMessage { get; set; }
        public RESTfulResponse Response { get; set; }
        public Boolean Status { get; set; }
    }

    public class InvalidGuidHeaderMessageCondition : ITestCaseCondition
    {        
        public RESTfulRequest Request { get; set; }
    }
}