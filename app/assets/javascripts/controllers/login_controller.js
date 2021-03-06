
angular.module('demoAngular')
.controller('LoginController', function ($scope, $http, $location, UserService, FlashService, config, $cookieStore){

  // Authentication
  $scope.signin = function() {
		UserService.Login($scope.user.email, $scope.user.password, function (response) {
			if (response.success) {
      	UserService.SetCredentials(response.access_token);        
        FlashService.Success('Login successfully.');
        $location.path('/home'); 
			}else{
        FlashService.Error(response.errors);
			}
		})    
  };

  // Logout
  $scope.logout = function(){
  	UserService.Logout($scope.globals.currentUser.access_token, function(response){
  		if(response.success){
  			$location.path('/login')
  		}else{
  			$location.path('/')
  		}  		
  	})  	
  }

})