using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using tBOT.Services.API.RESTful;

namespace tBOT.Services.API.Test
{
    public class GetTotalRecordsByOffset : TestCaseTemplate, ITestCaseTemplate<GetTotalRecordsByOffsetCondition, GetTotalRecordsByOffsetResult>
    {
        public GetTotalRecordsByOffsetResult Execute(GetTotalRecordsByOffsetCondition condition)
        {
            GetTotalRecordsByOffsetResult result = new GetTotalRecordsByOffsetResult
            {
                Status = false,
                Response = RESTfulOperation.GetResponse(condition.Request)
            };

            if (result.Response.StatusCode == 200)
            {
                int pagemaxsize;
                int.TryParse(GetResponseHeaderValue(result.Response.ResponseHeaders, "x-hedtech-pagemaxsize"),out pagemaxsize);
                result.Pagemaxsize = pagemaxsize;

                int totalcount;
                int.TryParse(GetResponseHeaderValue(result.Response.ResponseHeaders, "x-hedtech-totalcount"),out totalcount);
                result.Totalcount = totalcount;

                if(result.Totalcount>0)
                {
                    int offsetCountLowRange = 0;
                    int offsetCountHighRange = pagemaxsize<totalcount? (totalcount / pagemaxsize): totalcount;
                    List<int> offsetCountList = Enumerable.Range(offsetCountLowRange, offsetCountHighRange).Select(i => i + pagemaxsize).ToList();

                    List<OffsetInfo> OffsetInfoList = new List<OffsetInfo>();

                    Parallel.ForEach(offsetCountList, (pageoffset) =>
                    {
                        OffsetInfo info = new OffsetInfo();
                        var newConditon = condition;
                        newConditon.Request.RequestUrl = condition.Request.RequestUrl + @"?offset=" + pageoffset;
                        var response = RESTfulOperation.GetResponse(newConditon.Request);

                        info.OffsetUrl = newConditon.Request.RequestUrl;

                        int headerPageoffsetValue;
                        int.TryParse(GetResponseHeaderValue(response.ResponseHeaders, "x-hedtech-pageoffset"), out headerPageoffsetValue);
                        info.Pageoffset = headerPageoffsetValue;

                        OffsetInfoList.Add(info);

                    });
                }

            }
            return result;
        }
    }

    public class OffsetInfo
    {
        public string OffsetUrl { get; set; }
        public int Pageoffset { get; set; }

    }


    public class GetTotalRecordsByOffsetResult : ITestCaseResult
    {
        public int Pagemaxsize { get; set; }
        public int Totalcount { get; set; }
        public List<OffsetInfo> OffsetInfo { get; set; }
        public RESTfulResponse Response { get; set; }

        public Boolean Status { get; set; }
    }
    public class GetTotalRecordsByOffsetCondition : ITestCaseCondition
    {
        public RESTfulRequest Request { get; set; }


    }
}