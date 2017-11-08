using Newtonsoft.Json.Linq;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Threading.Tasks;
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
                    OffsetInfoList = GetOffsetInfo(requestList);
                }

            }
            int passNoCount = OffsetInfoList.Count(p => p.Pass=="No");
            if (passNoCount ==0) { result.Status = true; }
            result.OffsetInfo = OffsetInfoList;
            result.NumberOfPages = OffsetInfoList.Count;
            result.IDFields = idFieldValues.OrderBy(o => o.PageOffset).ToList();
            result.NumberOfIDFields = idFieldValues.Count;
            var DuplicateIDsList = idFieldValues.GroupBy(c => c.ID).Where(g => g.Skip(1).Any()).SelectMany(c => c);
            result.DuplicateIDs = DuplicateIDsList.GroupBy(u => u.ID).Select(grp => grp.ToList()).ToList();
            result.NumberOfDuplicateIDs = result.DuplicateIDs.Count;

            return result;
        }
        private static List<OffsetIds> idFieldValues = new List<OffsetIds>();

        private static List<OffsetInfo> GetOffsetInfo(List<RESTfulRequest> RequestList)
        {
            List<OffsetInfo> infoList = new List<OffsetInfo>();
            
            Parallel.ForEach(RequestList, (requestItem) =>
            {
                var RequestResponse = RESTfulOperation.GetRequestResponse(requestItem);

                OffsetInfo info = new OffsetInfo();
                info.OffsetUrl = requestItem.RequestUrl;
                info.ResponseStatus= RequestResponse.Response.StatusCode +", "+ RequestResponse.Response.ResponsePhrase;

                int headerPageoffsetValue;
                int.TryParse(GetResponseHeaderValue(RequestResponse.Response.ResponseHeaders, "X-hedtech-pageOffset"), out headerPageoffsetValue);
                var idFields = GetByFieldNameInJsonArray(RequestResponse.Response.ResponseArray, "id", headerPageoffsetValue);
                idFieldValues.AddRange(idFields);

                int urlOffsetNumber=-1;
                var splitArry = info.OffsetUrl.Split(new[] { "?offset=" }, StringSplitOptions.None);
                if(splitArry.Length>1)
                {
                    int.TryParse(splitArry[1], out urlOffsetNumber);
                }
                info.ItemCount = idFields.Count;
                info.Pass = RequestResponse.Response.StatusCode == 200 ? "Yes" : "No";
                infoList.Add(info);
            });

            //Inserted for Duplicate Check
            idFieldValues.Add(new OffsetIds() { PageOffset = 2500, ID = "5561b8ff-17bf-475c-9844-10c1a0524a31" });
            idFieldValues.Add(new OffsetIds() { PageOffset = 3500, ID = "3554940a-1961-44e4-b63a-8b02299aa2a6" });
            idFieldValues.Add(new OffsetIds() { PageOffset = 500, ID = "3554940a-1961-44e4-b63a-8b02299aa2a6" });

            return infoList.OrderBy(o => o.OffsetUrl).ToList();
        }


        public int Pageoffset { get; set; }
        private static List<OffsetIds> GetByFieldNameInJsonArray(JArray JsonArray, string FieldName,int pageOffset )
        {
            List<OffsetIds> listOfIds = new List<OffsetIds>();
            
            JArray filteredObjects = new JArray();

            foreach (JToken token in JsonArray
                .Where(obj => obj[FieldName] != null))
            {
                listOfIds.Add(new OffsetIds() { PageOffset=pageOffset, ID=token[FieldName].ToString() });
            }
            return listOfIds;
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
        public string Pass { get; set; }
    }


    public class OffsetValidationResult : ITestCaseResult
    {
        public int Pagemaxsize { get; set; }
        public int Totalcount { get; set; }
        public int NumberOfPages { get; set; }  
        public int NumberOfIDFields { get; set; }
        public int NumberOfDuplicateIDs { get; set; }              
        public List<OffsetInfo> OffsetInfo { get; set; }        
        public List<List<OffsetIds>> DuplicateIDs { get; set; }
        public List<OffsetIds> IDFields { get; set; }
        public RESTfulResponse Response { get; set; }

        public Boolean Status { get; set; }
    }
    public class OffsetValidationCondition : ITestCaseCondition
    {
        public RESTfulRequest Request { get; set; }


    }
}