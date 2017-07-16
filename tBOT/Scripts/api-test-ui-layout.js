'use strict';

var app = angular.module('api.test.ui.layout', []);
app.controller('uiLayoutCtrl', ['$scope', '$attrs', '$element', '$window', 'LayoutContainer',
    function uiLayoutCtrl($scope, $attrs, $element, $window, LayoutContainer) {
        
        var ctrl = this;
        var opts = angular.extend({}, $scope.$eval($attrs.uiLayout), $scope.$eval($attrs.options));
        var animationFrameRequested;
        var lastPos;

        var RoutineSplitterValue = 10,
            PlannerSplitterValue = 10,
            PlannerAreaMaxvalue = .5,
            PlannerAreaMinvalue = .35,
            RoutineAreaMaxvalue = .5,
            RoutineAreaMinvalue = .2;

        ctrl.containers = [];
        ctrl.movingSplitbar = null;

        $element.addClass('stretch');
        $element.addClass('ui-layout-column');
  
        function draw() {

            var currentWidth = $element[0].getBoundingClientRect()['width']

            var RoutineArea = ctrl.containers[0],
                RoutineSplitter = ctrl.containers[1],
                PlannerArea = ctrl.containers[2],
                PlannerSplitter = ctrl.containers[3],
                BuilderArea = ctrl.containers[4];

            var availableSize = currentWidth - (RoutineSplitter.size + PlannerSplitter.size)

            RoutineArea.minSize = availableSize * RoutineAreaMinvalue;
            RoutineArea.maxSize = availableSize * RoutineAreaMaxvalue;

            PlannerArea.minSize = availableSize * PlannerAreaMinvalue
            PlannerArea.maxSize = availableSize * PlannerAreaMaxvalue

                switch (ctrl.containers.indexOf(ctrl.movingSplitbar)) {
                    case 1:

                        var newPosition = (lastPos > RoutineArea.maxSize) ? RoutineArea.maxSize :
                            lastPos < RoutineArea.minSize ? RoutineArea.minSize : lastPos;
                        var difference = RoutineSplitter.left - newPosition

                        RoutineSplitter.left = newPosition;
                        RoutineArea.size = RoutineArea.size - difference;
                        PlannerArea.left = PlannerArea.left - difference;
                        PlannerSplitter.left = PlannerSplitter.left - difference;
                        BuilderArea.left = BuilderArea.left - difference;
                        BuilderArea.size = (currentWidth - BuilderArea.left)

                        break;
                    case 3:

                        PlannerArea.maxSize += (RoutineArea.size + RoutineSplitter.size)
                        PlannerArea.minSize += (RoutineArea.size + RoutineSplitter.size)

                        var newPosition = lastPos > PlannerArea.maxSize ? PlannerArea.maxSize :
                            lastPos < PlannerArea.minSize ? PlannerArea.minSize : lastPos;
                        var difference = PlannerSplitter.left - newPosition;

                        PlannerSplitter.left = newPosition;
                        PlannerArea.size = PlannerArea.size - difference;
                        BuilderArea.left = BuilderArea.left - difference;
                        BuilderArea.size = (currentWidth - BuilderArea.left)
                        break;
                    default:
                       break;

                }

            //Enable a new animation frame
            animationFrameRequested = null;
        }


        ctrl.mouseUpHandler = function (event) {
            if (ctrl.movingSplitbar !== null) {
                ctrl.movingSplitbar = null;
            }
            return event;
        };

        ctrl.mouseMoveHandler = function (mouseEvent) {
            
            lastPos = mouseEvent['clientX'] || (mouseEvent.originalEvent && mouseEvent.originalEvent['clientX']) ||

            ($window.jQuery ? (mouseEvent.originalEvent ? mouseEvent.originalEvent.targetTouches[0]['clientX'] : 0)
                    : (mouseEvent.targetTouches ? mouseEvent.targetTouches[0]['clientX'] : 0));

            //Cancel previous rAF call
            if (animationFrameRequested) {
                window.cancelAnimationFrame(animationFrameRequested);
            }

            //TODO: cache layout values

            //Animate the page outside the event
            animationFrameRequested = window.requestAnimationFrame(draw);
        };

        ctrl.calculate = function () {

            var RoutineArea = ctrl.containers[0],
                RoutineSplitter = ctrl.containers[1],
                PlannerArea = ctrl.containers[2],
                PlannerSplitter = ctrl.containers[3],
                BuilderArea = ctrl.containers[4];

            var currentWidth = $element[0].getBoundingClientRect()['width']


            RoutineSplitter.size = RoutineSplitterValue;
            PlannerSplitter.size = PlannerSplitterValue;

            var availableSize = currentWidth - (RoutineSplitter.size + PlannerSplitter.size)

            RoutineArea.minSize = availableSize * RoutineAreaMinvalue;
            RoutineArea.maxSize = availableSize * RoutineAreaMaxvalue;

            PlannerArea.minSize = availableSize * PlannerAreaMinvalue
            PlannerArea.maxSize = availableSize * PlannerAreaMaxvalue

            RoutineArea.left = 0;
            
            RoutineArea.size = RoutineArea.collapsed ? 0 : RoutineArea.minSize;

            if (PlannerArea.collapsed)
            {
                RoutineSplitter.left = 0;
                RoutineSplitter.size=0
                PlannerArea.size = PlannerArea.minSize;
            }
            else
            {
                RoutineSplitter.left = RoutineArea.size;
                PlannerArea.size = PlannerArea.minSize;
            }

            PlannerArea.left = RoutineSplitter.left + RoutineSplitter.size;
            PlannerArea.size = PlannerArea.collapsed ? 0 : PlannerArea.minSize;

            PlannerSplitter.left = PlannerArea.left + PlannerArea.size            
            

            BuilderArea.left = PlannerSplitter.left + PlannerSplitter.size;
            BuilderArea.size = parseInt(currentWidth - BuilderArea.left);

        };

        ctrl.addContainer = function (container) {

            ctrl.containers.splice(ctrl.containers.length, 0, container);

            //Call calculate when all the containers are added
            if (ctrl.containers.length == 5) { ctrl.calculate();}
            
        };

        ctrl.planSplitToggle = function () {

            var RoutineArea = ctrl.containers[0],
                RoutineSplitter = ctrl.containers[1],
                PlannerArea = ctrl.containers[2],
                PlannerSplitter = ctrl.containers[3],
                BuilderArea = ctrl.containers[4];

            var currentWidth = $element[0].getBoundingClientRect()['width']

            PlannerArea.collapsed = !PlannerArea.collapsed;
            RoutineArea.collapsed = !RoutineArea.collapsed;  
            if (PlannerArea.collapsed)//before collapsing store value in uncollapsedSize
            {
                RoutineArea.uncollapsedSize = RoutineArea.size;
                PlannerArea.uncollapsedSize = PlannerArea.size;
                BuilderArea.uncollapsedSize = BuilderArea.size;                

                PlannerSplitter.RoutineAreaUnCollapsedwidth = RoutineArea.size;
                PlannerSplitter.PlannerAreaUnCollapsedwidth = PlannerArea.size;

                PlannerSplitter.beforeCollapsedWindowWidth = currentWidth

                RoutineArea.size = 0;
                RoutineSplitter.size = 0;
                PlannerArea.size = 0;
                PlannerSplitter.left = 0
                BuilderArea.left = 0
                BuilderArea.size = (currentWidth - BuilderArea.left)
                

            }
            else {

                PlannerArea.uncollapsedSize = (PlannerSplitter.PlannerAreaUnCollapsedwidth * currentWidth / PlannerSplitter.beforeCollapsedWindowWidth)
                if (PlannerSplitter.PlannerAreaUnCollapsedwidth < PlannerArea.uncollapsedSize) {
                    if (PlannerArea.uncollapsedSize < (currentWidth * PlannerAreaMinvalue))
                    {
                        PlannerArea.uncollapsedSize = (currentWidth * PlannerAreaMinvalue)
                    }
                }
                else {
                    if (PlannerArea.uncollapsedSize > (currentWidth * PlannerAreaMaxvalue))
                    {
                        PlannerArea.uncollapsedSize = (currentWidth * PlannerAreaMaxvalue)
                    }
                }

                RoutineArea.uncollapsedSize = (PlannerSplitter.RoutineAreaUnCollapsedwidth * currentWidth / PlannerSplitter.beforeCollapsedWindowWidth)
                if (PlannerSplitter.RoutineAreaUnCollapsedwidth < RoutineArea.uncollapsedSize) {
                    if (RoutineArea.uncollapsedSize < (currentWidth * RoutineAreaMinvalue)) {
                        RoutineArea.uncollapsedSize = (currentWidth * RoutineAreaMinvalue)
                    }
                }
                else {
                    if (RoutineArea.uncollapsedSize > (currentWidth * RoutineAreaMaxvalue)) {
                        RoutineArea.uncollapsedSize = (currentWidth * RoutineAreaMaxvalue)
                    }
                }

                RoutineArea.left = 0;
                RoutineArea.size = RoutineArea.uncollapsedSize;
                
                RoutineSplitter.left = RoutineArea.size;
                RoutineSplitter.size = RoutineSplitterValue;
                
                PlannerArea.left = RoutineSplitter.left + RoutineSplitter.size;
                PlannerArea.size = PlannerArea.uncollapsedSize;                
                
                PlannerSplitter.left = PlannerArea.left + PlannerArea.size
                PlannerSplitter.size = PlannerSplitterValue

                BuilderArea.left = PlannerSplitter.left + PlannerSplitter.size;
                BuilderArea.size = (currentWidth - BuilderArea.left)
            }

            return PlannerArea.collapsed;
        };

        ctrl.rotnSplitToggle = function () {

            var RoutineArea = ctrl.containers[0],
                RoutineSplitter = ctrl.containers[1],
                PlannerArea = ctrl.containers[2],
                PlannerSplitter = ctrl.containers[3],
                BuilderArea = ctrl.containers[4];

            var currentWidth = $element[0].getBoundingClientRect()['width']

            RoutineArea.collapsed = !RoutineArea.collapsed;
            if (RoutineArea.collapsed)//before collapsing store value in uncollapsedSize
            {
                RoutineArea.uncollapsedSize = RoutineArea.size;
                PlannerArea.uncollapsedSize = PlannerArea.size;
                BuilderArea.uncollapsedSize = BuilderArea.size;

                RoutineSplitter.RoutineAreaUnCollapsedwidth = RoutineArea.size;
                RoutineSplitter.PlannerAreaUnCollapsedwidth = PlannerArea.size;
                RoutineSplitter.beforeCollapsedWindowWidth = currentWidth

                RoutineArea.size = 0;
                RoutineSplitter.left = RoutineSplitter.size
                BuilderArea.size = (currentWidth - PlannerSplitter.size)

                RoutineArea.size = 0;
                RoutineSplitter.left = 0;

                PlannerArea.left = RoutineSplitter.size;
                PlannerArea.size = PlannerArea.uncollapsedSize;

                PlannerSplitter.left = PlannerArea.left + PlannerArea.size
                PlannerSplitter.size = PlannerSplitterValue

                BuilderArea.left = PlannerSplitter.left + PlannerSplitter.size
                BuilderArea.size = (currentWidth - BuilderArea.left)

            }
            else {

                PlannerArea.uncollapsedSize = (RoutineSplitter.PlannerAreaUnCollapsedwidth * currentWidth / RoutineSplitter.beforeCollapsedWindowWidth)
                if (RoutineSplitter.PlannerAreaUnCollapsedwidth < PlannerArea.uncollapsedSize) {
                    if (PlannerArea.uncollapsedSize < (currentWidth * PlannerAreaMinvalue)) {
                        PlannerArea.uncollapsedSize = (currentWidth * PlannerAreaMinvalue)
                    }
                }
                else {
                    if (PlannerArea.uncollapsedSize > (currentWidth * PlannerAreaMaxvalue)) {
                        PlannerArea.uncollapsedSize = (currentWidth * PlannerAreaMaxvalue)
                    }
                }

                RoutineArea.uncollapsedSize = (RoutineSplitter.RoutineAreaUnCollapsedwidth * currentWidth / RoutineSplitter.beforeCollapsedWindowWidth)
                if (RoutineSplitter.RoutineAreaUnCollapsedwidth < RoutineArea.uncollapsedSize) {
                    if (RoutineArea.uncollapsedSize < (currentWidth * RoutineAreaMinvalue)) {
                        RoutineArea.uncollapsedSize = (currentWidth * RoutineAreaMinvalue)
                    }
                }
                else {
                    if (RoutineArea.uncollapsedSize > (currentWidth * RoutineAreaMaxvalue)) {
                        RoutineArea.uncollapsedSize = (currentWidth * RoutineAreaMaxvalue)
                    }
                }

                RoutineArea.left = 0;
                RoutineArea.size = RoutineArea.uncollapsedSize;

                RoutineSplitter.left = RoutineArea.uncollapsedSize;
                RoutineSplitter.size = RoutineSplitterValue;

                PlannerArea.left = RoutineSplitter.left + RoutineSplitter.size;
                PlannerArea.size = PlannerArea.uncollapsedSize;

                PlannerSplitter.left = PlannerArea.left + PlannerArea.size
                PlannerSplitter.size = PlannerSplitterValue

                BuilderArea.left = PlannerSplitter.left + PlannerSplitter.size
                BuilderArea.size = (currentWidth - BuilderArea.left)
            }
            return RoutineArea.collapsed;
        };

        return ctrl;
    }]);

