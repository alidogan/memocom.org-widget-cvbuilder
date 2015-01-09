// Combine angular modules
angular.module("CombineModule", ["drag-and-drop", "myModule"]);

//Drag and drop module
var App = angular.module('drag-and-drop', ['ngDragDrop'] );

App.controller('OverviewCtrl', function($scope, $timeout, $http) {

// Ophalen json
$http.get('personalia.json').success (function(data){
  $scope.list5 = data;
}); 

$http.get('opleidingen.json').success (function(data){
  $scope.opleidingen = data;
}); 

$http.get('werkervaring.json').success (function(data){
  $scope.werkervaring = data;
});

$http.get('talen.json').success (function(data){
  $scope.talen = data;
});
      
$scope.list1 = [];
$scope.list2 = {};
$scope.list3 = [];
$scope.list4 = [];

});

// Form module
var app = angular.module('myModule', ['schemaForm']);
  App.controller('FormController', function($scope,$http) {
  $scope.schema = {
  "type": "object",
  "title": "Types",
  "properties": {
    "title": {
      "type": "string",
      "default": "Personalia",
      "title": "Titel:"
    },
    "name": {
      "type": "string",
      "title": "Naam:"
    },
    "address": {
      "type": "string",
      "title": "Straat en huisnummer:"
    },
    "zipcode": {
      "type": "string",
      "title": "Postcode:"
    },
    "city": {
      "type": "string",
      "title": "Plaats:"
    },
    "phone_number": {
      "type": "string",
      "title": "Telefoonnummer:"
    },
    "email": {
      "type": "string",
      "title": "E-mail:"
    },
    "date_of_birth": {
      "type": "string",
      "title": "Geboortedatum:"
    },
    "place_of_birth": {
      "type": "string",
      "title": "Geboorteplaats:"
    },
    "nationality": {
      "type": "string",
      "title": "Nationaliteit:"
    },
    "driving_license": {
      "title": "Rijbewijs:",
      "type": "string",
      "enum": [
        "Ja",
        "Nee"
      ]
    }
  }
};

$scope.talen = {
  "type": "object",
  "title": "Comment",
  "required": [
    "Talen"
  ],
  "properties": {
    "Talen": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "title": {
            "title": "Taal:",
            "type": "string"
          },
          "description": {
            "title": "Beschrijving:",
            "type": "string"
          }
          
        },
      
      }
    }
  }
};

$scope.opleidingen = {
  "type": "object",
  "title": "Comment",
  "required": [
    "Opleidingen"
  ],
  "properties": {
    "Opleidingen": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "title": {
            "title": "Titel:",
            "type": "string"
          },
          "year_of_study": {
            "title": "Studiejaren:",
            "type": "string"
          },
          "city": {
            "title": "Plaats:",
            "type": "string"
          },
          "description": {
            "title": "Beschrijving:",
            "type": "string"
          }
          
        },
      
      }
    }
  }
};

$scope.werkervaring = {
  "type": "object",
  "title": "Comment",
  "required": [
    "Werkervaring"
  ],
  "properties": {
    "Werkervaring": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "title": {
            "title": "Titel:",
            "type": "string"
          },
          "work_year": {
            "title": "Werkjaren:",
            "type": "string"
          },
          "branch": {
            "title": "Branche:",
            "type": "string"
          },
          "job": {
            "title": "Functie:",
            "type": "string"
          },
          "activities": {
            "title": "Werkzaamheden:",
            "type": "string"
          },
          "time": {
            "title": "Voltijd/deeltijd:",
            "type": "string"
          },
          "address": {
            "title": "Straat en huisnummer:",
            "type": "string"
          },
          "zipcode": {
            "title": "Postcode:",
            "type": "string"
          },
          "city": {
            "title": "Plaats:",
            "type": "string"
          },
          "phone_number": {
            "title": "Telefoonnummer:",
            "type": "string"
          },
          "references": {
            "title": "Referentie:",
            "type": "string"
          }     
        },
      
      }
    }
  }
};

  $scope.form = [
    "*",
    {
      "type": "submit",
      "style": "btn-info",
      "title": "Opslaan"
    }
  ];

  $scope.form_talen = [

  {
    "key": "Talen",
    "add": "Nieuw",
    "style": {
      "add": "btn-success"
    },
    "items": [
      "Talen[].title",
      "Talen[].description"
   
    ]
  },
  {
    "type": "submit",
    "style": "btn-info",
    "title": "Opslaan"
  }
];

