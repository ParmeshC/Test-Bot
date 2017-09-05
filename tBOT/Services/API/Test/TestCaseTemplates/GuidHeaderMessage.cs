        using System;
using tBOT.Services.API.RESTful;

namespace tBOT.Services.API.Test
{
    public class GuidHeaderMessage : TestCaseTemplate, ITestCaseTemplate<GuidHeaderMessageCondition, GuidHeaderMessageResult>
    {
        public GuidHeaderMessageResult Execute(GuidHeaderMessageCondition condition)
        {

            RESTfulRequestResponse requestResponse = new RESTfulRequestResponse();
            requestResponse = RESTfulOperation.GetRequestResponse(condition.Request);

            GuidHeaderMessageResult result = new GuidHeaderMessageResult
            {
                Status = false,
                ExpectedGuidHeaderMessage = "Details for the " + SingularizeEndPoint(condition.Request.EndPoint) + " resource"
            };
            if (requestResponse.Response.StatusCode == 200)
            {
                result.Guid = GetResponseFieldValue(requestResponse.Response.ResponseArray, 1, "id");
                condition.Request.RequestUrl= condition.Request.RequestUrl + @"/" + result.Guid;

                result.Response = RESTfulOperation.GetResponse(condition.Request);
                result.GuidHeaderMessage = GetResponseHeaderValue(result.Response.ResponseHeaders, "X-hedtech-message");
                result.Status = CheckHeaderMessage(result.GuidHeaderMessage, result.ExpectedGuidHeaderMessage);
                
            }

            return result;
        }
    }
    public class GuidHeaderMessageResult : ITestCaseResult
    {
        public string Guid { get; set; }
        public string GuidHeaderMessage { get; set; }
        public string ExpectedGuidHeaderMessage { get; set; }
        public RESTfulResponse Response { get; set; }

        public Boolean Status { get; set; }
    }
    public class GuidHeaderMessageCondition: ITestCaseCondition
    {
        public RESTfulRequest Request { get; set; }

    }
}