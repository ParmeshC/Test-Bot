using Newtonsoft.Json.Linq;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization.Formatters.Binary;
using System.Threading.Tasks;
using System.Threading.Tasks.Dataflow;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using tBOT.Services.API.RESTful;

namespace tBOT.Services.API.Test
{
    public class OffsetValidation : TestCaseTemplate, ITestCaseTemplate<OffsetValidationCondition, OffsetValidationResult>
    {
        public OffsetValidationResult Execute(OffsetValidationCondition condition)
        {
            OffsetValidationResult result = new OffsetValidationResult
            {
                Status = false,
                Response = RESTfulOperation.GetResponse(condition.Request)
            };
            List<OffsetInfo> OffsetInfoList = new List<OffsetInfo>();
            if (result.Response.StatusCode == 200)
            {
                int pagemaxsize;
                int.TryParse(GetResponseHeaderValue(result.Response.ResponseHeaders, "X-Max-Page-Size"),out pagemaxsize);
                result.Pagemaxsize = pagemaxsize;

                int totalcount=0;
                int.TryParse(GetResponseHeaderValue(result.Response.ResponseHeaders, "X-Total-Count"),out totalcount);
                result.Totalcount = totalcount;

                if(result.Totalcount>0)
                {
                    int offsetCountLowRange = 0;

                    int offsetCountHighRange = pagemaxsize < totalcount ? (1 + (totalcount - 1) / pagemaxsize) : 0;                    
                    //offsetCountHighRange = 1000;

                    //List<int> offsetCountList = Enumerable.Range(offsetCountLowRange, offsetCountHighRange).Select(i => i * pagemaxsize).ToList();
                    List<RESTfulRequest> requestList = new List<RESTfulRequest>();

                   for (int i = offsetCountLowRange; i < offsetCountHighRange; i++)
                    {
                        requestList.Add( new RESTfulRequest
                        {
                            AuthType=condition.Request.AuthType,
                            UserName = condition.Request.UserName,
                            Password = condition.Request.Password,
                            Accept = condition.Request.Accept,
                            ContentType = condition.Request.ContentType,
                            LanguageCode = condition.Request.LanguageCode,
                            RequestMethod = condition.Request.RequestMethod,
                            RequestUrl = condition.Request.RequestUrl + @"?offset=" + i * pagemaxsize,
                            RequestBody = condition.Request.RequestBody,
                            EndPoint = condition.Request.EndPoint,
                            EndPointObjectId = condition.Request.EndPointObjectId
                        });
                    }


                    OffsetInfoList = GetOffsetInfo(requestList).ToList();
                }

            }
            int passNoCount = OffsetInfoList.Count(p => p.Pass=="No");
            if (passNoCount ==0) { result.Status = true; }
            result.OffsetInfo = OffsetInfoList;
            result.NumberOfPages = OffsetInfoList.Count;
            //result.IDFields = idFieldValues.OrderBy(o => o.PageOffset).ToList();

            //Convert the concurrentBag to list and flatten the list of lists
            var idFieldValuesList = idFieldValuesBag.ToList().SelectMany(x => x).ToList();

            result.NumberOfIDFields = idFieldValuesList.Count;
            var DuplicateIDsList = idFieldValuesList.GroupBy(c => c.ID).Where(g => g.Skip(1).Any()).SelectMany(c => c);
            result.DuplicateIDs = DuplicateIDsList.GroupBy(u => u.ID).Select(grp => grp.ToList()).ToList();
            result.NumberOfDuplicateIDs = result.DuplicateIDs.Count;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            serializer.MaxJsonLength = int.MaxValue; // The value of this constant is 2,147,483,647
            var requestResponseListJson = serializer.Serialize(ResponseBodyBag.ToList());

            //string path = Server.MapPath("~/App_Data/");

            string path = Path.GetTempPath();

            var fileName = condition.Request.EndPoint+ "_OffsetValidationRequestResponse_" + DateTime.Now.ToString("ddMMyyHHmmss")+".json";

            // Write that JSON to txt file,
            File.WriteAllText(path + fileName, requestResponseListJson);


            return result;
        }

        private static ConcurrentBag<List<OffsetIds>> idFieldValuesBag = new ConcurrentBag<List<OffsetIds>>();
        private static ConcurrentBag<dynamic> ResponseBodyBag = new ConcurrentBag<dynamic>();


