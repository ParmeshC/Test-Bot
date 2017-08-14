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
            return Content(JsonConvert.SerializeObject(ApiResponseList(RequestData)), "application/json");

        }



        private ConcurrentQueue<IValidationInfo> ApiResponseList(List<RequestInfo> requestData)
        {
            ConcurrentQueue<IValidationInfo> queue = new ConcurrentQueue<IValidationInfo>();
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

                    var LHMVinfo = FactoryValidation.CreateGeneric<ListHeaderMessageValidationInfo>();
                    ValInfo.ListHeaderMessageValidationInfo = LHMVinfo.Validate(requestResponseInfo);


                    var SVinfo = FactoryValidation.CreateGeneric<SchemaValidationInfo>();
                    ValInfo.SchemaValidationInfo = SVinfo.Validate(requestResponseInfo);

                    var GHMVinfo = FactoryValidation.CreateGeneric<GuidHeaderMessageValidationInfo>();
                    ValInfo.GuidHeaderMessageValidationInfo = GHMVinfo.Validate(requestResponseInfo);


                    var IGHMVinfo = FactoryValidation.CreateGeneric<InvalidGuidHeaderMessageValidationInfo>();
                    ValInfo.InvalidGuidHeaderMessageValidationInfo = IGHMVinfo.Validate(requestResponseInfo);


                }
                else
                {
                    ValInfo.PassStatus = false;                    

                }

                queue.Enqueue(ValInfo);
            });

            return queue;

        }



    }
}