app.directive('uiLayout', ['$window', function ($window) {
    return {
        restrict: 'AE',
        controller: 'uiLayoutCtrl',
        link: function (scope, element, attrs, ctrl) {
            scope.$watch(function () {
                return element[0]['offsetWidth'];
            },
                function () {
                ctrl.calculate();
            });

            function onResize() {
                scope.$evalAsync(function () {
                    ctrl.calculate();
                });
            }

            angular.element($window).bind('resize', onResize);

            scope.$on('$destroy', function () {
                angular.element($window).unbind('resize', onResize);
            });
        }
    };
}]);

app.directive('planSplit', ['LayoutContainer', function (LayoutContainer) {
    // Get all the page.
    var htmlElement = angular.element(document.body.parentElement);

    return {
        restrict: 'EAC',
        require: '^uiLayout',
        scope: {},

        link: function (scope, element, attrs, ctrl) {
            if (!element.hasClass('stretch')) element.addClass('stretch');
            if (!element.hasClass('plan-split')) element.addClass('plan-split');

            var animationClass = 'animate-column';
            element.addClass(animationClass);

            scope.splitbar = LayoutContainer.Splitbar();
            scope.splitbar.element = element;

            //icon <a> elements
            var prevButton = angular.element(element.children()[0]);

            //icon <span> elements
            var prevIcon = angular.element(prevButton.children()[0]);

            //icon classes
            prevIcon.addClass('ui-splitbar-icon-left');

            prevButton.on('click', function () {

                var result = ctrl.planSplitToggle();

                    if (result) {
                        prevIcon.removeClass('ui-splitbar-icon-left');
                        prevIcon.addClass('ui-splitbar-icon-right');

                    } else {
                        prevIcon.removeClass('ui-splitbar-icon-right');
                        prevIcon.addClass('ui-splitbar-icon-left');

                    }

                scope.$evalAsync(function () {
                    //ctrl.calculate();
                });
            });

            element.on('mousedown touchstart', function (e) {
                if (e.button === 0 || e.type === 'touchstart') {
                    // only trigger when left mouse button is pressed:
                    ctrl.movingSplitbar = scope.splitbar;

                    e.preventDefault();
                    e.stopPropagation();

                    htmlElement.on('mousemove touchmove', handleMouseMove);
                    return false;
                }
            });

            function handleMouseMove(event) {
                scope.$apply(angular.bind(ctrl, ctrl.mouseMoveHandler, event));
            }

            function handleMouseUp(event) {
                scope.$apply(angular.bind(ctrl, ctrl.mouseUpHandler, event));
                htmlElement.off('mousemove touchmove', handleMouseMove);
            }

            htmlElement.on('mouseup touchend', handleMouseUp);

            scope.$watch('splitbar.size', function (newValue) {
                element.css('width', newValue + 'px');
            });

            scope.$watch('splitbar.left', function (newValue) {
                element.css('left', newValue + 'px');
            });

            //Add splitbar to layout container list
            ctrl.addContainer(scope.splitbar);

            element.on('$destroy', function () {
                htmlElement.off('mouseup touchend', handleMouseUp);
                htmlElement.off('mousemove touchmove', handleMouseMove);
                scope.$evalAsync();
            });
        }
    };

}]);

