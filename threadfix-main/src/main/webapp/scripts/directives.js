var threadfixModule = angular.module('threadfix')

// For image tags and stuff
threadfixModule.directive('tfBindHtmlUnsafe', function( $compile ) {
    return function( $scope, $element, $attrs ) {

        var compile = function( newHTML ) { // Create re-useable compile function

            newHTML = $compile(newHTML)($scope); // Compile html
            $element.html('').append(newHTML);
        };

        var htmlName = $attrs.tfBindHtmlUnsafe; // Get the name of the variable
        // Where the HTML is stored

        $scope.$watch(htmlName, function( newHTML ) { // Watch for changes to
            // the HTML
            if(!newHTML) return;
            compile(newHTML);   // Compile it
        });

    };
});

threadfixModule.directive('focusOn', function($timeout, $parse) {
    return {
        link: function(scope, element, attrs) {
            var model = $parse(attrs.focusOn);
            scope.$watch(model, function(value) {
                console.log('value=',value);
                if(value === true) {
                    $timeout(function() {
                        element[0].focus();
                    });
                }
            });
            element.bind('blur', function() {
                console.log('blur')
                scope.$apply(model.assign(scope, false));
            })
        }
    };
});

threadfixModule.directive('ngEnter', function() {
    return function(scope, element, attrs) {
        element.bind("keydown keypress", function(event) {
            if(event.which === 13) {
                scope.$apply(function(){
                    scope.$eval(attrs.ngEnter, {'event': event});
                });

                event.preventDefault();
            }
        });
    };
});

threadfixModule.directive('passwordValidate', function() {
    return {
        require: 'ngModel',
        link: function(scope, elm, attrs, ctrl) {
            ctrl.$parsers.unshift(function(viewValue) {

                scope.pwdValidLength = (viewValue && viewValue.length >= 12 ? 'valid' : undefined);
                scope.lengthRemaining = (viewValue && viewValue.length < 12 ? 12 - viewValue.length : undefined)

                scope.matchError = (viewValue && scope.pwdValidLength && attrs.passwordValidate === viewValue);

                scope.$watch(function() { return attrs.passwordValidate; }, function() {
                    if (scope.pwdValidLength) {
                        ctrl.$setValidity('matches', scope.pwdValidLength && attrs.passwordValidate === viewValue);
                    }
                })

                if(scope.pwdValidLength) {
                    ctrl.$setValidity('passwordLength', true);
                    ctrl.$setValidity('matches', attrs.passwordValidate === viewValue);
                    return viewValue;
                } else {
                    ctrl.$setValidity('matches', true);
                    ctrl.$setValidity('passwordLength', false);
                    return undefined;
                }

            });
        }
    };
});
