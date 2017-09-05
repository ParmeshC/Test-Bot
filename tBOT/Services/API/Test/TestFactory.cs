using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace tBOT.Services.API.Test
{
    public class TestFactory
    {
        

        public static dynamic CreateTestCaseTemplate(string typeNameString)
        {
            var assembly = Assembly.GetExecutingAssembly();
            Type baseType = typeof(TestCaseTemplate);
            var enumclass = assembly.GetTypes().Where(baseType.IsAssignableFrom).Where(t => baseType != t).Where(t => t.Name == typeNameString);
            if (enumclass.Count() == 0)
            {
                throw new Exception("Type " + typeNameString + " not found.");
            }
            Type type = enumclass.First();
            return Activator.CreateInstance(type);
        }


        public static dynamic CreateTestCondition(string typeNameString)
        {
            var assembly = Assembly.GetExecutingAssembly();
            Type baseType = typeof(ITestCaseCondition);
            var enumclass = assembly.GetTypes().Where(baseType.IsAssignableFrom).Where(t => baseType != t).Where(t => t.Name == typeNameString);
            if (enumclass.Count() == 0)
            {
                throw new Exception("Type " + typeNameString + " not found.");
            }
            Type type = enumclass.First();

            dynamic testConditionIstance = Activator.CreateInstance(type);
            testConditionIstance = CreateNestedInstance(testConditionIstance,"tBOT");
            return testConditionIstance;
        }

        private static dynamic CreateNestedInstance(dynamic Instance, string assemblyName)
        {
            //This function creates and assigns objects of all custom properties in the downward hierarchy for the passed in Instance Class Object.

            //This variable initially holds the parent instance object passed in and eventually takes in new child instance to go deep in the hierarchy.
            dynamic propertyInstance = Instance;
            List<PropertyInfo> propertyList = new List<PropertyInfo>(propertyInstance.GetType().GetProperties());

            var propertyInstanceList = new List<Tuple<PropertyInfo, dynamic>>();

            bool InstantiateCustumPropertie = true;

            while (InstantiateCustumPropertie)
            {
                InstantiateCustumPropertie = false;

                //******
                //This loop adds properties of an Instance on top of the other list that contains PropertyName and its associated Instance
                for (int i = propertyList.Count() - 1; i >= 0; i--)
                {
                    propertyInstanceList.Insert(0, new Tuple<PropertyInfo, dynamic>(propertyList[i], propertyInstance));
                    propertyList.RemoveAt(i);
                }
                //*******

                for (int i =0; i < propertyInstanceList.Count; i++)
                {
                    //This condition filters the custom properties by its NameSpace given in the argument
                    if (propertyInstanceList[i].Item1.PropertyType.Namespace.StartsWith(assemblyName))
                    {
                        //If there are properties for a created property instance, 
                        //it will be added to the list to iterate again, 
                        //in such circumstances this condition prevents duplicate creation.
                        if (propertyInstance.GetType() != propertyInstanceList[i].Item1.PropertyType)
                        {
                            //Creating Object Instance of the property
                            propertyInstance = Activator.CreateInstance(propertyInstanceList[i].Item1.PropertyType);
                            //Get List of Properties inside the created Object Instance of the property
                            propertyList = new List<PropertyInfo>(propertyInstance.GetType().GetProperties());
                        }
                        //If there are properties in the created instance, the loop will be broken to add items and rerun.
                        if (propertyList.Count!=0)
                        {
                            //The while condition is set to true to iterate propertyInstanceList again with the fresh List items.
                            InstantiateCustumPropertie = true;
                            break;
                        }
                        else
                        {
                            //Created Object Instance of the property is assigned to the property of the Parent Instance.
                            propertyInstanceList[i].Item1.SetValue(propertyInstanceList[i].Item2, propertyInstance, null);
                            //Parent Instance is stored in local variable before removing item from the List
                            propertyInstance = propertyInstanceList[i].Item2;
                        }                        
                    }
                    //Item is removed from the list.
                    propertyInstanceList.RemoveAt(i);
                    i--;//The counter has to decrease as the item in the list is removed otherwise the loop will skip the next item.
                }
            }
            return propertyInstance;
        }

    }
}