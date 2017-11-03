using System;
using tBOT.Services.API.RESTful;

namespace tBOT.Services.API.Test
{
    public class CRUDvalidation : TestCaseTemplate, ITestCaseTemplate<CRUDvalidationCondition, CRUDvalidationResult>
    {
        public CRUDvalidationResult Execute(CRUDvalidationCondition condition)
        {
            DataAccess DtAcss = new DataAccess();
            DataConnection dtcon = new DataConnection();
            dtcon.HostName = condition.DBHostName;
            dtcon.PortNumber = condition.DBPortNumber;
            dtcon.ServiceName = condition.DBServiceName;
            dtcon.UserId = condition.DBUserId;
            dtcon.Password = condition.DBPassword;

            CRUDvalidationResult result = new CRUDvalidationResult
            {
                Status = false
            };

            int insertReturnValue = DtAcss.InsertIntoDB(condition.InsertQuery,condition.GuidField, dtcon);
            if(insertReturnValue!=-1)
            {
                result.Response = RESTfulOperation.GetResponse(condition.Request);
            }


            //int updateReturnValue = DtAcss.UpdateInDB(condition.UpdateQuery, dtcon);

            int deleteReturnValue = DtAcss.DeleteFromDB(condition.DeleteQuery, dtcon);

            







            //if (result.Response.StatusCode == 200)
            //{
            //    result.ApiTotalCount = int.Parse(GetResponseHeaderValue(result.Response.ResponseHeaders, "X-Total-Count"));
            //    string count = DtAcss.GetTotalCout(condition.InsertQuery, dtcon);
            //        if (count!=null)
            //    {
            //        result.DBTotalCount = Int32.Parse(count);
            //        result.Status = result.DBTotalCount == result.ApiTotalCount;
            //    }              

            //}


            return result;
        }
    }
    public class CRUDvalidationResult: ITestCaseResult
    {
        public int ApiTotalCount { get; set; }
        public int DBTotalCount { get; set; }
        public RESTfulResponse Response { get; set; }
        public Boolean Status { get; set; }
    }

    public class CRUDvalidationCondition : ITestCaseCondition
    {
        public RESTfulRequest Request { get; set; }
        public string InsertQuery { get; set; }
        public string GuidField { get; set; }
        public string UpdateQuery { get; set; }
        public string DeleteQuery { get; set; }
        public string DBHostName { get; set; }
        public string DBPortNumber { get; set; }
        public string DBServiceName { get; set; }
        public string DBUserId { get; set; }
        public string DBPassword { get; set; }

    }
}