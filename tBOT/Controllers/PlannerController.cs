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

        public ActionResult GetAllApiResponses()
        {
            var result = AllApiResponse();
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetApiResponse(string SrvNm, string Port, string UsrNm, string PassWrd, string AuthType, string ApiAPP, string ApiEndPoint)
        {
            //BlockingCollection<API.ReponseResult> items = new BlockingCollection<API.ReponseResult>();
            //items = ApiResponse(SrvNm, Port, UsrNm, PassWrd, AuthType, ApiAPP, ApiName);

            return Content(JsonConvert.SerializeObject(ApiResponse(SrvNm, UsrNm, PassWrd, AuthType, ApiAPP, ApiEndPoint)), "application/json");

            //return Json(items, JsonRequestBehavior.AllowGet);
        }

        public BlockingCollection<API.ReponseResult> ApiResponse(string srvNm, string usrNm, string passWrd, string authType, string apiAPP, string apiEndPoint)
        {
            tbotEntities ApiEntity = new tbotEntities();
            var allApis = ApiEntity.APIs.ToList();

            BlockingCollection<API.ReponseResult> queue = new BlockingCollection<API.ReponseResult>();

            //string serverName = @"m040145.ellucian.com";
            //string port = "8088";
            string connector = "api";
            string requestBody = "";
            string rawSchemaUrl = @"https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/" + apiEndPoint.Trim() + @".json?at=refs%2Fheads%2Fdevelop";

            
            string requestUrl = @"http://" + srvNm + @"/" + apiAPP + @"/" + connector + @"/" + apiEndPoint;
            var TranslationApi = API.Request.GetResponseInfo(
                usrNm,
                passWrd,
                authType,
                "en-in",
                "application/json",
                "application/json",
                "GET",
                requestUrl,
                requestBody);
            string ValidationSchema = "";
            if (!string.IsNullOrEmpty(rawSchemaUrl))
            {
                try
                {
                    using (WebClient client = new WebClient())
                    { ValidationSchema = client.DownloadString(rawSchemaUrl); }
                }
                catch
                {

                }

            }

            JObject firstResponseObject = !TranslationApi.IsResponseArray ? TranslationApi.ResponseObject : TranslationApi.ResponseArray.Count > 0 ? JObject.Parse(TranslationApi.ResponseArray[0].ToString()) : null;
            //JObject responseObject = !TranslationApi.IsResponseArray ? TranslationApi.ResponseObject : TranslationApi.ResponseArray.Count > 0 ? JObject.Parse(TranslationApi.ResponseArray[].ToString()) : null;
            JObject[] items = TranslationApi.IsResponseArray ? TranslationApi.ResponseArray.Select(jv => (JObject)jv).ToArray() : null;



            bool IsShemaValid = false;
            IList<string> schemaErrorList;
            API.Request.SchemaValidation(firstResponseObject, ValidationSchema, out IsShemaValid, out schemaErrorList);

            string schemaErrors = schemaErrorList != null ? string.Join(System.Environment.NewLine, schemaErrorList) : null;

            var gUID = API.Request.GetResponseFieldValue(firstResponseObject, "id");
            var latestVersion = API.Request.GetResponseHeaderValue(TranslationApi.ResponseHeaders, "X-hedtech-Media-Type");
            var headerMessage = API.Request.GetResponseHeaderValue(TranslationApi.ResponseHeaders, "X-hedtech-message");
            var totalCount = API.Request.GetResponseHeaderValue(TranslationApi.ResponseHeaders, "X-Total-Count");
            var maxPageSize = API.Request.GetResponseHeaderValue(TranslationApi.ResponseHeaders, "X-hedtech-pageMaxSize");

            queue.Add(new API.ReponseResult
            {
                ResponseContent = TranslationApi,
                Url = requestUrl,
                SchemaUrl = rawSchemaUrl,
                Schema = ValidationSchema,
                SchemaValidatedJson = firstResponseObject,                
                SchemaValid = IsShemaValid.ToString(),
                SchemaErrors = schemaErrors,
                GetListMessage = headerMessage,
                Guid = gUID,
                LatestVersion = latestVersion,
                MaxPageSize = maxPageSize,
                TotalCount = totalCount
            });

            return queue;
        }

        public ConcurrentQueue<API.ReponseResult> AllApiResponse()
        {
            tbotEntities ApiEntity = new tbotEntities();
            var allApis = ApiEntity.APIs.ToList();

            ConcurrentQueue<API.ReponseResult> queue = new ConcurrentQueue<API.ReponseResult>();

            Parallel.ForEach(allApis, (currentRow) =>
            {
                //string serverName = @"m040145.ellucian.com:8088";
                string serverName = @"149.24.38.75:7004";

                string connector = "api";
                string requestBody = "";
                string rawSchemaUrl = @"https://git.ellucian.com:8443/projects/HEDM/repos/hedm-models/raw/schema/" + currentRow.EndPoint + @".json?at=refs%2Fheads%2Fdevelop";

                string requestUrl = @"http://" + serverName + @"/" + currentRow.APP + @"/" + connector + @"/" + currentRow.EndPoint;
                var TranslationApi = API.Request.GetResponseInfo(
                    "grails_user",
                    "u_pick_it",
                    "Basic",
                    "en-in",
                    "application/json",
                    "application/json",
                    "GET",
                    requestUrl,
                    requestBody);
                string ValidationSchema = "";
                if (!string.IsNullOrEmpty(rawSchemaUrl))
                {
                    using (WebClient client = new WebClient())
                    { ValidationSchema = client.DownloadString(rawSchemaUrl); }
                }

                JObject firstResponseObject = !TranslationApi.IsResponseArray ? TranslationApi.ResponseObject : TranslationApi.ResponseArray.Count > 0 ? JObject.Parse(TranslationApi.ResponseArray[0].ToString()) : null;
                bool IsShemaValid = false;
                IList<string> schemaErrorList;
                API.Request.SchemaValidation(firstResponseObject, ValidationSchema, out IsShemaValid, out schemaErrorList);

                string schemaErrors = schemaErrorList != null ? string.Join(System.Environment.NewLine, schemaErrorList) : null;

                var gUID = API.Request.GetResponseFieldValue(firstResponseObject, "id");
                var latestVersion = API.Request.GetResponseHeaderValue(TranslationApi.ResponseHeaders, "X-hedtech-Media-Type");
                var headerMessage = API.Request.GetResponseHeaderValue(TranslationApi.ResponseHeaders, "X-hedtech-message");
                var totalCount = API.Request.GetResponseHeaderValue(TranslationApi.ResponseHeaders, "X-Total-Count");
                var maxPageSize = API.Request.GetResponseHeaderValue(TranslationApi.ResponseHeaders, "X-hedtech-pageMaxSize");

                queue.Enqueue(new API.ReponseResult
                {
                    ResponseContent = TranslationApi,
                    Url = requestUrl,
                    SchemaUrl = rawSchemaUrl,
                    Schema = ValidationSchema,
                    SchemaValidatedJson = firstResponseObject,
                    SchemaValid = IsShemaValid.ToString(),
                    SchemaErrors = schemaErrors,
                    GetListMessage = headerMessage,
                    Guid = gUID,
                    LatestVersion = latestVersion,
                    MaxPageSize = maxPageSize,
                    TotalCount = totalCount
                });

            });

            return queue;


        }


    }
}