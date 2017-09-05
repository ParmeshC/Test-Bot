using System;
using tBOT.Services.API.RESTful;

namespace tBOT.Services.API.Test
{
    public class TotalCount : TestCaseTemplate, ITestCaseTemplate<TotalCountCondition, TotalCountResult>
    {
        public TotalCountResult Execute(TotalCountCondition condition)
        {

            TotalCountResult result = new TotalCountResult
            {
                Status = false,
                Response = RESTfulOperation.GetResponse(condition.Request)

            };

            if (result.Response.StatusCode == 200)
            {
                result.ApiTotalCount = int.Parse(GetResponseHeaderValue(result.Response.ResponseHeaders, "X-Total-Count"));
            }
            return result;
        }
    }
    public class TotalCountResult: ITestCaseResult
    {
        public int ApiTotalCount { get; set; }
        public int DBTotalCount { get; set; }
        public RESTfulResponse Response { get; set; }
        public Boolean Status { get; set; }
    }

    public class TotalCountCondition:ITestCaseCondition
    {
        public RESTfulRequest Request { get; set; }
        public string TotalCountQuery { get; set; }
    }
}