using System;
using tBOT.Services.API.RESTful;

namespace tBOT.Services.API.Test
{
    public class ListHeaderMessage : TestCaseTemplate, ITestCaseTemplate<ListHeaderMessageCondition, ListHeaderMessageResult>
    {
        public ListHeaderMessageResult Execute(ListHeaderMessageCondition condition)
        {

            ListHeaderMessageResult result = new ListHeaderMessageResult
            {
                Status = false,
                ExpectedListHeaderMessage = "List of " + SingularizeEndPoint(condition.Request.EndPoint) + " resources",
                Response = RESTfulOperation.GetResponse(condition.Request)
            };


            if (result.Response.StatusCode == 200)
            {
                result.ListHeaderMessage = GetResponseHeaderValue(result.Response.ResponseHeaders, "X-hedtech-message");
                result.Status = CheckHeaderMessage(result.ListHeaderMessage, result.ExpectedListHeaderMessage);
            }
            return result;
        }
    }
    public class ListHeaderMessageResult : ITestCaseResult
    {
        public string ListHeaderMessage { get; set; }
        public string ExpectedListHeaderMessage { get; set; }
        public RESTfulResponse Response { get; set; }
        public Boolean Status { get; set; }
    }
    public class ListHeaderMessageCondition: ITestCaseCondition
    {
        public RESTfulRequest Request { get; set; }

    }
}