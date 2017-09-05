using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using tBOT.Models;
namespace tBOT.Controllers

{
    public class RoutineController : Controller
    {
        // GET: Routine
        public ActionResult Index()
        {
            return View();
        }


        public JsonResult GetApiInfo()
        {
            tbotEntities e = new tbotEntities();
            var result = e.APIs.ToList();
            return Json(result, JsonRequestBehavior.AllowGet);

        }

        public JsonResult AddApiInfo(List<Models.API> apiArrayList)
        {
            //question.Date = DateTime.Parse(DateTime.Now.ToShortTimeString());
            tbotEntities e = new tbotEntities();
            foreach (var api in apiArrayList)
            {
                e.APIs.Add(api);                
                api.SchemaUrl = @"https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/" 
                                + api.EndPoint 
                                + @".json?at=refs%2Fheads%2F" 
                                + api.Version
                                +@".0";

            }                       
            //e.APIs.Add(apiInput);            
             e.SaveChanges();
            return Json(new { status = "Api Input added successfully" });
        }

    }
}