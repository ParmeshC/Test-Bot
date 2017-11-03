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

            DataAccess DtAcss = new DataAccess();

            DataConnection dtcon = new DataConnection();
            dtcon.HostName = condition.DBHostName;
            dtcon.PortNumber = condition.DBPortNumber;
            dtcon.ServiceName = condition.DBServiceName;
            dtcon.UserId = condition.DBUserId;
            dtcon.Password = condition.DBPassword;



            if (result.Response.StatusCode == 200)
            {
                result.ApiTotalCount = int.Parse(GetResponseHeaderValue(result.Response.ResponseHeaders, "X-Total-Count"));
                string count = DtAcss.GetTotalCout(condition.TotalCountQuery, dtcon);
                    if (count!=null)
                {
                    result.DBTotalCount = Int32.Parse(count);
                    result.Status = result.DBTotalCount == result.ApiTotalCount;
                }

                

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
        public string DBHostName { get; set; }
        public string DBPortNumber { get; set; }
        public string DBServiceName { get; set; }
        public string DBUserId { get; set; }
        public string DBPassword { get; set; }

    }
}