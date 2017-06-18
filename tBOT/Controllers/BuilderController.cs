using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

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
    }
}