app.directive('rotnSplit', ['LayoutContainer', function (LayoutContainer) {
    // Get all the page.
    var htmlElement = angular.element(document.body.parentElement);

    return {
        restrict: 'EAC',
        require: '^uiLayout',
        scope: {},

        link: function (scope, element, attrs, ctrl) {
            if (!element.hasClass('stretch')) element.addClass('stretch');
            if (!element.hasClass('rotn-split')) element.addClass('rotn-split');

            var animationClass = 'animate-column';
            element.addClass(animationClass);

            scope.splitbar = LayoutContainer.Splitbar();
            scope.splitbar.element = element;

            //icon <a> elements
            var prevButton = angular.element(element.children()[0]);

            //icon <span> elements
            var prevIcon = angular.element(prevButton.children()[0]);

            //icon classes
            prevIcon.addClass('ui-splitbar-icon-left');

            prevButton.on('click', function () {

                var result = ctrl.rotnSplitToggle();

                if (result) {
                    prevIcon.removeClass('ui-splitbar-icon-left');
                    prevIcon.addClass('ui-splitbar-icon-right');

                } else {
                    prevIcon.removeClass('ui-splitbar-icon-right');
                    prevIcon.addClass('ui-splitbar-icon-left');
                }

                scope.$evalAsync(function () {
                    //ctrl.calculate();
                });
            });

            element.on('mousedown touchstart', function (e) {
                if (e.button === 0 || e.type === 'touchstart') {
                    //triggered when left mouse button is pressed:
                    ctrl.movingSplitbar = scope.splitbar;

                    e.preventDefault();
                    e.stopPropagation();

                    htmlElement.on('mousemove touchmove', handleMouseMove);
                    return false;
                }
            });

            function handleMouseMove(event) {
                scope.$apply(angular.bind(ctrl, ctrl.mouseMoveHandler, event));
            }

            function handleMouseUp(event) {
                scope.$apply(angular.bind(ctrl, ctrl.mouseUpHandler, event));
                htmlElement.off('mousemove touchmove', handleMouseMove);
            }

            htmlElement.on('mouseup touchend', handleMouseUp);

            scope.$watch('splitbar.size', function (newValue) {
                element.css('width', newValue + 'px');
            });

            scope.$watch('splitbar.left', function (newValue) {
                element.css('left', newValue + 'px');
            });

            //Add splitbar to layout container list
            ctrl.addContainer(scope.splitbar);

            element.on('$destroy', function () {
                htmlElement.off('mouseup touchend', handleMouseUp);
                htmlElement.off('mousemove touchmove', handleMouseMove);
                scope.$evalAsync();
            });
        }
    };

}]);

