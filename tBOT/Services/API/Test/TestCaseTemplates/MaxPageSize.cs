using Newtonsoft.Json.Linq;
using System;
using System.Linq;
using tBOT.Services.API.RESTful;

namespace tBOT.Services.API.Test
{
    public class MaxPageSize : TestCaseTemplate, ITestCaseTemplate<MaxPageSizeCondition, MaxPageSizeResult>
    {
        public MaxPageSizeResult Execute(MaxPageSizeCondition condition)
        {
            MaxPageSizeResult result = new MaxPageSizeResult
            {
                Status = false,
                Response = RESTfulOperation.GetResponse(condition.Request)

            };
            if (result.Response.StatusCode == 200)
            {
                result.MaxPageSize = int.Parse(GetResponseHeaderValue(result.Response.ResponseHeaders, "X-hedtech-pageMaxSize"));
                JObject[] PageItems = result.Response.ResponseArray.Select(jv => (JObject)jv).ToArray();
                result.JsonObjectsInPage = PageItems.Length;
                result.Status = result.JsonObjectsInPage== result.MaxPageSize;
                if (result.JsonObjectsInPage<result.MaxPageSize)
                {
                    result.ApiTotalCount = int.Parse(GetResponseHeaderValue(result.Response.ResponseHeaders, "X-Total-Count"));                    
                    result.Status = result.JsonObjectsInPage == result.ApiTotalCount;
                }
            }
            return result;
        }
    }
    public class MaxPageSizeResult: ITestCaseResult
    {
        public int MaxPageSize { get; set; }
        public int JsonObjectsInPage { get; set; }
        public int ApiTotalCount { get; set; }
        public RESTfulResponse Response { get; set; }
        public Boolean Status { get; set; }
    }

    public class MaxPageSizeCondition:ITestCaseCondition
    {
        public RESTfulRequest Request { get; set; }
    }
}