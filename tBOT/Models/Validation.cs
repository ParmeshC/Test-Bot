using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.Entity.Design.PluralizationServices;
using System.Dynamic;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using Newtonsoft.Json.Schema;
using System.Web;
using tBOT.API;
using System.Net;
using System.Collections.Concurrent;

namespace tBOT.TestConditions
{
    public interface IValidationInfo
    {

    }

    public interface IValidation<TOutput>
    {
        TOutput Validate(RequestResponseInfo input);

    }

    public class FactoryValidation
    {
        //Dictionary<Type,IValidation<Type>> registeredTypes = new Dictionary<Type,IValidation<Type>>();

        List<IValidation<object>> Validation = new List<IValidation<object>>();

            public static IValidation<T> CreateGeneric<T>()
            {
                if (typeof(T) == typeof(SchemaValidationInfo))
                {
                    return (IValidation<T>)new SchemaValidation();
                }

                if (typeof(T) == typeof(ListHeaderMessageValidationInfo))
                {
                    return (IValidation<T>)new ListHeaderMessageValidation();
                }

                throw new InvalidOperationException();
            }


        public FactoryValidation()

        {
            //registeredTypes.Add(typeof(SchemaValidationInfo), typeof(SchemaValidation));
            //registeredTypes.Add(typeof(ListHeaderMessageValidationInfo), typeof(ListHeaderMessageValidation));

            //return (IValidation<SchemaValidation>)new SchemaValidation();


            Validation.Add((IValidation<object>)new ListHeaderMessageValidation());//0
        }


    }

    public class Validation
    {

        public BlockingCollection<RequestResponseInfo> ApiResponse(RequestInfo requestInfo)
        {
            BlockingCollection<RequestResponseInfo> response = new BlockingCollection<RequestResponseInfo>();
            response.Add(Request.GetRequestResponse(requestInfo));
            return response;
        }

        protected string SingularizeEndPoint(string EndPoint)
        {
            CultureInfo cultInfo = new CultureInfo("en-us");
            PluralizationService pluralSrv = PluralizationService.CreateService(cultInfo);

            string singularizedEndPoint = "";
            if (!string.IsNullOrEmpty(EndPoint))
            {
                string lastWord = EndPoint.Split('-').Last();
                int Place = EndPoint.LastIndexOf(lastWord);
                string newLastWord = pluralSrv.IsPlural(lastWord) == true ? pluralSrv.Singularize(lastWord) : lastWord;
                singularizedEndPoint = EndPoint.Remove(Place, lastWord.Length).Insert(Place, newLastWord);
            }

            return singularizedEndPoint;

        }

        protected Boolean CheckHeaderMessage(string HedtechMessage, string ExpectedMessage)
        {
            return HedtechMessage == ExpectedMessage;

        }        

        protected static string GetResponseHeaderValue(KeyValuePair<string, IEnumerable<string>>[] ResponseHeaders, string MessageType)
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

        protected static string GetResponseFieldValue(JArray ResponseArray, int ItemNumber, string FieldName)
        {
            string fieldValue = null;
            ItemNumber = ItemNumber - 1;
            if (ResponseArray != null)
            {
                if (ResponseArray.Count <= ItemNumber)
                {
                    if (ResponseArray[ItemNumber][FieldName] != null) fieldValue = ResponseArray[ItemNumber][FieldName].ToString();
                }
            }
            return fieldValue;
        }
        

    }
    public class ValidationInfo: DynamicObject,IValidationInfo
    {
        public Boolean PassStatus { get; set; }
        public int PassCount { get; set; }
        public int FailCount { get; set; }


        // The inner dictionary.
        Dictionary<string, object> dictionary
            = new Dictionary<string, object>();

        // This property returns the number of elements
        // in the inner dictionary.
        public int Count
        {
            get
            {
                return dictionary.Count;
            }
        }

        // If you try to get a value of a property 
        // not defined in the class, this method is called.
        public override bool TryGetMember(
            GetMemberBinder binder, out object result)
        {
            // Converting the property name to lowercase
            // so that property names become case-insensitive.
            string name = binder.Name.ToLower();

            // If the property name is found in a dictionary,
            // set the result parameter to the property value and return true.
            // Otherwise, return false.
            return dictionary.TryGetValue(name, out result);
        }

