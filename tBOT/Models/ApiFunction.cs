using System;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json.Linq;
using System.Text;
using System.Collections.Generic;
using Newtonsoft.Json.Schema;
using System.Collections;
using System.IO;
using System.Text.RegularExpressions;
using System.Globalization;
using System.ComponentModel;

namespace tBOT.API
{
    public static class Request
    {
        private static void setMessages(JObject jsonObject, out string errorMessage, out string description)
        {
            errorMessage = null;
            description = null;
             errorMessage = (string)jsonObject.Descendants()
            .OfType<JProperty>()
            .FirstOrDefault(p => p.Name == "message");

            if (string.IsNullOrEmpty(errorMessage))
            {
                description = (string)jsonObject.Descendants()
                .OfType<JProperty>()
                .FirstOrDefault(p => p.Name == "description");

                if (string.IsNullOrEmpty(description))
                {
                    description = (string)jsonObject.Descendants()
                    .OfType<JProperty>()
                    .FirstOrDefault(p => p.Name == "errorMessage");
                }
            }

        }

        public static ResponseData GetResponseInfo(string UserName, string Password, string AuthType, string LanguageCode, string Accept, string ContentType, string Method, string Url, string RequestBody)
        {
            var responseInfo = new ResponseData();

            string responseBody=null;
            JArray responseArray=null;
            JObject responseObject=null;
            bool isResponseArray= false;
            KeyValuePair<string, IEnumerable<string>>[] responseHeaders=null;
            int statusCode=0;
            string responsePhrase=null;
            string errorMessage=null;
            string description=null;

            try
            {
                
                HttpContent requestBody = !string.IsNullOrEmpty(RequestBody) ? new StringContent(RequestBody, Encoding.UTF8, ContentType) : null;
                HttpResponseMessage Response;

                using (HttpClient Client = new HttpClient())
                {
                    Client.DefaultRequestHeaders.Accept.Clear();
                    Client.DefaultRequestHeaders.Add("Accept", Accept);
                    Client.DefaultRequestHeaders.AcceptLanguage.ParseAdd(LanguageCode);
                    Client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(AuthType, Convert.ToBase64String(System.Text.ASCIIEncoding.ASCII.GetBytes(
                    string.Format("{0}:{1}", UserName, Password))));

                    switch (Method.ToUpper())
                    {
                        case "GET":
                            Response = Client.GetAsync(Url).Result;
                            break;
                        case "POST":
                            Response = Client.PostAsync(Url, requestBody).Result;
                            break;
                        case "PUT":
                            Response = Client.PutAsync(Url, requestBody).Result;
                            break;
                        default:
                            Response = null;
                            description = Method + " Method deos not exist";
                            break;
                    }
                }

                //string json = "{\"Department\": \"Department1\",\"JobTitle\": \"JobTitle1\",\"FirstName\": \"FirstName1\",\"LastName\": \"LastName1\"}";                
                if (Response != null)
                {
                    if (!string.IsNullOrEmpty(Response.Content.ReadAsStringAsync().Result))
                    {
                        responseBody = Response.Content.ReadAsStringAsync().Result;
                        var token = JToken.Parse(responseBody);
                        if (token is JArray)
                        {
                            isResponseArray = true;
                            responseArray = JArray.Parse(responseBody);
                            if (responseArray.Count > 0) responseObject = JObject.Parse(responseArray[0].ToString());

                        }
                        else if (token is JObject)
                        {
                            isResponseArray = false;
                            responseObject = JObject.Parse(responseBody);
                        }

                        if (Response.IsSuccessStatusCode) { description = "Status:OK, No Errors"; } else { setMessages(responseObject, out errorMessage, out description); }
                    }
                    else
                    {
                        description = responsePhrase + System.Environment.NewLine + Response.Content.Headers.ToString();
                    }
                    responseHeaders = Response.Headers.ToArray();
                    responsePhrase = Response.ReasonPhrase;
                    statusCode = (int)Response.StatusCode;
                }
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                { if (ex.InnerException.Message.Split(':').Length > 0) description = ex.InnerException.Message.Split(':')[0].ToString(); }
                else
                { description = ex.Message.ToString(); }
            }

            responseInfo.ResponseBody = responseBody;
            responseInfo.ResponseArray = responseArray;
            responseInfo.ResponseObject = responseObject;
            responseInfo.IsResponseArray = isResponseArray;
            responseInfo.ResponseHeaders = responseHeaders;
            responseInfo.StatusCode = statusCode;
            responseInfo.ResponsePhrase = responsePhrase;
            responseInfo.ErrorMessage = errorMessage;
            responseInfo.Description = description;
            return responseInfo;
        }

        public static string GetResponseHeaderValue(KeyValuePair<string, IEnumerable<string>>[] ResponseHeaders, string MessageType)
        {
            string messageTypeValue = null;
            if (ResponseHeaders != null)
            {
                List<IEnumerable<string>> messageTypeHeader = (from kvp in ResponseHeaders where kvp.Key == MessageType select kvp.Value).ToList();
                if (messageTypeHeader.Count > 0)
                {
                    IEnumerable<string> messageTypeValueArray = messageTypeHeader.FirstOrDefault();
                    messageTypeValue = messageTypeValueArray.FirstOrDefault();
                }
            }
            return messageTypeValue;
        }

        public static string GetResponseFieldValue(JArray ResponseArray, string FieldName)
        {
            string fieldValue = null;
            if (ResponseArray != null)
            {
                if (ResponseArray.Count > 0)
                {
                    if (ResponseArray[0][FieldName] != null) fieldValue = ResponseArray[0][FieldName].ToString();
                }
            }
            return fieldValue;
        }

