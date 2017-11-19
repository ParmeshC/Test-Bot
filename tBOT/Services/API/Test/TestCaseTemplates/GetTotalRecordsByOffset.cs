using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Threading.Tasks.Dataflow;
using tBOT.Services.API.RESTful;

namespace tBOT.Services.API.Test
{
    public class GetTotalRecordsByOffset : TestCaseTemplate, ITestCaseTemplate<GetTotalRecordsByOffsetCondition, GetTotalRecordsByOffsetResult>
    {
        //public GetTotalRecordsByOffsetResult Execute(GetTotalRecordsByOffsetCondition condition)
        //{
        //    GetTotalRecordsByOffsetResult result = new GetTotalRecordsByOffsetResult
        //    {
        //        Status = false,
        //        Response = RESTfulOperation.GetResponse(condition.Request)
        //    };

        //    if (result.Response.StatusCode == 200)
        //    {
        //        int pagemaxsize;
        //        int.TryParse(GetResponseHeaderValue(result.Response.ResponseHeaders, "X-Max-Page-Size"),out pagemaxsize);
        //        result.Pagemaxsize = pagemaxsize;

        //        int totalcount;
        //        int.TryParse(GetResponseHeaderValue(result.Response.ResponseHeaders, "X-Total-Count"),out totalcount);
        //        result.Totalcount = totalcount;

        //        if(result.Totalcount>0)
        //        {
        //            int offsetCountLowRange = 0;
        //            int offsetCountHighRange = pagemaxsize<totalcount? (totalcount / pagemaxsize): totalcount;
        //            List<int> offsetCountList = Enumerable.Range(offsetCountLowRange, offsetCountHighRange).Select(i => i * pagemaxsize).ToList();

        //            List<OffsetInfo> OffsetInfoList = new List<OffsetInfo>();

        //            Parallel.ForEach(offsetCountList, (pageoffset) =>
        //            {
        //                OffsetInfo info = new OffsetInfo();
        //                GetTotalRecordsByOffsetCondition newConditon = new GetTotalRecordsByOffsetCondition();
        //                newConditon = condition;
        //                newConditon.Request.RequestUrl = condition.Request.RequestUrl + @"?offset=" + pageoffset;
        //                var response = RESTfulOperation.GetResponse(newConditon.Request);

        //                info.OffsetUrl = newConditon.Request.RequestUrl;

        //                int headerPageoffsetValue;
        //                int.TryParse(GetResponseHeaderValue(response.ResponseHeaders, "X-hedtech-pageOffset"), out headerPageoffsetValue);
        //                info.Pageoffset = headerPageoffsetValue;

        //                OffsetInfoList.Add(info);

        //            });
        //        }

        //    }
        //    return result;
        //}




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
                int.TryParse(GetResponseHeaderValue(result.Response.ResponseHeaders, "X-Max-Page-Size"), out pagemaxsize);
                result.Pagemaxsize = pagemaxsize;

                int totalcount;
                int.TryParse(GetResponseHeaderValue(result.Response.ResponseHeaders, "X-Total-Count"), out totalcount);
                result.Totalcount = totalcount;

                if (result.Totalcount > 0)
                {
                    int offsetCountLowRange = 0;
                    int offsetCountHighRange = pagemaxsize < totalcount ? (totalcount / pagemaxsize) : totalcount;
                    List<int> offsetCountList = Enumerable.Range(offsetCountLowRange, offsetCountHighRange).Select(i => i * pagemaxsize).ToList();

                    List<OffsetInfo> OffsetInfoList = new List<OffsetInfo>();

                    ServicePointManager.DefaultConnectionLimit = 20;
                    //var blockOptions = new ExecutionDataflowBlockOptions { MaxDegreeOfParallelism = 10 };
                    var workerBlock = new System.Threading.Tasks.Dataflow.ActionBlock<int>(pageoffset =>
                        {
                            OffsetInfo info = new OffsetInfo();
                            GetTotalRecordsByOffsetCondition newConditon = new GetTotalRecordsByOffsetCondition();
                            newConditon = condition;
                            newConditon.Request.RequestUrl = condition.Request.RequestUrl + @"?offset=" + pageoffset;
                            var response = RESTfulOperation.GetResponse(newConditon.Request);

                            info.OffsetUrl = newConditon.Request.RequestUrl;

                            int headerPageoffsetValue;
                            int.TryParse(GetResponseHeaderValue(response.ResponseHeaders, "X-hedtech-pageOffset"), out headerPageoffsetValue);
                            info.Pageoffset = headerPageoffsetValue;

                            OffsetInfoList.Add(info);
                        }, new ExecutionDataflowBlockOptions { MaxDegreeOfParallelism = 10 });

                    for (int i = 0; i < offsetCountList.Count; i++)
                    {
                        workerBlock.Post(i);
                    }
                    workerBlock.Complete();

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