        // If you try to set a value of a property that is
        // not defined in the class, this method is called.
        public override bool TrySetMember(
            SetMemberBinder binder, object value)
        {
            // Converting the property name to lowercase
            // so that property names become case-insensitive.
            dictionary[binder.Name.ToLower()] = value;

            // You can always add a value to a dictionary,
            // so this method always returns true.
            return true;
        }
    }

    public class SchemaValidation: Validation,IValidation<SchemaValidationInfo>
    {
        private static void SchemaAgainstJSON(string RawSchema, JObject jsonObject, out bool isSchemaValid, out IList<string> schemaValidationErrors)
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

        public SchemaValidationInfo Validate(RequestResponseInfo requestResponseInfo)
        {
            SchemaValidationInfo info = new SchemaValidationInfo();
            info.SchemaUrl = requestResponseInfo.RequestInfo.RawschemaUrl;

            info.Schema = "";
            if (!string.IsNullOrEmpty(info.SchemaUrl))
            {
                try
                {
                    using (WebClient client = new WebClient())
                    { info.Schema = client.DownloadString(requestResponseInfo.RequestInfo.RawschemaUrl); }
                }
                catch
                {

                }

            }
            info.SchemaValidatedJson = JObject.Parse(requestResponseInfo.ResponseInfo.ResponseArray[0].ToString());

            bool IsShemaValid = false;
            IList<string> schemaErrorList;
            SchemaAgainstJSON(info.Schema, info.SchemaValidatedJson, out IsShemaValid, out schemaErrorList);

            info.SchemaValid = IsShemaValid;
            info.SchemaErrors = schemaErrorList != null ? string.Join(System.Environment.NewLine, schemaErrorList) : null;

            return info;
        }
    }
    public class SchemaValidationInfo
    {
        public string SchemaUrl { get; set; }
        public string Schema { get; set; }
        public JObject SchemaValidatedJson { get; set; }
        public bool SchemaValid { get; set; }
        public string SchemaErrors { get; set; }

    }

    public class ListHeaderMessageValidation : Validation, IValidation<ListHeaderMessageValidationInfo>
    {
        public ListHeaderMessageValidationInfo Validate(RequestResponseInfo requestResponseInfo)
        {
            ListHeaderMessageValidationInfo info = new ListHeaderMessageValidationInfo();
            info.ExpectedListHeaderMessage= "List of " + SingularizeEndPoint(requestResponseInfo.RequestInfo.EndPoint) + " resources";
            info.ListHeaderMessage = GetResponseHeaderValue(requestResponseInfo.ResponseInfo.ResponseHeaders, "X-hedtech-message");
            info.ListHeaderMessageValid = CheckHeaderMessage(info.ListHeaderMessage, info.ExpectedListHeaderMessage);
            return info;
        }
    }
    public class ListHeaderMessageValidationInfo
    {
        public string ListHeaderMessage { get; set; }
        public string ExpectedListHeaderMessage { get; set; }
        public Boolean ListHeaderMessageValid { get; set; }
    }

    public class LatestVersionValidation : Validation, IValidation<LatestVersionValidationInfo>
    {
        private Boolean CheckLatestVersion(string HedtechMediaType, string ExpectedVersion)
        {

            ExpectedVersion = "v" + Regex.Match(ExpectedVersion, @"\d+$").Value + "+json";
            return HedtechMediaType.Contains(ExpectedVersion);

        }

        public LatestVersionValidationInfo Validate(RequestResponseInfo requestResponseInfo)
        {
            LatestVersionValidationInfo info = new LatestVersionValidationInfo();   
            info.LatestVersion = GetResponseHeaderValue(requestResponseInfo.ResponseInfo.ResponseHeaders, "X-hedtech-Media-Type");
            info.ExpectedLatestVersion = requestResponseInfo.RequestInfo.Version;
            info.LatestVersionValid = CheckLatestVersion(info.LatestVersion, info.ExpectedLatestVersion);
            return info;
        }

    }
    public class LatestVersionValidationInfo
    {
        public string LatestVersion { get; set; }
        public string ExpectedLatestVersion { get; set; }
        public Boolean LatestVersionValid { get; set; }
    }

