var DesignExecutionApp = angular.module('api.test.design.execution', []);
DesignExecutionApp.controller('DesignExecutionCtrl', function ($filter, $scope, designExecutionFactory, DesignExecutionService, apiTestBroadcastService) {
     $scope.GlobalComponents = {};
     $scope.DropDownOptions = [];

     $scope.showExecutionBtn = true;
     $scope.showExecutionCancelBtn = false;
     $scope.showEndPointObjects = true;

     $scope.showTestCases = false;


     var tempGlobalComponents = {};
     var tempComponents = {};


     $scope.selectedFilter = function (object) {
         return object.selected === true;
     };


     designExecutionFactory.getTestTemplates().then(function (d) {
         $scope.TestTemplates = []
         for (prop in d.data.List) {
             $scope.TestTemplates.push({ 'Name': prop });
         }
     });



    $scope.ExecuteApiRequest = function () {
        var RequestObjectsAndTestCasesApplied = angular.copy($scope.RequestObjects);
        apiTestBroadcastService.globalBroadcast('RequestObjectsAndTestCasesApplied', RequestObjectsAndTestCasesApplied)
        $scope.showExecutionCancelBtn = true;
        $scope.showExecutionBtn = false;
        $scope.showTestCases = false;
        //$scope.showEndPointObjects = false;
        
    }


    $scope.ExecutionCancel = function () {
        apiTestBroadcastService.globalBroadcast('ExecutionCancel', true)
        $scope.showExecutionBtn = true;
        $scope.showExecutionCancelBtn = false;
        $scope.showEndPointObjects = true;
    }

    $scope.$on('handleRequestResponseInfoBroadcast', function () {
        if (apiTestBroadcastService.sharedObjects.RequestResponseInfo === null) {
            $scope.showExecutionBtn = true;
            $scope.showExecutionCancelBtn = false;  
            $scope.showEndPointObjects = true;
        }
        else
        {
            $scope.showExecutionBtn = false;
            $scope.showExecutionCancelBtn = false;  
            $scope.showEndPointObjects = false;
        }
    });



    $scope.$on('handleExecuteEndPointObjectIdBroadcast', function () {
        var executeEndPointObjectId = { 'EndPointObjectId': apiTestBroadcastService.sharedObjects.ExecuteEndPointObjectId };
        designExecutionFactory.getEndPointObjectComponentsforEndPointObjectId(executeEndPointObjectId).then(function (d) {
            $scope.ObjectsComponents = JSON.parse(d.data);

            designExecutionFactory.getEndPointComponentsAsJsonString().then(function (d) {
                tempGlobalComponents = JSON.parse(d.data)[0]

                GetGlobalComponents();
            });

        }); 
    });

    $scope.$on('handleExecuteEndPointObjectGroupSectionBroadcast', function () {
        var executeEndPointObjectGroupSection = { 'EndPointObjectGroupSection': apiTestBroadcastService.sharedObjects.ExecuteEndPointObjectGroupSection };
        designExecutionFactory.getEndPointObjectComponentsForEndPointObjectGroupSection(executeEndPointObjectGroupSection).then(function (d) {
            $scope.ObjectsComponents = JSON.parse(d.data);
            designExecutionFactory.getEndPointComponentsAsJsonString().then(function (d) {
                tempGlobalComponents = JSON.parse(d.data)[0]
                GetGlobalComponents();
            });
            
        });
    });
    
    var GetGlobalComponents = function () {
        $scope.selectedDropDownOption = []
        
        var returnValue = DesignExecutionService.getGlobalComponents(tempGlobalComponents, tempComponents);

        tempComponents = returnValue.Components;
        $scope.GlobalComponents = returnValue.GlobalComponents;
        $scope.DropDownOptions = returnValue.DropDowns;


        angular.forEach(returnValue.DropDowns, function (item) {
            angular.forEach(item.ValueList, function (innerItem) {
                if (tempComponents[innerItem.ComponentKey] === innerItem.Value)
                {
                    $scope.selectedDropDownOption.push(innerItem)
                }
            })
        })
        $scope.GetRequestObjects();
        
    }


    $scope.OptionChange = function (optionVal) {
        if (optionVal !== undefined) {
            tempComponents[optionVal.ComponentKey] = optionVal.Value;
            GetGlobalComponents();
        }
    }
    
    $scope.GetRequestObjects = function () {
        var newRequestObjects = [];        
        for (var k = 0; k < $scope.ObjectsComponents.length; k++) {
            newRequestObjects.push(DesignExecutionService.prepareRequestObject($scope.GlobalComponents, $scope.ObjectsComponents[k]));
            //Copying selected TestCases if the object and TestCases are already selected
            if ($scope.RequestObjects !== undefined && $scope.RequestObjects[k] !== undefined)
            {
                if (newRequestObjects[k].EndPointObjectId === $scope.RequestObjects[k].EndPointObjectId) {
                    newRequestObjects[k]['TestCaseList'] = angular.copy($scope.RequestObjects[k].TestCaseList);
                    newRequestObjects[k]['isAllSelected'] = angular.copy($scope.RequestObjects[k].isAllSelected);
                }
                else
                {
                    newRequestObjects[k]['TestCaseList'] = angular.copy($scope.selectedTestCasesFromList);
                    newRequestObjects[k]['isAllSelected'] = true;
                }
            }
        }
        $scope.RequestObjects = [];//clearing objects if data is already present or will be creating an new array object
        $scope.RequestObjects = angular.copy(newRequestObjects);//copying the new object values
    };

    $scope.ClearRequestObjects = function () {
        $scope.RequestObjects = undefined;
    }


    //*****************************Beginning******
    //This section helps to toggle with the check box for TestCaseSelection
    $scope.testCaseSelectionIsAllSelected = false;
    var testCaseSelectionGetAllSelected = function () {
        var testCaseSelectionSelectedItems = $scope.TestTemplates.filter(function (item) {
            return item.selected;
        });

        selectedTestCases(testCaseSelectionSelectedItems);
    };

    $scope.testCaseSelectionToggleAll = function () {
        //$scope.isAllSelected = !$scope.isAllSelected; //this line of code is needed if it is an array
        var testCaseSelectionToggleStatus = $scope.testCaseSelectionIsAllSelected;
        angular.forEach($scope.TestTemplates, function (itm) { itm.selected = testCaseSelectionToggleStatus; });
        testCaseSelectionGetAllSelected();
    };

    $scope.testCaseSelectionOptionToggled = function () {
        $scope.testCaseSelectionIsAllSelected = $scope.TestTemplates.every(function (itm) { return itm.selected; });
        testCaseSelectionGetAllSelected();
    };
    //*******************************End************

    var selectedTestCases = function (itemsSelected) {

        $scope.selectedTestCasesFromList = itemsSelected;
        copySelectedTestCasesList()
    };

    var copySelectedTestCasesList = function () {

        if ($scope.RequestObjects != undefined) {
            for (var i = 0; i < $scope.RequestObjects.length; i++) {
                $scope.RequestObjects[i]['TestCaseList'] = angular.copy($scope.selectedTestCasesFromList);
                $scope.RequestObjects[i]['isAllSelected'] = true;
            }
        }
    }

    //******************Beginning******
    //This section helps to toggle with the check box for TestCase applied for each Object
    var getAllSelected = function (index) {
        var selectedItems = $scope.RequestObjects[index]['TestCaseList'].filter(function (item) {
            return item.selected;
        });
    };

    $scope.toggleAll = function (index) {
        var toggleStatus = $scope.RequestObjects[index]['isAllSelected'];
        angular.forEach($scope.RequestObjects[index]['TestCaseList'], function (itm) { itm.selected = toggleStatus; });
        getAllSelected(index);
    };

    $scope.optionToggled = function (index) {
        $scope.RequestObjects[index]['isAllSelected'] = $scope.RequestObjects[index]['TestCaseList'].every(function (itm) { return itm.selected; });
        getAllSelected(index);
    };
    //*****************End***********
});