        public static ConcurrentBag<OffsetInfo> GetOffsetInfo(List<RESTfulRequest> RequestList)
        {
            //ServicePointManager.DefaultConnectionLimit = 20;
            ConcurrentBag<OffsetInfo> infoBag = new ConcurrentBag<OffsetInfo>();
            //var blockOptions = new ExecutionDataflowBlockOptions { MaxDegreeOfParallelism = 10 };
            Parallel.ForEach(RequestList, new ParallelOptions { MaxDegreeOfParallelism = 4 }, (requestItem) =>
            //foreach (var requestItem in RequestList)
            {
                var Response = RESTfulOperation.GetResponse(requestItem);

                OffsetInfo info = new OffsetInfo();
                info.OffsetUrl = requestItem.RequestUrl;
                info.ResponseStatus = Response.StatusCode + ", " + Response.ResponsePhrase;

                int headerPageoffsetValue;
                int.TryParse(GetResponseHeaderValue(Response.ResponseHeaders, "X-hedtech-pageOffset"), out headerPageoffsetValue);
                if (Response.ResponseArray != null)
                {
                    info.ItemCount = 0;
                    idFieldValuesBag.Add(GetByFieldNameInJsonArray(Response.ResponseArray, "id", headerPageoffsetValue));
                }
                info.TimeTakenInMs = Response.TimeTakenInMs;
                ResponseBodyBag.Add(Response.ResponseBody);

                int urlOffsetNumber = -1;
                var splitArry = info.OffsetUrl.Split(new[] { "?offset=" }, StringSplitOptions.None);
                if (splitArry.Length > 1)
                {
                    int.TryParse(splitArry[1], out urlOffsetNumber);
                }
                info.Pass = Response.StatusCode == 200 ? "Yes" : "No";
                infoBag.Add(info);
            });
        //};

            //ServicePointManager.DefaultConnectionLimit = 20;
            //var workerBlock = new System.Threading.Tasks.Dataflow.ActionBlock<RESTfulRequest>(requestItem =>
            //{
            //    var Response = RESTfulOperation.GetResponse(requestItem);

            //    OffsetInfo info = new OffsetInfo();
            //    info.OffsetUrl = requestItem.RequestUrl;
            //    info.ResponseStatus = Response.StatusCode + ", " + Response.ResponsePhrase;

            //    int headerPageoffsetValue;
            //    int.TryParse(GetResponseHeaderValue(Response.ResponseHeaders, "X-hedtech-pageOffset"), out headerPageoffsetValue);
            //    if (Response.ResponseArray != null)
            //    {
            //        info.ItemCount = 0;
            //        idFieldValuesBag.Add(GetByFieldNameInJsonArray(Response.ResponseArray, "id", headerPageoffsetValue));
            //    }
            //    info.TimeTakenInMs = Response.TimeTakenInMs;
            //    ResponseBodyBag.Add(Response.ResponseBody);

            //    int urlOffsetNumber = -1;
            //    var splitArry = info.OffsetUrl.Split(new[] { "?offset=" }, StringSplitOptions.None);
            //    if (splitArry.Length > 1)
            //    {
            //        int.TryParse(splitArry[1], out urlOffsetNumber);
            //    }
            //    info.Pass = Response.StatusCode == 200 ? "Yes" : "No";
            //    infoBag.Add(info);
            //}, new ExecutionDataflowBlockOptions { MaxDegreeOfParallelism = 10 });

            //foreach (var item in RequestList)
            //{
            //    workerBlock.Post(item);
            //}
            //workerBlock.Complete();

            return infoBag;
        }

        private static List<OffsetIds> GetByFieldNameInJsonArray(JArray JsonArray, string FieldName,int pageOffset )
        {
            List<OffsetIds> listOfIds = new List<OffsetIds>();
                JArray filteredObjects = new JArray();
            try
            {
                foreach (var token in JsonArray
                .Where(obj => obj[FieldName] != null))
                {
                    listOfIds.Add(new OffsetIds() { PageOffset = pageOffset, ID = token[FieldName].ToString() });

                 }
                   
                }
            catch (Exception)
            {


            }
            return listOfIds;
        }
        public static object ConvertJTokenToObject(JToken token)
        {
            if (token is JValue)
            {
                return ((JValue)token).Value;
            }
            if (token is JObject)
            {
                ExpandoObject expando = new ExpandoObject();
                (from childToken in ((JToken)token) where childToken is JProperty select childToken as JProperty).ToList().ForEach(property => {
                    ((IDictionary<string, object>)expando).Add(property.Name, ConvertJTokenToObject(property.Value));
                });
                return expando;
            }
            if (token is JArray)
            {
                object[] array = new object[((JArray)token).Count];
                int index = 0;
                foreach (JToken arrayItem in ((JArray)token))
                {
                    array[index] = ConvertJTokenToObject(arrayItem);
                    index++;
                }
                return array;
            }
            throw new ArgumentException(string.Format("Unknown token type '{0}'", token.GetType()), "token");
        }
    }    


    public class OffsetIds
    {
        public int PageOffset { get; set; }
        public string ID { get; set; }
    }

    public class OffsetInfo
    {
        public string OffsetUrl { get; set; }
        public int ItemCount  { get; set; }
        public string ResponseStatus { get; set; }
        public string TimeTakenInMs { get; set; }
        public string Pass { get; set; }
    }


    public class OffsetValidationResult : ITestCaseResult
    {
        public int Pagemaxsize { get; set; }
        public int Totalcount { get; set; }
        public int NumberOfPages { get; set; }  
        public int NumberOfIDFields { get; set; }
        public int NumberOfDuplicateIDs { get; set; } 
        public List<List<OffsetIds>> DuplicateIDs { get; set; }
        public List<OffsetInfo> OffsetInfo { get; set; }
        public RESTfulResponse Response { get; set; }

        public Boolean Status { get; set; }
    }
    public class OffsetValidationCondition : ITestCaseCondition
    {
        public RESTfulRequest Request { get; set; }


    }
}