app.directive('uiLayoutContainer',
    ['LayoutContainer', '$compile',
        function (LayoutContainer, $compile) {
            return {
                restrict: 'AE',
                require: '^uiLayout',
                scope: {
                    collapsed: '=',
                    resizable: '=',
                    size: '@',
                    minSize: '@',
                    maxSize: '@'
                },

                compile: function () {
                    return {
                        pre: function (scope, element, attrs, ctrl) {

                            scope.container = LayoutContainer.Container();
                            scope.container.element = element;
                            scope.container.size = scope.size;
                            scope.container.uncollapsedSize = scope.size;
                            scope.container.minSize = scope.minSize;
                            scope.container.maxSize = scope.maxSize;
                            ctrl.addContainer(scope.container);

                        },
                        post: function (scope, element, attrs, ctrl) {
                            if (!element.hasClass('stretch')) element.addClass('stretch');
                            if (!element.hasClass('ui-layout-container')) element.addClass('ui-layout-container');

                            var animationClass = 'animate-column';                                                      
                            element.addClass(animationClass);

                            scope.$watch('container.size', function (newValue) {
                                element.css('width', newValue + 'px');
                                if (newValue === 0) {
                                    element.addClass('ui-layout-hidden');
                                } else {
                                    element.removeClass('ui-layout-hidden');
                                }
                            });

                            scope.$watch('container.left', function (newValue) {
                                element.css('left', newValue + 'px');
                            });
                        }
                    };
                }
            };
        }]);

app.factory('LayoutContainer', function () {
    function BaseContainer() {

            this.size = null;
            this.uncollapsedSize = null;
            this.maxSize = null;
            this.minSize = null;
            this.resizable = true;
            this.element = null;
            this.collapsed = false;
        }

        function SplitbarContainer() {
            this.size = 0;
            this.left = 0;
            this.top = 0;
            this.element = null;
        }

        return {
            Container: function (initialSize) {
                return new BaseContainer(initialSize);
            },
            Splitbar: function () {
                return new SplitbarContainer();
            }
        };
    });