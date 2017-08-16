using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using tBOT.Models;
using System.Data.Entity.Design.PluralizationServices;
using System.Globalization;
using System.Text.RegularExpressions;
using tBOT.TestConditions;
using tBOT.API;

namespace tBOT.Controllers
{
    public class PlannerController : Controller
    {

        // GET: Planner
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult PlannerRequest()
        {
            return View();
        }

        public JsonResult GetAllEnvironments()
        {
            tbotEntities e = new tbotEntities();
            var result = e.Environments.ToList();
            return Json(result, JsonRequestBehavior.AllowGet);

        }

        public JsonResult GetAllAuthorizations()
        {
            tbotEntities e = new tbotEntities();
            var result = e.Authorizations.ToList();
            return Json(result, JsonRequestBehavior.AllowGet);

        }

        public ActionResult GetApiResponseList(List<RequestInfo> RequestData)
        {
            var result = ApiResponseList(RequestData);
            return Json(result, JsonRequestBehavior.AllowGet);
            //return Content(JsonConvert.SerializeObject(ApiResponseList(RequestData)), "application/json");

        }



        private ConcurrentQueue<RequestResponseInfo> ApiResponseList(List<RequestInfo> requestData)
        {
            ConcurrentQueue<RequestResponseInfo> queue = new ConcurrentQueue<RequestResponseInfo>();
            Parallel.ForEach(requestData, (requestItem) =>
            {
                RequestResponseInfo requestResponseInfo = new RequestResponseInfo();
                dynamic ValInfo = new ValidationInfo();
                
                

                Validation Val = new Validation();
                requestResponseInfo = Val.ApiResponse(requestItem).Take();

                if (requestResponseInfo.ResponseInfo.StatusCode == 200)
                {

                    var LVVinfo = FactoryValidation.CreateGeneric<LatestVersionValidationInfo>();
                    ValInfo.LatestVersionValidationInfo = LVVinfo.Validate(requestResponseInfo);
                    ValInfo.PassCount += ValInfo.LatestVersionValidationInfo.Valid == true ? 1 : 0;

                    var LHMVinfo = FactoryValidation.CreateGeneric<ListHeaderMessageValidationInfo>();
                    ValInfo.ListHeaderMessageValidationInfo = LHMVinfo.Validate(requestResponseInfo);
                    ValInfo.PassCount += ValInfo.ListHeaderMessageValidationInfo.Valid == true ? 1 : 0;


                    var SVinfo = FactoryValidation.CreateGeneric<SchemaValidationInfo>();
                    ValInfo.SchemaValidationInfo = SVinfo.Validate(requestResponseInfo);
                    ValInfo.PassCount += ValInfo.SchemaValidationInfo.Valid == true ? 1 : 0;

                    var GHMVinfo = FactoryValidation.CreateGeneric<GuidHeaderMessageValidationInfo>();
                    ValInfo.GuidHeaderMessageValidationInfo = GHMVinfo.Validate(requestResponseInfo);
                    ValInfo.PassCount += ValInfo.GuidHeaderMessageValidationInfo.Valid == true ? 1 : 0;


                    var IGHMVinfo = FactoryValidation.CreateGeneric<InvalidGuidHeaderMessageValidationInfo>();
                    ValInfo.InvalidGuidHeaderMessageValidationInfo = IGHMVinfo.Validate(requestResponseInfo);
                    ValInfo.PassCount += ValInfo.InvalidGuidHeaderMessageValidationInfo.Valid == true ? 1 : 0;


                    var MPSVinfo = FactoryValidation.CreateGeneric<MaxPageSizeValidationInfo>();
                    ValInfo.MaxPageSizeValidationInfo = MPSVinfo.Validate(requestResponseInfo);
                    ValInfo.PassCount += ValInfo.MaxPageSizeValidationInfo.Valid == true ? 1 : 0;

                }
                else
                {
                    ValInfo.PassStatus = false;                    

                }
                requestResponseInfo.ResponseInfo.ValidationInfo = ValInfo;
                queue.Enqueue(requestResponseInfo);
            });

            return queue;

        }



    }
}