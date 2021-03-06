﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using tBOT.Services.API;
using tBOT.Models;

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

        public ActionResult GetTableSchema(TableShemaRequest tableSchemaRequest)
        {
            Dictionary<string, string> columnNamesDictionay = new Dictionary<string, string>();
            DataAccess DtAcss = new DataAccess();

            columnNamesDictionay = DtAcss.GetTableColumnsWithData(tableSchemaRequest);
            return Content(JsonConvert.SerializeObject(columnNamesDictionay), "application/json");
        }

        public ActionResult GetAllTableNames(DataConnection DtCon)
        {
            List<string> tableNames = new List<string>();
            DataAccess DtAcss = new DataAccess();

            tableNames = DtAcss.GetAllTableNames( DtCon);
            return Content(JsonConvert.SerializeObject(tableNames), "application/json");
        }


        public ActionResult GetTableDescription(TableShemaRequest tableSchemaRequest)
        {
            List<TableSchemaDescription> tableDescribe = new List<TableSchemaDescription>();
            DataAccess DtAcss = new DataAccess();

            tableDescribe = DtAcss.GetTableDescribe(tableSchemaRequest);
            return Content(JsonConvert.SerializeObject(tableDescribe), "application/json");
        }


        public JsonResult AddTestCases(Models.TestCase TestCase)
        {
            //question.Date = DateTime.Parse(DateTime.Now.ToShortTimeString());
            tbotEntities e = new tbotEntities();

                e.TestCases.Add(TestCase);

            //e.APIs.Add(apiInput);            
            e.SaveChanges();
            return Json(new { status = "Api Input added successfully" });
        }


    }
}