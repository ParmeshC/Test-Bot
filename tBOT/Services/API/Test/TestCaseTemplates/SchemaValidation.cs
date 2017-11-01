using Newtonsoft.Json.Linq;
using Newtonsoft.Json.Schema;
using System;
using System.Collections.Generic;
using System.Net;
using System.Web.Script.Serialization;
using tBOT.Services.API.RESTful;
using tBOT.Services.ExtentionMethods;

namespace tBOT.Services.API.Test
{
    public class SchemaValidation : TestCaseTemplate, ITestCaseTemplate<SchemaValidationContion, SchemaValidationResult>
    {
        private static void SchemaAgainstJSON(string RawSchema, JObject jsonObject, out Boolean isSchemaValid, out IList<string> schemaValidationErrors)
        {
            isSchemaValid = false;
            IList<string> schemaErrors = new List<string>();
            if (!string.IsNullOrEmpty(RawSchema))
            {
                if (jsonObject != null)
                {
                    if (RawSchema.StartsWith("{") && RawSchema.EndsWith("}"))
                    {
                        JSchema schema = JSchema.Parse(RawSchema);
                        isSchemaValid = jsonObject.IsValid(schema, out schemaErrors);
                    }
                    else
                    {
                        schemaErrors.Add("Not a Valid Schema");
                    }
                }
                else
                {
                    schemaErrors.Add("No Json to Validate");
                }
            }
            else
            {
                schemaErrors.Add("No Schema to Validate");
            }

            schemaValidationErrors = schemaErrors;
        }

        public SchemaValidationResult Execute(SchemaValidationContion condition)
        {

            SchemaValidationResult result = new SchemaValidationResult
            {
                SchemaUrl = condition.RawSchemaUrl,
                Schema = "",
                Response = RESTfulOperation.GetResponse(condition.Request)
            };

            if (!string.IsNullOrEmpty(result.SchemaUrl))
            {
                try
                {
                    using (WebClient client = new WebClient())
                    { result.Schema = client.DownloadString(condition.RawSchemaUrl); }
                }
                catch
                {

                }

            }
            Boolean IsShemaValid = false;
            if (result.Response.StatusCode == 200 )
            {

                JObject schemaValidatedJson = result.Response.ResponseArray.Count != 0 ? result.Response.ResponseArray[0] as JObject : null;
                result.SchemaValidatedJson = new JavaScriptSerializer().Deserialize<dynamic>(schemaValidatedJson.ToString());

                IList<string> schemaErrorList;
                SchemaAgainstJSON(result.Schema, schemaValidatedJson, out IsShemaValid, out schemaErrorList);

                result.SchemaErrors = schemaErrorList != null ? string.Join(System.Environment.NewLine, schemaErrorList) : null;
            }
            result.Status = IsShemaValid;
            return result;
        }
    }
    public class SchemaValidationResult: ITestCaseResult
    {
        public string SchemaUrl { get; set; }
        public string Schema { get; set; }
        public dynamic SchemaValidatedJson { get; set; }
        public RESTfulResponse Response { get; set; }
        public bool Status { get; set; }
        public string SchemaErrors { get; set; }

    }
    public class SchemaValidationContion: ITestCaseCondition
    {
        public RESTfulRequest Request{ get; set; }
        public string RawSchemaUrl { get; set; }

    }
}