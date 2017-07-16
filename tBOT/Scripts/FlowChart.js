var app = angular.module('QueryApp', ['flowchart'])
    .factory('prompt', function () {
        return prompt;
    })
    .config(function (NodeTemplatePathProvider) {
        NodeTemplatePathProvider.setTemplatePath("flowchart/node.html");
    });

app.controller('AppCtrl', function AppCtrl($scope, prompt, Modelfactory, flowchartConstants) {

        var deleteKeyCode = 46;
        var ctrlKeyCode = 17;
        var aKeyCode = 65;
        var escKeyCode = 27;
        var nextNodeID = 10;
        var nextConnectorID = 20;
        var ctrlDown = false;

        var model = {
            nodes: [
                {
                    "id": 2,
                    "name": "Environment-1",
                    "x": 10,
                    "y": 10,
                    connectors: [
                        {
                            name: 'column1',
                            type: flowchartConstants.bottomConnectorType,
                            id: 9,
                            isChecked: true
                        },
                        {
                            name: 'column2',
                            type: flowchartConstants.bottomConnectorType,
                            id: 10,
                            isChecked: false
                        }
                    ],
                },
                {
                    "id": 3,
                    "name": "Environment-2",
                    "x": 400,
                    "y": 250,
                    connectors: [
                        {
                            name: 'column1',
                            type: flowchartConstants.topConnectorType,
                            id: 1,
                            isChecked: false
                        },
                        {
                            name: 'column2',
                            type: flowchartConstants.topConnectorType,
                            id: 2,
                            isChecked: false
                        },
                        {
                            name: 'column3',
                            type: flowchartConstants.topConnectorType,
                            id: 3,
                            isChecked: false
                        },
                        {
                            name: 'column4',
                            type: flowchartConstants.bottomConnectorType,
                            id: 4,
                            isChecked: false
                        },
                        {
                            name: 'column5',
                            type: flowchartConstants.bottomConnectorType,
                            id: 5,
                            isChecked: false
                        },
                        {
                            name: 'column6',
                            type: flowchartConstants.bottomConnectorType,
                            id: 12,
                            isChecked: false
                        }
                    ]
                },
                {
                    "id": 4,
                    "name": "Environment-3",
                    "x": 700,
                    "y": 500,
                    connectors: [
                        {
                            name: 'column1',
                            type: flowchartConstants.topConnectorType,
                            id: 13,
                            isChecked: false
                        },
                        {
                            name: 'column2',
                            type: flowchartConstants.topConnectorType,
                            id: 14,
                            isChecked: false
                        },
                        {
                            name: 'column3',
                            type: flowchartConstants.bottomConnectorType,
                            id: 15,
                            isChecked: false
                        }
                    ]
                },
                {
                    "id": 5,
                    "name": "Environment-4",
                    "x": 100,
                    "y": 500,
                    connectors: [
                        {
                            name: 'column1',
                            type: flowchartConstants.topConnectorType,
                            id: 16,
                            isChecked: false
                        },
                        {
                            name: 'column2',
                            type: flowchartConstants.topConnectorType,
                            id: 17,
                            isChecked: false
                        },
                        {
                            name: 'column3',
                            type: flowchartConstants.topConnectorType,
                            id: 18,
                            isChecked: true
                        }
                    ]

                }
            ],
            edges: [
                {
                    source: 10,
                    destination: 1
                },
                {
                    source: 5,
                    destination: 14
                },
                {
                    source: 5,
                    destination: 18
                }
            ]
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
            var nodeName = prompt("Enter a node name:", "New node");
            if (!nodeName) {
                return;
            }

            var newNode = {
                name: nodeName,
                id: nextNodeID++,
                x: 200,
                y: 100,
                connectors: [
                    {
                        name: 'column1,',
                        id: nextConnectorID++,
                        type: flowchartConstants.topConnectorType,
                        isChecked: false
                    },
                    {
                        name: 'column2',
                        id: nextConnectorID++,
                        type: flowchartConstants.topConnectorType,
                        isChecked: false
                    },
                    {
                        name: 'column3',
                        id: nextConnectorID++,
                        type: flowchartConstants.bottomConnectorType,
                        isChecked: true
                    },
                    {
                        name: 'column4',
                        id: nextConnectorID++,
                        type: flowchartConstants.bottomConnectorType,
                        isChecked: false
                    }
                ]
            };

            model.nodes.push(newNode);
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
