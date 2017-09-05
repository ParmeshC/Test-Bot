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
//using System.Web.Http;




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
        


        [HttpPost]
        public ActionResult GetApiResponseList(List<TestRequest> TestRequest)
        {
            var results = TestCaseTemplate.GetRequestResponse(TestRequest);
            var retunValue = Json(results, JsonRequestBehavior.AllowGet);

            return retunValue;
        }

    }
}