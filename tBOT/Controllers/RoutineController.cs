using System.Collections.Generic;
using System.Linq;
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


        [HttpGet]
        public JsonResult GetInstances()
        {
            tbotEntities e = new tbotEntities();
            var result = e.Instances.ToList();
            return Json(result, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public ActionResult GetEndPoints(int InstanceId)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Get_EndPoints_For_InstanceId(InstanceId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public ActionResult AddEndPoint(int InstanceId, string EndPointName)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Add_EndPoint_For_InstanceId(InstanceId, EndPointName);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult RemoveEndPoint(int EndPointId)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Remove_EndPoint_By_EndPointId(EndPointId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        [HttpGet]
        public JsonResult GetEndPointObjectCount()
        {
            tbotEntities e = new tbotEntities();
            var result = e.View_EndPointObject_By_Count.ToList();
            return Json(result, JsonRequestBehavior.AllowGet);

        }


        [HttpPost]
        public ActionResult GetEndPointObjectForEndPointObjectGroupSection(string EndPointObjectGroupSection)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Get_EndPointObject_EndPoint_For_EndPointObjectGroupSection(EndPointObjectGroupSection);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        
        [HttpGet]
        public JsonResult GetEndPointObjectGroupList()
        {
            tbotEntities e = new tbotEntities();
            var result = e.View_EndPointObjectGroup_Distinct.ToList();
            return Json(result, JsonRequestBehavior.AllowGet);

        }


        [HttpPost]
        public ActionResult GropuEndPointObject(int EndPointObjectId, string Section)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Group_EndPointObject_By_EndPointObjectId(EndPointObjectId,Section);
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public ActionResult UngropuEndPointObject(int EndPointObjectGroupId)
        {
            tbotEntities e = new tbotEntities();
            var result = e.UnGroup_EndPointObject_By_EndPointObjectGroupId(EndPointObjectGroupId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }



        [HttpPost]
        public ActionResult GetEndPointObject(int EndPointId)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Get_EndPointObjectComponentCount_GroupedInCount_By_EndPointObject_For_EndPointId(EndPointId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }



        [HttpPost]
        public ActionResult AddEndPointObject(int EndPointId)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Add_EndPointObject_For_EndPointId(EndPointId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public ActionResult AddEndPointObjectComponent(int EndPointObjectId, string EndPointObjectComponentName)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Add_EndPointObjectComponent_For_EndPointObjectId(EndPointObjectId, EndPointObjectComponentName);
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public ActionResult EditEndPointComponentValue(int EndPointComponentId, string EndPointComponentValue)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Edit_EndPointComponentValue_For_EndPointComponentId(EndPointComponentId, EndPointComponentValue);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult EditEndPointObjectComponentValue(int EndPointObjectComponentId, string EndPointObjectComponentValue)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Edit_EndPointObjectComponentValue_For_EndPointObjectComponentId(EndPointObjectComponentId, EndPointObjectComponentValue);
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public ActionResult RemoveEndPointObject(int EndPointObjectId)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Remove_EndPointObject_By_EndPointObjectId(EndPointObjectId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        

        [HttpPost]
        public ActionResult RemoveEndPointObjectComponent(int EndPointObjectComponentId)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Remove_EndPointObjectComponent_By_EndPointObjectComponentId(EndPointObjectComponentId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public ActionResult GetEndPointObjectComponents(int EndPointObjectId)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Get_EndPointObjectComponents_For_EndPointObjectId(EndPointObjectId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult GetEndPointObjectComponent(int EndPointObjectComponentId)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Get_EndPointObjectComponent_For_EndPointObjectComponentId(EndPointObjectComponentId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }



        [HttpPost]
        public ActionResult GetEndPointObjectGroups(int EndPointObjectId)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Get_EndPointObjectGroups_For_EndPointObjectId(EndPointObjectId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetEndPointObjectGroupCount()
        {
            tbotEntities e = new tbotEntities();
            var result = e.View_EndPointObjectGroup_By_Count.ToList();
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult GetEndPointComponents()
        {
            tbotEntities e = new tbotEntities();
            var result = e.View_EndPointComponent.ToList();
            return Json(result, JsonRequestBehavior.AllowGet);

        }


        [HttpPost]
        public ActionResult AddEndPointComponent(int InstanceId, string ComponentName )
        {
            tbotEntities e = new tbotEntities();
            var result = e.Add_EndPointComponent_For_InstanceId(InstanceId, ComponentName);
            return Json(result, JsonRequestBehavior.AllowGet);

        }



        [HttpPost]
        public ActionResult GetEndPointComponent(int EndPointComponentId)
        {
            tbotEntities e = new tbotEntities();
            var result = e.Get_EndPointComponent_For_EndPointComponentId(EndPointComponentId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }




        public JsonResult AddApiInfo(List<Models.EndPoint> apiArrayList)
        {
            //question.Date = DateTime.Parse(DateTime.Now.ToShortTimeString());
            tbotEntities e = new tbotEntities();
            //foreach (var api in apiArrayList)
            //{
            //    e.APIs.Add(api);                
            //    api.SchemaUrl = @"https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/" 
            //                    + api.EndPoint 
            //                    + @".json?at=refs%2Fheads%2F" 
            //                    + api.Version
            //                    +@".0";

            //}                       
            //e.APIs.Add(apiInput);            
             e.SaveChanges();
            return Json(new { status = "Api Input added successfully" });
        }

    }
}