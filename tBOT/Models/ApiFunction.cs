using System;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json.Linq;
using System.Text;
using System.Collections.Generic;
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

        public static RequestResponseInfo GetRequestResponse(RequestInfo requestInfo)
        {
            RequestResponseInfo requestResponseInfo = new RequestResponseInfo();
            string errorMessage = null;
            string description = null;

            try
            {
                HttpContent requestBody = !string.IsNullOrEmpty(requestInfo.RequestBody) ? new StringContent(requestInfo.RequestBody, Encoding.UTF8, requestInfo.ContentType) : null;
                HttpResponseMessage Response;

                using (HttpClient Client = new HttpClient())
                {
                    Client.DefaultRequestHeaders.Accept.Clear();
                    Client.DefaultRequestHeaders.Add("Accept", requestInfo.Accept);
                    Client.DefaultRequestHeaders.AcceptLanguage.ParseAdd(requestInfo.LanguageCode);
                    Client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(requestInfo.AuthType, Convert.ToBase64String(System.Text.ASCIIEncoding.ASCII.GetBytes(
                    string.Format("{0}:{1}", requestInfo.UserName, requestInfo.Password))));

                    switch (requestInfo.RequestMethod.ToUpper())
                    {
                        case "GET":
                            Response = Client.GetAsync(requestInfo.RequestUrl).Result;
                            break;
                        case "POST":
                            Response = Client.PostAsync(requestInfo.RequestUrl, requestBody).Result;
                            break;
                        case "PUT":
                            Response = Client.PutAsync(requestInfo.RequestUrl, requestBody).Result;
                            break;
                        default:
                            Response = null;
                            description = requestInfo.RequestMethod + " Method deos not exist";
                            break;
                    }
                }
                
                if (Response != null)
                {
                    if (!string.IsNullOrEmpty(Response.Content.ReadAsStringAsync().Result))
                    {
                        requestResponseInfo.ResponseInfo.ResponseBody = Response.Content.ReadAsStringAsync().Result;
                        var token = JToken.Parse(requestResponseInfo.ResponseInfo.ResponseBody);

                        if (token is JArray)
                        {
                            requestResponseInfo.ResponseInfo.IsResponseArray = true;
                            requestResponseInfo.ResponseInfo.ResponseArray = JArray.Parse(requestResponseInfo.ResponseInfo.ResponseBody);
                        }
                        else if (token is JObject)
                        {
                            requestResponseInfo.ResponseInfo.IsResponseArray = false;
                            requestResponseInfo.ResponseInfo.ResponseArray.Add(JArray.Parse(requestResponseInfo.ResponseInfo.ResponseBody));
                        }

                        if (Response.IsSuccessStatusCode)
                            { description = "Status:OK, No Errors"; }
                        else
                            { setMessages(JObject.Parse(requestResponseInfo.ResponseInfo.ResponseArray[0].ToString()), out errorMessage, out description);}
                    }
                    else
                    {
                       description = requestResponseInfo.ResponseInfo.ResponsePhrase + Environment.NewLine + Response.Content.Headers.ToString();
                    }
                    requestResponseInfo.ResponseInfo.ResponseHeaders = Response.Headers.ToArray();
                    requestResponseInfo.ResponseInfo.StatusCode = (int)Response.StatusCode;
                }
                requestResponseInfo.ResponseInfo.Description = description;
                requestResponseInfo.ResponseInfo.ErrorMessage = errorMessage;
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                { if (ex.InnerException.Message.Split(':').Length > 0) requestResponseInfo.ResponseInfo.Description = ex.InnerException.Message.Split(':')[0].ToString(); }
                else
                { requestResponseInfo.ResponseInfo.Description = ex.Message.ToString(); }
            }
            return requestResponseInfo;
        }
            
        }
        
    public class RequestInfo
    {
        public string AuthType { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Lang { get; set; }
        public string Accept { get; set; }
        public string ContentType { get; set; }
        public string LanguageCode { get; set; }
        public string RequestMethod { get; set; }
        public string RequestUrl { get; set; }
        public string RequestBody { get; set; }
        public string EndPoint { get; set; }
        public string RawschemaUrl { get; set; }
        public string Version { get; set; }

}

    public class ResponseInfo
    {
        public string ResponseBody { get; set; }
        public JArray ResponseArray { get; set; }
        public bool IsResponseArray { get; set; }
        public KeyValuePair<string, IEnumerable<string>>[] ResponseHeaders { get; set; }
        public int StatusCode { get; set; }
        public string ResponsePhrase { get; set; }
        public string ErrorMessage { get; set; }
        public string Description { get; set; }
    }

    public class RequestResponseInfo
    {
        public RequestInfo RequestInfo { get; set; }
        public ResponseInfo ResponseInfo { get; set; }

    }

    public class TranlsationRequestData : RequestInfo
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
            Status status = Status.NoAPIMessage;
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
                Console.WriteLine("An error occurred: '{0}'", ex);
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
                Console.WriteLine("An error occurred: '{0}'", ex);
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