$scope.form_opleidingen = [

  {
    "key": "Opleidingen",
    "add": "Nieuw",
    "style": {
      "add": "btn-success"
    },
    "items": [
      "Opleidingen[].title",
      "Opleidingen[].description",
      "Opleidingen[].year_of_study",
      "Opleidingen[].city"   
    ]
  },
  {
    "type": "submit",
    "style": "btn-info",
    "title": "Opslaan"
  }
];

$scope.form_werkervaring = [

  {
    "key": "Werkervaring",
    "add": "Nieuw",
    "style": {
      "add": "btn-success"
    },
    "items": [
      "Werkervaring[].title",
      "Werkervaring[].work_year",
      "Werkervaring[].branch",
      "Werkervaring[].job",   
      "Werkervaring[].activities",   
      "Werkervaring[].time",   
      "Werkervaring[].address",   
      "Werkervaring[].zipcode",
      "Werkervaring[].city",    
      "Werkervaring[].phone_number",
      "Werkervaring[].references"     
    ]
  },
  {
    "type": "submit",
    "style": "btn-info",
    "title": "Opslaan"
  }
];

$scope.load_opleidingen = function() { 
$http.get('opleidingen_read.json').success (function(data3){
    if (data3 == "") {
      console.log('data3 = null');
        $scope.model_opleidingen = {"Opleidingen":[{}]};
    }
    else {
      console.log('opleidingen found');
        $scope.model_opleidingen = data3;
      }
    }).error(function(data3) {
      console.log('data not found');
      $scope.model_opleidingen = {"Opleidingen":[{}]};
    });
}    

$scope.load_personalia = function() { 
    $http.get('personalia_read.json').success (function(data){
    if (data == "") {
      console.log('data = null');
        $scope.model = {};
    }
    else {
      console.log('data found');
        $scope.model = data;
      }
  }).error(function(data) {
    console.log('data not found');
    $scope.model = {};
  });
}

$scope.load_werkervaring = function() { 
 $http.get('werkervaring_read.json').success (function(data4){
    if (data4 == "") {
      console.log('data4 = null');
        $scope.model_werkervaring = {"Werkervaring":[{}]};
    }
    else {
      console.log('werkervaring found');
        $scope.model_werkervaring = data4;
      }
    }).error(function(data4) {
      console.log('data not found');
      $scope.model_werkervaring = {"Werkervaring":[{}]};
  });
}
               
  $scope.load_talen = function() {       

    $http.get('talen_read.json').success (function(data2){
      if (data2 == "") {
          console.log('data2 = null');
          $scope.model_talen = {"Talen":[{}]};
      } else {
        console.log('talen found');
         $scope.model_talen = data2;
        
      }

    }).error(function(data2) {
      console.log('data not found');
      $scope.model_talen = {"Talen":[{}]};
    });


  }

  $scope.onSubmit = function(form) {
    // First we broadcast an event so all fields validate themselves
    $scope.$broadcast('schemaFormValidate');

    // Then we check if the form is valid
    if (form.$valid) {
      // Save data to json
       console.log ( 'save button clicked' );
       location.reload();
       $http.post('personalia.json',$scope.model).success(function(data) {
        });
    }
  }

  $scope.onSubmit_talen = function(form) {
    // First we broadcast an event so all fields validate themselves
    $scope.$broadcast('schemaFormValidate');

    // Then we check if the form is valid
    if (form.$valid) {
      // Save data to json
       console.log ( 'save button clicked' );
       location.reload();
       $http.post('talen.json',$scope.model_talen).success(function(data) {
        });
    }
  }

  $scope.onSubmit_opleidingen = function(form) {
    // First we broadcast an event so all fields validate themselves
    $scope.$broadcast('schemaFormValidate');

    // Then we check if the form is valid
    if (form.$valid) {
      // Save data to json
       console.log ( 'save button clicked' );
       location.reload();
       $http.post('opleidingen.json',$scope.model_opleidingen).success(function(data) {
        });
    }
  }

  $scope.onSubmit_werkervaring = function(form) {
    // First we broadcast an event so all fields validate themselves
    $scope.$broadcast('schemaFormValidate');

    // Then we check if the form is valid
    if (form.$valid) {
      // Save data to json
       console.log ( 'save button clicked' );
       location.reload();
       $http.post('werkervaring.json',$scope.model_werkervaring).success(function(data) {
        });
    }
  }
});