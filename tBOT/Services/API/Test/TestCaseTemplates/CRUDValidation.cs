using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Web.Script.Serialization;
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

            result.InsertGuidLinkFieldValue = DtAcss.InsertIntoDB(condition.InsertQuery,condition.InsertGuidLinkField, dtcon);
            if(!string.IsNullOrEmpty(result.InsertGuidLinkFieldValue))
            {
                result.DBGuid= DtAcss.GetGuidInDB(condition.GuidQuery, condition.InsertGuidLinkField, result.InsertGuidLinkFieldValue, dtcon);
                result.Status = true;
                result.Response = RESTfulOperation.GetResponse(condition.Request);

                //result.Guid = GetResponseFieldValue(requestResponse.Response.ResponseArray, 1, "id");
                //result.Response.ResponseBody
                JArray filteredJArray = FilterFieldValueInJsonArray(result.Response.ResponseArray,"id", result.DBGuid);
                result.NumberOfGuidsFound = filteredJArray.Count;

                result.ObjectList = ToDynamicList(filteredJArray);
                //result.ObjectList = new JavaScriptSerializer().Deserialize<dynamic>(jTokenList);
                //result.ObjectList = jTokenList;
                int deleteReturnValue = DtAcss.DeleteFromDB(condition.DeleteQuery, dtcon);
                result.InsertionDeleted = "No";
                if (deleteReturnValue>-1)
                {
                    result.InsertionDeleted = "Yes";
                }
            }

            return result;
        }

        public static IList<dynamic> ToDynamicList(JArray data)
        {
            var dynamicData = new List<dynamic>();
            var expConverter = new ExpandoObjectConverter();

            foreach (var dataItem in data)
            {
                dynamic obj = JsonConvert.DeserializeObject<ExpandoObject>(dataItem.ToString(), expConverter);
                dynamicData.Add(obj);
            }
            return dynamicData;
        }
    }
    public class CRUDvalidationResult: ITestCaseResult
    {
        public string InsertGuidLinkFieldValue { get; set; }
        public string DBGuid { get; set; }
        public int NumberOfGuidsFound { get; set; }
        public IList<dynamic> ObjectList { get; set; }
        public string InsertionDeleted { get; set; }
        public RESTfulResponse Response { get; set; }
        public Boolean Status { get; set; }
    }

    public class CRUDvalidationCondition : ITestCaseCondition
    {
        public RESTfulRequest Request { get; set; }
        public string InsertQuery { get; set; }
        public string GuidQuery { get; set; }
        public string InsertGuidLinkField { get; set; }
        public string UpdateQuery { get; set; }
        public string DeleteQuery { get; set; }
        public string DBHostName { get; set; }
        public string DBPortNumber { get; set; }
        public string DBServiceName { get; set; }
        public string DBUserId { get; set; }
        public string DBPassword { get; set; }

    }
}