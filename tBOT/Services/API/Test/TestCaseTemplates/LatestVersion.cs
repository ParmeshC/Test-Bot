using System;
using System.Text.RegularExpressions;
using tBOT.Services.API.RESTful;

namespace tBOT.Services.API.Test
{
    public class LatestVersion : TestCaseTemplate, ITestCaseTemplate<LatestVersionCondition, LatestVersionResult>
    {
        private string VersionFormat(string ExpectedVersion)
        {
            return  "v" + Regex.Match(ExpectedVersion, @"\d+$").Value + "+json";
            
        }


        public LatestVersionResult Execute(LatestVersionCondition condition)
        {
            LatestVersionResult result = new LatestVersionResult
            {
                Status = false,
                Response = RESTfulOperation.GetResponse(condition.Request)
            };

            
        if (result.Response.StatusCode == 200)
            {
                result.LatestVersion = GetResponseHeaderValue(result.Response.ResponseHeaders, "X-hedtech-Media-Type");
                result.ExpectedLatestVersion = VersionFormat(condition.Version);
                result.Status = result.LatestVersion.Contains(result.ExpectedLatestVersion);
                
            }
            return result;
        }

    }
    public class LatestVersionResult: ITestCaseResult
    {
        public string LatestVersion { get; set; }
        public string ExpectedLatestVersion { get; set; }
        public RESTfulResponse Response { get; set; }
        public Boolean Status { get; set; }
    }
    public class LatestVersionCondition: ITestCaseCondition
    {
        public RESTfulRequest Request { get; set; }
        public string Version { get; set; }
    }
}