    public class GuidHeaderMessageValidation : Validation, IValidation<GuidHeaderMessageValidationInfo>
    {
        public GuidHeaderMessageValidationInfo Validate(RequestResponseInfo requestResponseInfo)
        {
            GuidHeaderMessageValidationInfo info = new GuidHeaderMessageValidationInfo();
            string Guid = GetResponseFieldValue(requestResponseInfo.ResponseInfo.ResponseArray, 1, "id");
            requestResponseInfo.RequestInfo.RequestUrl= requestResponseInfo.RequestInfo.RequestUrl + @"/" + Guid;
            info.GuidHeaderMessage= GetResponseHeaderValue(ApiResponse(requestResponseInfo.RequestInfo).Take().ResponseInfo.ResponseHeaders, "X-hedtech-message");
            info.ExpectedGuidHeaderMessage = "Details for the " + SingularizeEndPoint(requestResponseInfo.RequestInfo.EndPoint) + " resource";
            info.GuidHeaderMessageValid = CheckHeaderMessage(info.GuidHeaderMessage, info.ExpectedGuidHeaderMessage);
            return info;
        }

    }
    public class GuidHeaderMessageValidationInfo
    {
        public string GuidHeaderMessage { get; set; }
        public string ExpectedGuidHeaderMessage { get; set; }
        public Boolean GuidHeaderMessageValid { get; set; }
    }

    public class InvalidGuidHeaderMessageValidation : Validation, IValidation<InvalidGuidHeaderMessageValidationInfo>
    {
        public InvalidGuidHeaderMessageValidationInfo Validate(RequestResponseInfo requestResponseInfo)
        {
            InvalidGuidHeaderMessageValidationInfo info = new InvalidGuidHeaderMessageValidationInfo();
            info.InvalidGuidHeaderMessage = GetResponseFieldValue(requestResponseInfo.ResponseInfo.ResponseArray, 1, "id");

            string Guid = "invalid-Guid-0123";
            requestResponseInfo.RequestInfo.RequestUrl = requestResponseInfo.RequestInfo.RequestUrl + @"/" + Guid;
            info.InvalidGuidHeaderMessage = GetResponseHeaderValue(ApiResponse(requestResponseInfo.RequestInfo).Take().ResponseInfo.ResponseHeaders, "X-hedtech-message");

            TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;
            info.ExpectedInvalidGuidHeaderMessage = textInfo.ToTitleCase(SingularizeEndPoint(requestResponseInfo.RequestInfo.EndPoint).Replace("-", " ")) + " not found";
            info.InvalidGuidHeaderMessageValid = CheckHeaderMessage(info.InvalidGuidHeaderMessage, info.ExpectedInvalidGuidHeaderMessage);
            return info;
        }

    }
    public class InvalidGuidHeaderMessageValidationInfo
    {
        public string InvalidGuidHeaderMessage { get; set; }
        public string ExpectedInvalidGuidHeaderMessage { get; set; }
        public Boolean InvalidGuidHeaderMessageValid { get; set; }
    }

    public class TotalCountValidation : Validation, IValidation<TotalCountValidationInfo>
    {
        public TotalCountValidationInfo Validate(RequestResponseInfo requestResponseInfo)
        {
            TotalCountValidationInfo info = new TotalCountValidationInfo();
            info.ApiTotalCount= int.Parse(GetResponseHeaderValue(requestResponseInfo.ResponseInfo.ResponseHeaders, "X-Total-Count"));

            return info;
        }
    }
    public class TotalCountValidationInfo
    {
        public int ApiTotalCount { get; set; }
        public int DBTotalCount { get; set; }
        public Boolean TotalCountValid { get; set; }
    }

    public class MaxPageSizeValidation : Validation, IValidation<MaxPageSizeValidationInfo>
    {
        public MaxPageSizeValidationInfo Validate(RequestResponseInfo requestResponseInfo)
        {
            MaxPageSizeValidationInfo info = new MaxPageSizeValidationInfo();
            info.MaxPageSize = int.Parse(GetResponseHeaderValue(requestResponseInfo.ResponseInfo.ResponseHeaders, "X-hedtech-pageMaxSize"));
            JObject[] PageItems = requestResponseInfo.ResponseInfo.ResponseArray.Select(jv => (JObject)jv).ToArray();
            info.ExpectedMaxPageSize = PageItems.Length;
            info.MaxPageSizeValid = info.MaxPageSize == info.ExpectedMaxPageSize;
            return info;
        }

    }
    public class MaxPageSizeValidationInfo
    {
        public int MaxPageSize { get; set; }
        public int ExpectedMaxPageSize { get; set; }
        public Boolean MaxPageSizeValid { get; set; }
    }


}