using Newtonsoft.Json;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;
using tBOT.Models;
using tBOT.Services.API.Test;
using tBOT.Services.API.RESTful;
using Newtonsoft.Json.Linq;
using System.Data;
using tBOT.Services.ExtentionMethods;
using System.Linq.Expressions;
using System.Collections;

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

        public JsonResult GetAllTestCases()
        {
            tbotEntities e = new tbotEntities();
            var result = e.TestCases.ToList();
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        public ActionResult GetAllTestTemplates()
        {
            var ListofTestCaseConditions = TestCaseTemplate.GetListofTestCaseConditions();              
            //var result = Content(JsonConvert.SerializeObject(ListofTestCaseConditions), "application/json");
            var result = Json(ListofTestCaseConditions, JsonRequestBehavior.AllowGet);
            return result;

        }


        public class EndPointInput
        {
            public int Id { get; set; }
            public int InstanceId { get; set; }
            public string Name { get; set; }
            public bool selected { get; set; }
        }


        [HttpGet]
        public JsonResult GetEndPointComponentsAsJsonString()
        {
            tbotEntities e = new tbotEntities();
            //var result = e.View_EndPointComponent.ToList();
            var result = e.EndPointComponents
                .Where(a => a.InstanceId == 1)
                .Select(i => new { i.EndPointComponentName, i.Value, i.InstanceId });
                

            var table = LinqExtensions.ToPivotTable(result,
                item => item.EndPointComponentName,
                item => item.InstanceId,
                items => items.Any() ? items.First().Value : null,
                false);

            string jsonString = string.Empty;

            //Ignores nulll key value pairs while serializing
            jsonString = JsonConvert.SerializeObject(table);



            return Json(jsonString, JsonRequestBehavior.AllowGet);

        }



        [HttpPost]
        public ActionResult GetApiResponseList(List<TestRequest> TestRequest)
        {
            var results = TestCaseTemplate.GetRequestResponse(TestRequest);
            var jsonResult = Json(results, JsonRequestBehavior.AllowGet);
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;

        }

        [HttpPost]
        public ActionResult GetEndPointObjectComponentsForEndPointObjectGroupSection(string EndPointObjectGroupSection)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Get_EndPointObjectComponents_For_EndPointObjectGroupSection(EndPointObjectGroupSection);


            var table = LinqExtensions.ToPivotTable(result,
                item => item.ComponentName,
                item => item.EndPointObjectId,
                items => items.Any() ? items.First().ComponentValue : null,
                true,
                "EndPoint");

            string jsonString = string.Empty;            

            //Ignores nulll key value pairs while serializing
            jsonString = JsonConvert.SerializeObject(table,
                Newtonsoft.Json.Formatting.None,
                new JsonSerializerSettings
                {
                    NullValueHandling = NullValueHandling.Ignore
                });


            return Json(jsonString, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public ActionResult GetEndPointObjectComponentsforEndPointObjectId(int EndPointObjectId)
        {
            tbotEntities e = new tbotEntities();

            var result = e.Get_EndPointObjectComponents_For_EndPointObjectId(EndPointObjectId);

            var table = LinqExtensions.ToPivotTable(result,
                item => item.ComponentName,
                item => item.EndPointObjectId,
                items => items.Any() ? items.First().ComponentValue : null,
                true,
                "EndPoint");

            string jsonString = string.Empty;

            //Ignores nulll key value pairs while serializing
            jsonString = JsonConvert.SerializeObject(table,
                            Newtonsoft.Json.Formatting.None,
                            new JsonSerializerSettings
                            {
                                NullValueHandling = NullValueHandling.Ignore
                            });

            return Json(jsonString, JsonRequestBehavior.AllowGet);
        }

    }
    public class EndPointObjectComponents
    {

        public string EndPointObjectId { get; set; }
        public string EndPoint { get; set; }

    }



}