        public static string GetResponseFieldValue(JObject ResponseObect, string FieldName)
        {
            string fieldValue = null;
            if (ResponseObect != null)
            {
                if (ResponseObect[FieldName] != null) fieldValue = ResponseObect[FieldName].ToString();
            }
            return fieldValue;
        }

        public static void SchemaValidation(JObject jsonObject, string RawSchema, out bool isSchemaValid, out IList<string> schemaValidationErrors)
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
    }

    public class ReponseResult
    {
        public ResponseData ResponseContent { get; set; }
        public ValidationData ValidationContent { get; set; }
        public string Url { get; set; }
        public string SchemaUrl { get; set; }
        public string Schema { get; set; }
        public JObject SchemaValidatedJson { get; set; }
        public string SchemaValid { get; set; }
        public string SchemaErrors { get; set; }        
        public string LatestVersion { get; set; }
        public string Guid { get; set; }
        public string GetListMessage { get; set; }
        public string MaxPageSize { get; set; }
        public string TotalCount { get; set; }
        
    }

    public class ResponseData
    {
        public string ResponseBody { get; set; }
        public JArray ResponseArray { get; set; }
        public JObject ResponseObject { get; set; }
        public bool IsResponseArray { get; set; }
        public KeyValuePair<string, IEnumerable<string>>[] ResponseHeaders { get; set; }
        public int StatusCode { get; set; }
        public string ResponsePhrase { get; set; }
        public string ErrorMessage { get; set; }
        public string Description { get; set; }
    }


    public class ValidationData
    {
        public string ListHeaderMessage { get; set; }
        public string ExpectedListHeaderMessage { get; set; }
        public Boolean ListHeaderMessageValid { get; set; }

        public string GuidHeaderMessage { get; set; }
        public string ExpectedGuidHeaderMessage { get; set; }
        public Boolean GuidHeaderMessageValid { get; set; }

        public string InvalidGuidHeaderMessage { get; set; }
        public string ExpectedInvalidGuidHeaderMessage { get; set; }
        public Boolean InvalidGuidHeaderMessageValid { get; set; }

        public string LatestVersion { get; set; }
        public string ExpectedLatestVersion { get; set; }
        public Boolean LatestVersionValid { get; set; }



    }

    public class RequestData
    {
        public string AuthType { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Lang { get; set; }
        public string Accept { get; set; }
        public string ContentType { get; set; }
        public string RequestMethod { get; set; }
        public string RequestUrl { get; set; }
        public string RequestBody { get; set; }
        public string EndPoint { get; set; }
        public string RawschemaUrl { get; set; }
        public string Version { get; set; }

    }

    public class TranlsationRequestData:RequestData
    {
        public string MessageKey { get; set; }
        public string ExpectedErrorMessage { get; set; }
    }

    public static class Translate
    {
        public enum Status
        {
            Matching,
            NotMatching,
            NoAPIMessage,
            NoTargetValue
        }

        public static Status GetMessageStatus(string MessageKey, string TargetFolderPath, string ApiErrorMessage)
        {
            Status status= Status.NoAPIMessage;
            if (string.IsNullOrEmpty(ApiErrorMessage)) { return status; }
            try
            {
                string messageValueConverted = null;
                string msgeValue = null;
                bool flag = false;

                string[] files = Directory.GetFiles(TargetFolderPath, "*.*", SearchOption.AllDirectories);
                foreach (string file in files)
                {
                    foreach (var rowItem in File.ReadAllLines(file))
                    {
                        msgeValue = rowItem.Split('=').Length > 1 ? rowItem.Split('=')[0] == MessageKey ? rowItem.Split('=')[1] : null : null;
                        if (msgeValue != null)
                        {
                            //Converting unicode to string
                            Regex rx = new Regex(@"\\[uU]([0-9A-F]{4})");
                            messageValueConverted = rx.Replace(msgeValue, match => ((char)Int32.Parse(match.Value.Substring(2), NumberStyles.HexNumber)).ToString());
                            status = messageValueConverted.TrimEnd('.') == ApiErrorMessage.TrimEnd('.') ? Status.Matching : Status.NotMatching;
                            flag = true;
                            break;
                        }
                    }
                    if (flag) break;
                }
                if (msgeValue == null) status = Status.NoTargetValue;

            }
            catch (Exception ex)
            {

            }
            return status;
        }

        public static string GetMessageKey(string messageValue, string messagesFolderPath)
        {
            string key = null;
            try
            {
                bool flag = false;

                string[] files = Directory.GetFiles(messagesFolderPath, "*.*", SearchOption.AllDirectories);
                foreach (string file in files)
                {
                    foreach (var rowItem in File.ReadAllLines(file))
                    {
                        key = rowItem.Split('=').Length > 1 ? rowItem.Split('=')[1] == messageValue ? rowItem.Split('=')[0] : null : null;
                        if (key != null)
                        {
                            flag = true;
                            break;
                        }
                    }
                    if (flag) break;
                }

            }
            catch (Exception ex)
            {

            }
            return key;
        }
    }

    public class LanguageSelection : INotifyPropertyChanged
    {
        private bool _IsSelected = false;
        public bool Check { get { return _IsSelected; } set { _IsSelected = value; OnChanged("Check"); } }        
        public string Region { get; set; }
        public string Code { get; set; }
        public string TargetFolder { get; set; }
        public int Matching { get; set; }
        public int NotMatching { get; set; }
        public int NoAPIMessage { get; set; }
        public int NoTargetValue { get; set; }



        public event PropertyChangedEventHandler PropertyChanged;
        private void OnChanged(string prop)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
        }
    }

}
