var app = angular.module('QueryApp', ['flowchart'])
    .factory('prompt', function () {
        return prompt;
    })
    .config(function (NodeTemplatePathProvider) {
        NodeTemplatePathProvider.setTemplatePath("flowchart/node.html");
    });

app.controller('AppCtrl', function AppCtrl($scope, $log, $http, $uibModal, $filter, prompt, QueryBuilderFactory, Modelfactory, flowchartConstants) {
    var vm = this;

    var deleteKeyCode = 46;
    var ctrlKeyCode = 17;
    var aKeyCode = 65;
    var escKeyCode = 27;
    var nextNodeID = 10;
    var nodeXAxies = 0;
    var nodeYAxies = 0;
    var nextConnectorID = 20;
    var ctrlDown = false;

    var model = {
        "nodes": [
            {
                "name": "GURWADB",
                "id": 10,
                "x": 50,
                "y": 25,
                "connectors": [
                    {
                        "name": "GURWADB_APPLICATION_NAME",
                        "id": 20,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_PRODUCT",
                        "id": 21,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_RELEASE",
                        "id": 22,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_STAGE_DATE",
                        "id": 23,
                        "null": "Y",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_SURROGATE_ID",
                        "id": 24,
                        "null": "Y",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_VERSION",
                        "id": 25,
                        "null": "Y",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_USER_ID",
                        "id": 26,
                        "null": "Y",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_DATA_ORIGIN",
                        "id": 27,
                        "null": "Y",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_ACTIVITY_DATE",
                        "id": 28,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_VPDI_CODE",
                        "id": 29,
                        "null": "Y",
                        "type": "topConnector",
                        "isChecked": false
                    }
                ]
            },

            {
                "name": "newOne",
                "id": 16,
                "x": 53,
                "y": 434,
                "connectors": [
                    {
                        "name": "GURWADB_APPLICATION_NAME",
                        "id": 220,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_PRODUCT",
                        "id": 221,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_RELEASE",
                        "id": 222,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_STAGE_DATE",
                        "id": 223,
                        "null": "Y",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_SURROGATE_ID",
                        "id": 224,
                        "null": "Y",
                        "type": "topConnector",
                        "isChecked": false
                    }
                ]
            },

            {
                "name": "OldOne",
                "id": 17,
                "x": 381,
                "y": 531,
                "connectors": [
                    {
                        "name": "GURWADB_APPLICATION_NAME",
                        "id": 120,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "GURWADB_PRODUCT",
                        "id": 121,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    }
                ]
            },

            {
                "name": "SARLXMS",
                "id": 11,
                "x": 377,
                "y": 51,
                "connectors": [
                    {
                        "name": "SARLXMS_SURROGATE_ID",
                        "id": 30,
                        "null": "Y",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "SARLXMS_VERSION",
                        "id": 31,
                        "null": "Y",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "SARLXMS_USER_ID",
                        "id": 32,
                        "null": "Y",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "SARLXMS_DATA_ORIGIN",
                        "id": 33,
                        "null": "Y",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "SARLXMS_VPDI_CODE",
                        "id": 34,
                        "null": "Y",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "SARLXMS_AIDM",
                        "id": 35,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "SARLXMS_APPL_SEQNO",
                        "id": 36,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "SARLXMS_ASSIGNED_NBR",
                        "id": 37,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "SARLXMS_SEQNO",
                        "id": 38,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "SARLXMS_LOAD_IND",
                        "id": 39,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "SARLXMS_ACTIVITY_DATE",
                        "id": 40,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    },
                    {
                        "name": "SARLXMS_MSG",
                        "id": 41,
                        "null": "N",
                        "type": "topConnector",
                        "isChecked": false
                    }
                ]
            }
        ],
        "edges": []
    };

    $scope.model = model;

    vm.tableNameSelected;
    vm.columnNameSelected;

        
    $scope.flowchartselected = [];
    var modelservice = Modelfactory(model, $scope.flowchartselected);

    $scope.tableNameChange = function (tableName)
    {
       $scope.tableColumns = tableName != undefined ? $filter('filter')(model.nodes, { name: tableName.name }, true)[0] : null;

    }

    //$scope.Query = {
    //    "SELECT": "",
    //    "FROM": "GURWADB CROSS JOIN SARLXMS"
    //};

    $scope.filterOperator = {
        Equals:"=",
        LessThan:"<",
        GreaterThan:">",
        LessOrEqual:"<=",
        GreaterOrEqual:">=",
        NotEqualTo:"<>",
        //Contains:"LIKE",
        //DoesNotContain:"NOT LIKE"
        //StartsWith:
        //Includes
        //Excludes
        //Between:"BETWEEN AND"
        //WithIn:
    }



    $scope.Query ={
        "queryType": "SELECT",
        "groupBy":false,
            "tables": [
                {
                    "name": "GURWADB",
                    "id": 10,
                    "columns": [
                        {
                            "name": "GURWADB_APPLICATION_NAME",
                            "id": 20,
                            "null": "N", //"Y"
                            "dataType": "nvarchar", //"Number"
                            "OutPut": true,
                            "alias": "Expr1",
                            "sortType": "ASCE", //"DESC", ""
                            "sortOrder": 1,
                            "filter": [
                                {
                                    "operator": "<>",
                                    "value": "asdfd"
                                }
                            ]
                        },
                        {
                            "name": "GURWADB_PRODUCT",
                            "id": 21,
                            "null": "N", //"Y"
                            "dataType": "nvarchar", //"Number"
                            "OutPut": true,
                            "alias": "Expr1",
                            "sortType": "ASCE", //"DESC", ""
                            "sortOrder": 1,
                            "filter": [
                                {
                                    "operator": "<>",
                                    "value": "asdfd"
                                }
                            ]
                        }
                    ]
                },
                {
                    "name": "SARLXMS",
                    "id": 10,
                    "columns": [
                        {
                            "name": "SARLXMS_VPDI_CODE",
                            "id": 22,
                            "null": "N", //"Y"
                            "dataType": "nvarchar", //"Number"
                            "OutPut": true,
                            "alias": "Expr1",
                            "sortType": "ASCE", //"DESC", ""
                            "sortOrder": 1,
                            "filter": [
                                {
                                    "operator": "<>",
                                    "value": "asdfd"
                                }
                            ]
                        },
                        {
                            "name": "SARLXMS_DATA_ORIGIN",
                            "id": 23,
                            "null": "N", //"Y"
                            "dataType": "nvarchar", //"Number"
                            "OutPut": true,
                            "alias": "Expr1",
                            "sortType": "ASCE", //"DESC", ""
                            "sortOrder": 1,
                            "filter": [
                                {
                                    "operator": "<>",
                                    "value": "asdfd"
                                }
                            ]
                        }
                    ]
                }
            ]
    }



    //SELECT        APP
    //FROM            API
    //GROUP BY APP, Id
    //HAVING(APP <> N'sad')
    //ORDER BY APP, Id, APP


    //SELECT        APP
    //FROM            API
    //WHERE(APP <> N'sad')
    //ORDER BY APP, Id, APP

    //GROUP BY is only used in Select, when used, the filter clause will be changed from Where to Having
    //


    vm.selectedTable = 'Table/View';
    $scope.addTable = function ()
    {
        if (vm.selectedTable == 'Table/View')
        {
            $scope.addNewNode();
        }

    }

    vm.groupBy="Add Group By"
    $scope.groupByChange = function ()
    {
        vm.groupBy = vm.groupBy == "Add Group By" ? "Remove Group By" : "Add Group By";
    }

    vm.selectedQueryType = 'SELECT';
    var foundItem
    $scope.queryTypeChange = function (OldValue)
    {   
        if (vm.selectedQueryType != 'SELECT' && model.nodes.length > 1)
        {
            var ModalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'myModal.html',
                controller: 'InstanceController',
                keyboard:false,
                backdrop: true,
                resolve: { items: function () { return { tables: model.nodes, queryType: vm.selectedQueryType }; } }
            }).result.then(function (result) {
                $scope.msg = result;
                    if ($scope.msg == undefined)
                    {
                        vm.selectedQueryType = OldValue;
                    }
                else
                    {
                        //get the seleted index of the node
                        seletedNode = $filter('filter')(model.nodes, { id: $scope.msg.id }, true)[0];

                        //select all nodes
                        modelservice.selectAll()

                        //deselect only the seletedNode
                        modelservice.nodes.deselect(seletedNode);


                       //console.log(modelservice.edges.getSelectedEdges())

                        //delete seletedNodes
                        modelservice.deleteSelected();

                    }
                });
            
        }
    }


    
    $scope.modelservice = modelservice;


    $scope.keyDown = function (evt) {
        if (evt.keyCode === ctrlKeyCode) {
            ctrlDown = true;
            evt.stopPropagation();
            evt.preventDefault();
        }
    };

    $scope.keyUp = function (evt) {
        if (evt.keyCode === deleteKeyCode) {
            modelservice.deleteSelected();
        }

        if (evt.keyCode == aKeyCode && ctrlDown) {
            modelservice.selectAll();
        }

        if (evt.keyCode == escKeyCode) {
            modelservice.deselectAll();
        }

        if (evt.keyCode === ctrlKeyCode) {
            ctrlDown = false;
            evt.stopPropagation();
            evt.preventDefault();
        }
    };

    $scope.addNewNode = function () {
        var nodeName = prompt("Enter a table name:",);
        if (!nodeName) {
            return;
        }
        var connectors = [];
        $scope.tableSchemaRequestData = [];
            $scope.tableSchemaRequestData.splice(0, $scope.tableSchemaRequestData.length);//deletes all the items in the array
            $scope.tableSchemaRequestData.push({
                ["HostName"]: "149.24.38.229",
                ["PortNumber"]: "1521",
                ["ServiceName"]: "BAN83",
                ["UserId"]: "baninst1",
                ["Password"]: "u_pick_it",
                ["TableName"]: nodeName
            });

            QueryBuilderFactory.getTableDescribe($scope).then(function (d) {
                $scope.resultTableSchema = d.data;

                angular.forEach($scope.resultTableSchema, function (info) {
                    connectors.push({
                        ['name']: info.Name,
                        ['id']: nextConnectorID++,
                        ['null']: info.Null,
                        ['type']: flowchartConstants.topConnectorType,
                        ['isChecked']: false
                    });
                })
                    var newNode = {
                        name: nodeName,
                        id: nextNodeID++,
                        x: nodeXAxies+=50,
                        y: nodeYAxies+=25,
                        connectors
                };
                    if (connectors.length > 0) {
                        var hasRows = model.nodes.length > 0 ? true : false;
                        model.nodes.push(newNode);

                        if (hasRows) {
                            $scope.Query['FROM'] = $scope.Query['FROM'] + " CROSS JOIN " + nodeName
                        }
                        else {
                            $scope.Query['SELECT'] = "";
                            $scope.Query['FROM'] = nodeName;
                        }

                    }
                    else
                    { alert("No Table found with the name: " + nodeName)}
                    
            })            
        };

        $scope.activateWorkflow = function () {
            angular.forEach($scope.model.edges, function (edge) {
                edge.active = !edge.active;
            });
        };

        $scope.addNewInputConnector = function () {
            var connectorName = prompt("Enter a connector name:", "New connector");
            if (!connectorName) {
                return;
            }

            var selectedNodes = modelservice.nodes.getSelectedNodes($scope.model);
            for (var i = 0; i < selectedNodes.length; ++i) {
                var node = selectedNodes[i];
                node.connectors.push({ id: nextConnectorID++, type: flowchartConstants.topConnectorType });
            }
        };

        $scope.addNewOutputConnector = function () {
            var connectorName = prompt("Enter a connector name:", "New connector");
            if (!connectorName) {
                return;
            }

            var selectedNodes = modelservice.nodes.getSelectedNodes($scope.model);
            for (var i = 0; i < selectedNodes.length; ++i) {
                var node = selectedNodes[i];
                node.connectors.push({ id: nextConnectorID++, type: flowchartConstants.bottomConnectorType });
            }
        };

        $scope.deleteSelected = function () {
            modelservice.deleteSelected();
        };

        $scope.callbacks = {
            edgeDoubleClick: function () {

            },
            edgeMouseOver: function () {


            },
            //isValidEdge: function (source, destination) {
            //    return source.type === flowchartConstants.bottomConnectorType && destination.type === flowchartConstants.topConnectorType;

            //},
            edgeAdded: function (edge) {
                $scope.EdgeSourceConnectorName = modelservice.connectors.getConnector(edge.source).name;
                $scope.EdgeDestConnectorName = modelservice.connectors.getConnector(edge.destination).name;
                $scope.EdgeSourceNodeName = modelservice.nodes.getNode(edge.source).name;
                $scope.EdgeDestNodeName = modelservice.nodes.getNode(edge.destination).name;

                console.log($scope.EdgeSourceNodeName + "." + $scope.EdgeSourceConnectorName + " Join " + $scope.EdgeDestNodeName + "." + $scope.EdgeDestConnectorName);

            },
            nodeRemoved: function (node) {

                console.log("node removed")
                $scope.tableNameChange();

                //if ($scope.Query['SELECT'].indexOf("," + $scope.CheckboxNodeName + "." + $scope.CheckboxConnectorName) > -1) {
                //    $scope.Query['SELECT'] = $scope.Query['SELECT'].replace("," + $scope.CheckboxNodeName + "." + $scope.CheckboxConnectorName, "");
                //}


            },
            edgeRemoved: function (edge) {

            },
            checkboxChecked: function (connectorId, checkedStatus) {
                $scope.CheckboxChecked = checkedStatus;
                $scope.CheckboxConnectorName = modelservice.connectors.getConnector(connectorId).name;
                $scope.CheckboxNodeName = modelservice.nodes.getNode(connectorId).name;
                console.log($scope.CheckboxConnectorName + "." + $scope.CheckboxNodeName + "=" + $scope.CheckboxChecked);

                if ($scope.CheckboxChecked)
                {
                    $scope.Query['SELECT'] = $scope.Query['SELECT'] == "" ? $scope.Query['SELECT'] + $scope.CheckboxNodeName + "." + $scope.CheckboxConnectorName
                        : $scope.Query['SELECT'] + "," + $scope.CheckboxNodeName + "." + $scope.CheckboxConnectorName
                }
                    else
                {
                    if ($scope.Query['SELECT'].indexOf("," + $scope.CheckboxNodeName + "." + $scope.CheckboxConnectorName)>-1)
                    {
                        $scope.Query['SELECT'] = $scope.Query['SELECT'].replace("," + $scope.CheckboxNodeName + "." + $scope.CheckboxConnectorName , "");
                    }
                    else if ($scope.Query['SELECT'].indexOf($scope.CheckboxNodeName + "." + $scope.CheckboxConnectorName  + ",") ==0)
                    {
                        $scope.Query['SELECT'] = $scope.Query['SELECT'].replace($scope.CheckboxNodeName + "." + $scope.CheckboxConnectorName + ",", "");
                    }
                    else 
                    {
                        $scope.Query['SELECT'] = $scope.Query['SELECT'].replace($scope.CheckboxNodeName+ "." + $scope.CheckboxConnectorName, "");
                    }
                }

            },
            nodeCallbacks: {
                'doubleClick': function (event) {
                }
            }
        };
        modelservice.registerCallbacks($scope.callbacks.edgeAdded, $scope.callbacks.nodeRemoved, $scope.callbacks.edgeRemoved, $scope.callbacks.checkboxChecked);

        });


app.factory('QueryBuilderFactory', function ($http) {
    return {

        getTableSchema: function (scp) {
            console.log(scp.tableSchemaRequestData)
            return $http.post("/Builder/GetTableSchema", scp.tableSchemaRequestData[0]);
        },

            getAllTableNames: function (scp) {
                return $http.post("/Builder/GetAllTableNames", scp.tableSchemaRequestData[0]);
        },

        getTableDescribe: function (scp) {
            return $http.post("/Builder/GetTableDescription", scp.tableSchemaRequestData[0]);
        }
    };
});


app.controller('InstanceController', function ($scope, $uibModalInstance, items) {
    $scope.items = items;
    $scope.mydata;


    //$scope.radii = [{
    //    price: '$10',
    //    checked: true,
    //    name: "Messaging Value Packes"
    //}, {
    //    price: '$10',
    //    checked: false,
    //    name: "International Value Packs"
    //}];


    $scope.handleTableClick = function (table) {
        $scope.mydata = table;
    };

    $scope.ok = function () {
        //it close the modal and sends the result to controller
        $uibModalInstance.close($scope.mydata);
    };
    $scope.cancel = function () {
        $uibModalInstance.close();
        //$uibModalInstance.dismiss('cancel');
    };


});
