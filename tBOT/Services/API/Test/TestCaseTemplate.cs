using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.Entity.Design.PluralizationServices;
using System.Globalization;
using System.Linq;
using System.Collections.Concurrent;
using System.Reflection;
using System.Collections;
using tBOT.Services.API.RESTful;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace tBOT.Services.API.Test
{

    public interface ITestCaseTemplate<ITestCondition, ITestResult>
    {
        ITestResult Execute(ITestCondition input);

    }
    public abstract class TestCaseTemplate
    {
        public static TestCaseCondition GetListofTestCaseConditions()
        {
            var assembly = Assembly.GetExecutingAssembly();
            Type baseType = typeof(TestCaseTemplate);
            var testCases = assembly.GetTypes().Where(baseType.IsAssignableFrom).Where(t => baseType != t) ;

            dynamic testCondition = new TestCaseCondition();

            Dictionary<string, object> testCaseConditions = new Dictionary<string, object>();
            foreach (var testCase in testCases)
            {

                Type type = testCase;

                //Getting the type array of the created Validation instance
                Type[] testCaseArgs = type.GetInterface("ITestCaseTemplate`2").GetGenericArguments();

                var testCaseCondition = TestFactory.CreateTestCondition(testCaseArgs[0].Name.ToString());
                testCondition.List[testCase.Name] = testCaseCondition;


            }
            return testCondition;
        }


        public static List<TestResponse> GetRequestResponse(List<TestRequest> TestRequest)
        {
            List<TestResponse> testResponseList = new List<TestResponse>();

            var results = RunTestCases(TestRequest);


            var listofTestCaseList = results.GroupBy(u => u.ApiEndPoint).Select(grp => grp.ToList()).ToList();

            

            foreach (var testCaseList in listofTestCaseList)
            {
                TestResponse testResponse = new TestResponse
                {
                    TestCasesList = testCaseList,
                    TotalCount = testCaseList.Count,
                    EndPoint = testCaseList.ElementAt(0).ApiEndPoint
                };
                foreach (var testCase in testCaseList)
                {                                       
                    testResponse.PassCount += testCase.TestCaseResult.Status == true ? 1 : 0;
                }
                testResponseList.Add(testResponse);
            }

            return testResponseList;

        }

        public static ConcurrentQueue<TestCase> RunTestCases(List<TestRequest> TestRequest)
        {

            List<TestCase> TestCasesList = new List<TestCase>();

            ConcurrentQueue<TestCase> queue = new ConcurrentQueue<TestCase>();
            Parallel.ForEach(TestRequest, (requestItem) =>
            {
                TestCase testCase = new TestCase();

                testCase.TestCaseName = requestItem.TestCaseName;
                testCase.ApiEndPoint = requestItem.ApiEndPoint;

                //Creatting the instance of Validation
                var testCaseTemplate = TestFactory.CreateTestCaseTemplate(requestItem.TestCaseTemplateName);

                //Getting the type array of the created Validation instance
                Type[] info = testCaseTemplate.GetType().GetInterface("ITestCaseTemplate`2").GetGenericArguments();


                var testCaseCondition = TestFactory.CreateTestCondition(info[0].Name.ToString());
                testCaseCondition = JsonConvert.DeserializeObject(requestItem.TestCaseCondition, testCaseCondition.GetType());
                testCase.TestCaseCondition = testCaseCondition;                

                testCase.TestCaseResult = testCaseTemplate.Execute(testCaseCondition);

                TestCasesList.Add(testCase);

                queue.Enqueue(testCase);
            });

            return queue;

        }


        protected static string SingularizeEndPoint(string EndPoint)
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

        protected static string GetResponseFieldValue(JArray ResponseArray, int ArrayIndex, string FieldName)
        {
            string fieldValue = null;
            if (ResponseArray != null)
            {
                if (ResponseArray.Count > ArrayIndex && ArrayIndex > -1)
                {
                    if (ResponseArray[ArrayIndex][FieldName] != null) fieldValue = ResponseArray[ArrayIndex][FieldName].ToString();
                }
            }
            return fieldValue;
        }


    }
}