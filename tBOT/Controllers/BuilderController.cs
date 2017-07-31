using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using tBOT.API;

namespace tBOT.Controllers
{
    public class BuilderController : Controller
    {
        // GET: Builder
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ResponseQuery()
        {
            return View();
        }

        public ActionResult DatabaseQuery()
        {
            return View();
        }

        public ActionResult GetTableSchema(DataConnection DtCon)
        {
            Dictionary<string, string> columnNamesDictionay = new Dictionary<string, string>();
            DataAccess DtAcss = new DataAccess();


            columnNamesDictionay = DtAcss.GetTableColumnsWithData("RFRFFID", DtCon);
            return Content(JsonConvert.SerializeObject(columnNamesDictionay), "application/json");
        }

        public ActionResult GetAllTableNames(DataConnection DtCon)
        {
            List<string> tableNames = new List<string>();
            DataAccess DtAcss = new DataAccess();

            tableNames = DtAcss.GetAllTableNames( DtCon);
            return Content(JsonConvert.SerializeObject(tableNames), "application/json");
        }
    }
}