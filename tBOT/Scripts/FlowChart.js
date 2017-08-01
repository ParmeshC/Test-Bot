var app = angular.module('QueryApp', ['flowchart'])
    .factory('prompt', function () {
        return prompt;
    })
    .config(function (NodeTemplatePathProvider) {
        NodeTemplatePathProvider.setTemplatePath("flowchart/node.html");
    });

app.controller('AppCtrl', function AppCtrl($scope, prompt, QueryBuilderFactory, Modelfactory, flowchartConstants) {

    var deleteKeyCode = 46;
    var ctrlKeyCode = 17;
    var aKeyCode = 65;
    var escKeyCode = 27;
    var nextNodeID = 10;
    var nodeXAxies = 0;
    var nodeYAxies = 0;
    var nextConnectorID = 20;
    var ctrlDown = false;

    $scope.Query = {};

    var model = {
        nodes: [],
        edges: []
    };

    $scope.flowchartselected = [];
    var modelservice = Modelfactory(model, $scope.flowchartselected);

    $scope.model = model;
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
                    if (connectors.length > 0)
                    { model.nodes.push(newNode);}
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
            },
            nodeRemoved: function (node) {

            },
            edgeRemoved: function (edge) {

            },
            checkboxChecked: function (connectorId, checkedStatus) {
                $scope.CheckboxChecked = checkedStatus;
                $scope.CheckboxConnectorName = modelservice.connectors.getConnector(connectorId).name;
                $scope.CheckboxNodeName = modelservice.nodes.getNode(connectorId).name;
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
            },

            

    };
});
