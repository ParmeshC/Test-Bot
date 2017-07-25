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

        public ActionResult GetApiResponse(API.RequestData RequestData)
        {

            return Content(JsonConvert.SerializeObject(BasicApiValidation(RequestData)), "application/json");

        }


        public BlockingCollection<API.ReponseResult> ApiResponse(API.RequestData requestData)
        {
            tbotEntities ApiEntity = new tbotEntities();
            var allApis = ApiEntity.APIs.ToList();

            BlockingCollection<API.ReponseResult> queue = new BlockingCollection<API.ReponseResult>();

            var TranslationApi = API.Request.GetResponseInfo(
                requestData.UserName,
                requestData.Password,
                requestData.AuthType,
                requestData.Lang,
                requestData.Accept,
                requestData.ContentType,
                requestData.RequestMethod,
                requestData.RequestUrl,
                requestData.RequestBody);

            string ValidationSchema = "";
            if (!string.IsNullOrEmpty(requestData.RawschemaUrl))
            {
                try
                {
                    using (WebClient client = new WebClient())
                    { ValidationSchema = client.DownloadString(requestData.RawschemaUrl); }
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
                Url = requestData.RequestUrl,
                SchemaUrl = requestData.RawschemaUrl,
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


        private string singularizeEndPoint(string EndPoint)
        {
            CultureInfo cultInfo = new CultureInfo("en-us");
            PluralizationService pluralSrv = PluralizationService.CreateService(cultInfo);

            string[] tokens = EndPoint.Split('-');
            string lastWord = EndPoint.Split('-').Last();

            string resourceName = string.Join("-", tokens.Take(tokens.Length - 1));
            return pluralSrv.IsPlural(lastWord) == true ? resourceName + "-" + pluralSrv.Singularize(lastWord) : resourceName + "-" + lastWord;

        }


        private Boolean checkHeaderMessage(string HedtechMessage, string ExpectedMessage)
        {
            return HedtechMessage == ExpectedMessage;

        }

        private Boolean checkLatestVersion(string HedtechMediaType, string ExpectedVersion)
        {

            ExpectedVersion = "V" + Convert.ToInt32(ExpectedVersion) + "+json";
            return HedtechMediaType.Contains(ExpectedVersion) ;

        }

        private API.ReponseResult BasicApiValidation(API.RequestData RequestData)
        {

            API.ReponseResult responseResult = new API.ReponseResult();
            responseResult = ApiResponse(RequestData).Take();


            responseResult.ValidationContent.ExpectedListHeaderMessage = "List of " + singularizeEndPoint(RequestData.EndPoint) + "resources";
            responseResult.ValidationContent.ExpectedGuidHeaderMessage = "Details for the " + singularizeEndPoint(RequestData.EndPoint) + "resource";
            TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;
            responseResult.ValidationContent.ExpectedInvalidGuidHeaderMessage = textInfo.ToTitleCase(singularizeEndPoint(RequestData.EndPoint).Replace("-", " ")) + " not found";

            if (responseResult.ResponseContent.StatusCode == 200)
            {
                responseResult.ValidationContent.LatestVersionValid = checkLatestVersion(responseResult.LatestVersion, RequestData.Version);

                responseResult.ValidationContent.ListHeaderMessageValid = checkHeaderMessage(ApiResponse(RequestData).Take().GetListMessage, responseResult.ValidationContent.ExpectedListHeaderMessage);

                RequestData.RequestUrl = RequestData.RequestUrl + @"/" + responseResult.Guid;
                responseResult.ValidationContent.GuidHeaderMessageValid = checkHeaderMessage(ApiResponse(RequestData).Take().GetListMessage, responseResult.ValidationContent.ExpectedGuidHeaderMessage);


                RequestData.RequestUrl = RequestData.RequestUrl + @"/" + "invalid-Guid-0123";
                responseResult.ValidationContent.InvalidGuidHeaderMessageValid = checkHeaderMessage(ApiResponse(RequestData).Take().GetListMessage, responseResult.ValidationContent.ExpectedInvalidGuidHeaderMessage);


            }
            else
            {
                responseResult.ValidationContent.LatestVersionValid = false;
                responseResult.ValidationContent.ListHeaderMessageValid = false;
                responseResult.ValidationContent.GuidHeaderMessageValid = false;
                responseResult.ValidationContent.InvalidGuidHeaderMessageValid = false;

            }

            return responseResult;


        }

    }
}