DesignExecutionApp.service('DesignExecutionService', function (designExecutionFactory) {

     this.prepareRequestObject = function (GlobalComponents, ObjectComponents) {
         var requestObjectComponents = {};


         for (var x = 0; x < 2; x++) {

             var Component = evaluateObjectComponents(requestObjectComponents, ObjectComponents)
             requestObjectComponents = evaluateGlobalComponents(GlobalComponents, Component)
         }         

         //EndPoint and EndPointObjectId does not need evaluation and are added directrly
         requestObjectComponents['EndPoint'] = ObjectComponents['EndPoint'] 
         requestObjectComponents['EndPointObjectId'] = ObjectComponents['EndPointObjectId']    

         return requestObjectComponents;
     };

     var evaluateObjectComponents = function (ProcessedComponents, ObjectComponents) {
         var Component = {};
                   
         for (ObjectComponentKey in ObjectComponents) {

                //Get Array of referenced components used in this specific Component
             var ComponentsArrayInString = getComponentsArrayInString(ObjectComponents[ObjectComponentKey]);

                //Loop through the Global Component References in the Component to check if it is not undefined before evaluating
                for (var z = 0; z < ComponentsArrayInString.length; z++) {

                    //If Object Component is undefined even after running again, it will take value from ProcessedComponents, which would have taken GlobalComponents value.
                    if (Component[ComponentsArrayInString[z]] === undefined) Component[ComponentsArrayInString[z]] = ProcessedComponents[ComponentsArrayInString[z]];

                    //Delete the array item if defined and reduce the counter else will skip the next iteration
                    if (Component[ComponentsArrayInString[z]] !== undefined) ComponentsArrayInString.splice(z, 1), z--;
             }

                //if there are no undefined Objects process the evaluation
                if (ComponentsArrayInString.length == 0) {
                    var ObjComponentValue = ObjectComponents[ObjectComponentKey]
                    
                    try { ObjComponentValue = eval(ObjComponentValue) } catch (error) { }      
                        Component[ObjectComponentKey] = ObjComponentValue;
                }//Need not have else statement, because when called for this specific component it will be undefined, making the condition to take GlobalComponents value.
            }
           
            return Component;
     }

     var evaluateGlobalComponents = function (GlobalComponents, Component) {
         var ProcessedComponents = {};

         for (GlobalComponentKey in GlobalComponents) {
            
             //Get Array of referenced components used in this specific Component
             var ComponentsArrayInString = getComponentsArrayInString(GlobalComponents[GlobalComponentKey]);             
             
             try { Component[GlobalComponentKey] = eval(Component[GlobalComponentKey]) } catch (error) { }
             if (ComponentsArrayInString.length !== 0 && Component[GlobalComponentKey] === undefined) {

                 //Loop through the Object component References in the GlobalComponents to check if it is not undefined before evaluating
                 for (var i = 0; i < ComponentsArrayInString.length; i++) {
                     //-----------------------Assign Object Componet if present Else Assign Global Component----------
                     //trying evaluation and assigning Object Component---------------
                     try { Component[ComponentsArrayInString[i]] = eval(Component[ComponentsArrayInString[i]]) } catch (error) { }

                     //Delete the array item if defined and reduce the counter else will skip the next iteration
                     if (Component[ComponentsArrayInString[i]] !== undefined) ComponentsArrayInString.splice(i, 1), i--;

                     //trying evaluation and assigning component from Global Component---------------
                     try { var ComponentValue = eval(GlobalComponents[ComponentsArrayInString[i]]) } catch (error) { }

                     //Assign and delete the array item if 'defined' and not 'null' and reduce the counter to avoid next iteration skipping
                     if (ComponentValue !== undefined && ComponentValue !== null)
                         Component[ComponentsArrayInString[i]] = ComponentValue, ComponentsArrayInString.splice(i, 1), i--;
                     //-----------------------------------------------------------------------------------------------------
                 }//----------End For Loop ComponentsArrayInString

                 ProcessedComponents[GlobalComponentKey] = ComponentsArrayInString.length === 0 ? eval(GlobalComponents[GlobalComponentKey]) : null;

             }

             else {
                 //trying evaluation and assigning Object Component                    
                 try { Component[GlobalComponentKey] = eval(Component[GlobalComponentKey]) } catch (error) { }
                 try { var GlobalComponentValue = eval(GlobalComponents[GlobalComponentKey]) } catch (error) { }

                 ProcessedComponents[GlobalComponentKey] = Component[GlobalComponentKey] !== undefined ? Component[GlobalComponentKey] : GlobalComponentValue
             }
         }
         return ProcessedComponents;
     }

     var getComponentsArrayInString = function (stringValue) {
         var returnValue = [];
         if (stringValue !== null && stringValue!==undefined) {

             //This will remove all the comments in the code
             const regex = /\/\*[\s\S]*?\*\/|([^\\:]|^)\/\/.*$/gm;
             stringValue = stringValue.toString().replace(regex);
             //*******
             const ComponentsPattern = /Component.[\w]+/g;
             var Components = stringValue.toString().match(ComponentsPattern)//replace the content in quotes with nothing 
             if (Components !== null) {
                 for (var i = 0; i < Components.length; i++) {
                     //replace array values after spliting
                     Array.prototype.splice.apply(Components, [i, 1].concat(Components[i].split('.')[1]));
                 };
                 returnValue = Components;
             }
         }
         return returnValue;
     }

     this.getGlobalComponents = function (GlobalComponents, Component) {
         var dropDownOptions = []
         var alteredGlobalComponents = {}

         if (angular.equals(Component, {}))
         {
             Component = evaluateGlobalComponents(GlobalComponents, Component);
         }             

         for (ComponentKey in Component) {
             if (Array.isArray(Component[ComponentKey])) {
                 Component[ComponentKey] = Component[ComponentKey][0]
             }
         }

         for (GlobalComponentKey in GlobalComponents) {

             alteredGlobalComponents[GlobalComponentKey] = GlobalComponents[GlobalComponentKey]

             if (getDropDownComponent(GlobalComponents[GlobalComponentKey])) {

                 var DropDownComponents = [];

                 var globalComponent = eval(GlobalComponents[GlobalComponentKey])
                    var belongs = false;
                     if (Array.isArray(globalComponent)) {
                     angular.forEach(globalComponent, function (itm) {
                         DropDownComponents.push({ 'ComponentKey': GlobalComponentKey, 'Value': itm })
                         if (Component[GlobalComponentKey] === itm) belongs = true;
                         });

                     dropDownOptions.push({ 'ComponentKey': GlobalComponentKey, 'ValueList': DropDownComponents });

                     alteredGlobalComponents[GlobalComponentKey] = "'" + Component[GlobalComponentKey] + "';";

                         if (!belongs) {    
                             Component[GlobalComponentKey] = DropDownComponents[0].Value;
                             alteredGlobalComponents[GlobalComponentKey] = "'" + DropDownComponents[0].Value + "';";
                         }
                     }
                     else
                     {
                         Component[GlobalComponentKey] = globalComponent
                         //alteredGlobalComponents[GlobalComponentKey] = "'" + globalComponent + "';";
                     }
             }

         }
         return { 'DropDowns': dropDownOptions, 'Components': Component, 'GlobalComponents': alteredGlobalComponents}
     }

     var getDropDownComponent = function (stringValue) {
         var returnValue = false;
         if (stringValue !== undefined) {
             if (stringValue !== null) {

                 //This will remove all the comments in the code
                 const regex = /\/\*[\s\S]*?\*\/|([^\\:]|^)\/\/.*$/gm;
                 stringValue = stringValue.replace(regex);
                 //******

                 var ComponentsPattern = /DropDown/g;
                 var Components = stringValue.match(ComponentsPattern)//replace the content in quotes with nothing 
                 if (Components !== null) {
                     returnValue = true;
                 }

             }
         }
         return returnValue;
     }

});

DesignExecutionApp.factory('designExecutionFactory', function ($http) {
    return {

        getTestTemplates: function () {
            return $http.get("/Planner/GetAllTestTemplates");
        },

        getEndPointComponentsAsJsonString: function () {
            return $http.get("/Planner/GetEndPointComponentsAsJsonString");
        },

        getEndPointObjectComponentsForEndPointObjectGroupSection: function (endPointObjectGroupSection) {
            return $http.post("/Planner/GetEndPointObjectComponentsForEndPointObjectGroupSection", endPointObjectGroupSection);
        },

        getEndPointObjectComponentsforEndPointObjectId: function (endPointObjectId) {
            return $http.post("/Planner/GetEndPointObjectComponentsforEndPointObjectId", endPointObjectId);
        }

    };
});