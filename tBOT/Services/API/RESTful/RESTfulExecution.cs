using System;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json.Linq;
using System.Text;
using System.Collections.Concurrent;
using System.Collections.Generic;

namespace tBOT.Services.API.RESTful
{

    public static class RESTfulOperation
    {
        private enum HttpMethods
        {
            GET,
            POST,
            PUT,
            DELETE
        }

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

        private static HttpResponseMessage executeHttpMethod(RESTfulRequest request)
        {
            HttpResponseMessage response=null;
            try
            {
                HttpContent requestBody = !string.IsNullOrEmpty(request.RequestBody) ? new StringContent(request.RequestBody, Encoding.UTF8, request.ContentType) : null;                

                using (HttpClient Client = new HttpClient())
                {
                    Client.DefaultRequestHeaders.Accept.Clear();
                    Client.DefaultRequestHeaders.Add("Accept", request.Accept);
                    Client.DefaultRequestHeaders.AcceptLanguage.ParseAdd(request.LanguageCode);
                    Client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(request.Authorization.AuthType, Convert.ToBase64String(System.Text.ASCIIEncoding.ASCII.GetBytes(
                    string.Format("{0}:{1}", request.Authorization.UserName, request.Authorization.Password))));

                    switch (request.RequestMethod.ToUpper())
                    {
                        case "GET":
                            response = Client.GetAsync(request.RequestUrl).Result;
                            break;
                        case "POST":
                            response = Client.PostAsync(request.RequestUrl, requestBody).Result;
                            break;
                        case "PUT":
                            response = Client.PutAsync(request.RequestUrl, requestBody).Result;
                            break;
                        case "DELETE":
                            response = Client.DeleteAsync(request.RequestUrl).Result;
                            break;
                        default:
                            response = null;
                            break;
                    }
                }
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }

            return response;
        }

        public static RESTfulResponse GetResponse(RESTfulRequest request)
        {
            RESTfulResponse response = new RESTfulResponse();
            HttpResponseMessage httpResponse = null;
            string errorMessage = null;
            string description = null;
            string responseBody = null;

            try
            {
                if (!Enum.IsDefined(typeof(HttpMethods), request.RequestMethod))
                {
                    description = request.RequestMethod + " Method deos not exist";
                    return response;
                }

                httpResponse =executeHttpMethod(request);
                if (httpResponse != null)
                {
                    if (!string.IsNullOrEmpty(httpResponse.Content.ReadAsStringAsync().Result))
                    {
                        responseBody = httpResponse.Content.ReadAsStringAsync().Result;

                        var token = JToken.Parse(responseBody);
                        if (token is JArray)
                        {
                            response.IsResponseArray = true;
                            response.ResponseArray = JArray.Parse(responseBody);

                        }
                        else if (token is JObject)
                        {
                            //response.IsResponseArray = false;
                            //JArray JAry = new JArray();
                            //JAry.Add(JObject.Parse(responseBody));
                            //response.ResponseArray = JAry;

                            response.ResponseArray = new JArray() { responseBody };
                        }

                        if (httpResponse.IsSuccessStatusCode)
                            { description = "Status:OK, No Errors"; }
                        else
                        {
                            setMessages(JObject.Parse(response.ResponseArray.Count == 0 ? "" : response.ResponseArray[0].ToString()), out errorMessage, out description);
                        }
                    }
                    else
                    {
                       description = httpResponse.ReasonPhrase + Environment.NewLine + httpResponse.Content.Headers.ToString();
                    }
                    response.ResponseHeaders = httpResponse.Headers.ToArray();
                    response.StatusCode = (int)httpResponse.StatusCode;
                    response.ResponsePhrase = httpResponse.ReasonPhrase;

                }
                response.Description = description;
                response.ErrorMessage = errorMessage;
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                { if (ex.InnerException.Message.Split(':').Length > 0) response.Description = ex.InnerException.Message.Split(':')[0].ToString(); }
                else
                { response.Description = ex.Message.ToString(); }
            }

            return response;
        }

        public static RESTfulRequestResponse GetRequestResponse(RESTfulRequest request)
        {
            RESTfulRequestResponse requestResponse = new RESTfulRequestResponse();
            requestResponse.Request = request;
            requestResponse.Response = GetResponse(requestResponse.Request);

            return requestResponse;
        }

    }

}
