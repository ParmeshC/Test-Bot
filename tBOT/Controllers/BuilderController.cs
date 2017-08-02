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

        public ActionResult GetTableSchema(TableShemaRequest tableShemaRequest)
        {
            Dictionary<string, string> columnNamesDictionay = new Dictionary<string, string>();
            DataAccess DtAcss = new DataAccess();


            columnNamesDictionay = DtAcss.GetTableColumnsWithData(tableShemaRequest);
            return Content(JsonConvert.SerializeObject(columnNamesDictionay), "application/json");
        }

        public ActionResult GetAllTableNames(DataConnection DtCon)
        {
            List<string> tableNames = new List<string>();
            DataAccess DtAcss = new DataAccess();

            tableNames = DtAcss.GetAllTableNames( DtCon);
            return Content(JsonConvert.SerializeObject(tableNames), "application/json");
        }


        public ActionResult GetTableDescription(TableShemaRequest tableShemaRequest)
        {
            List<TableSchemaDescription> tableDescribe = new List<TableSchemaDescription>();
            DataAccess DtAcss = new DataAccess();

            tableDescribe = DtAcss.GetTableDescribe(tableShemaRequest);
            return Content(JsonConvert.SerializeObject(tableDescribe), "application/json");
        }


    }
}