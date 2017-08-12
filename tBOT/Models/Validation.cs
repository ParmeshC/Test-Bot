using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.Entity.Design.PluralizationServices;
using System.Globalization;
using System.Linq;
using System.Web;
using tBOT.API;

namespace tBOT.Validation
{


    public interface IValidation<TOutput>
    {
        TOutput Validate(ReponseResult input);

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
        public string singularizeEndPoint(string EndPoint)
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

        public Boolean checkHeaderMessage(string HedtechMessage, string ExpectedMessage)
        {
            return HedtechMessage == ExpectedMessage;

        }
    }

    public class SchemaValidation: Validation,IValidation<SchemaValidationInfo>
    {

        public SchemaValidationInfo Validate(ReponseResult responseData)
        {
            SchemaValidationInfo info = new SchemaValidationInfo();
            return info;
        }
    }
    public class SchemaValidationInfo
    {
        public string SchemaUrl { get; set; }
        public string Schema { get; set; }
        public JObject SchemaValidatedJson { get; set; }
        public string SchemaValid { get; set; }
        public string SchemaErrors { get; set; }

    }

    public class ListHeaderMessageValidation : Validation, IValidation<ListHeaderMessageValidationInfo>
    {
        public ListHeaderMessageValidationInfo Validate(ReponseResult responseData)
        {
            ListHeaderMessageValidationInfo info = new ListHeaderMessageValidationInfo();
            info.ExpectedListHeaderMessage= "List of " + singularizeEndPoint(responseData.EndPoint) + " resources";
            info.ListHeaderMessage = responseData.GetListMessage;
            info.ListHeaderMessageValid = checkHeaderMessage(info.ListHeaderMessage, info.ExpectedListHeaderMessage);
            return info;
        }

    }
    public class ListHeaderMessageValidationInfo
    {
        public string ListHeaderMessage { get; set; }
        public string ExpectedListHeaderMessage { get; set; }
        public Boolean ListHeaderMessageValid { get; set; }
    }



}