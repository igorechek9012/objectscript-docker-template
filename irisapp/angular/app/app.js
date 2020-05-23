(function() {
  'use strict';
  angular
  .module('app', [])
  /**
   * AppController
   * Description: Sets up a controller
   */
  .controller('AppController', ['$scope', '$http', function($scope, $http) {

	  const urlPrefix = '/carworkshop';


	  const headers = {
	  	cars: [
	  		'ID',
			'Марка',
			'Модель',
			'Владелец',
			'Регистрационный номер'
		],
		owners: [
			'ID',
			'ФИО',
			'Адрес',
			'Паспорт'
		],
		employee: [
			'ID',
			'ФИО',
			'Стаж (лет)',
			'Филиал'
		],
		workshops: [
			'ID',
			'Наименование',
			'Адрес'
		],
		workrequests: [
			'ID',
			'Машина',
			'Работник',
			'Стоимость (руб)',
			'Срок (дней)',
			'Описание'
		]
	  };

	  $scope.data = {
		  cars: [
		  ],
		  owners: [
		  ],
		  employee: [
		  ],
		  workshops: [
		  ],
		  workrequests: [
		  ]
	  }

	  function saveData(dataObject) {
		let fd = new FormData();
		for (const [key, value] of Object.entries(dataObject)) {
			fd.append(key, value);
		}
		let url = urlPrefix + '/' + $scope.currentTable + '/create';
		$http.post(url, fd, {
			transformRequest: angular.identity,
			headers: {
				'Content-Type': undefined
			}
		  }).then(function success(response) {
			  // console.log(response);
			  refreshData();
			  $scope.clearActionArea();
		  }, function error(response) {
			  // console.log(response);
				$scope.onError = true;
				$scope.errorMessage = 'Упс! Что-то пошло не так:(';
		  });
	}

	function deleteData(id) {
		let fd = new FormData();
		fd.append('id', id)
		let url = urlPrefix + '/' + $scope.currentTable + '/delete';
		$http.post(url, fd, {
			transformRequest: angular.identity,
			headers: {
				'Content-Type': undefined
			}
		  }).then(function success(response) {
			  // console.log(response);
			  refreshData();
			  $scope.clearActionArea();
		  }, function error(response) {
			  // console.log(response);
			  $scope.onError = true;
				$scope.errorMessage = 'Упс! Что-то пошло не так:(';
		  });
	}

	$scope.getOwners = function()
	{
		$http({
			method: 'GET',
			url: '/carworkshop/owners'
		}).then(function success(response) {
		  // console.log(response);
		  $scope.data.owners = response.data;
		  prepareData($scope.currentTable);
		}, function error(response) {
			// console.log(response);
		});
	}

	$scope.getCars = function()
	{
		$http({
			method: 'GET',
			url: '/carworkshop/cars'
		}).then(function success(response) {
		  // console.log(response);
		  $scope.data.cars = response.data;
		  prepareData($scope.currentTable);
		}, function error(response) {
			// console.log(response);
		});
	}

	$scope.getEmployee = function()
	{
		$http({
			method: 'GET',
			url: '/carworkshop/employee'
		}).then(function success(response) {
		  // console.log(response);
		  $scope.data.employee = response.data;
		  prepareData($scope.currentTable);
		}, function error(response) {
			// console.log(response);
		});
	}

	$scope.getWorkshops = function()
	{
		$http({
			method: 'GET',
			url: '/carworkshop/workshops'
		}).then(function success(response) {
		  // console.log(response);
		  $scope.data.workshops = response.data;
		  prepareData($scope.currentTable);
		}, function error(response) {
			// console.log(response);
		});
	}

	$scope.getWorkrequests = function()
	{
		$http({
			method: 'GET',
			url: '/carworkshop/workrequests'
		}).then(function success(response) {
		  // console.log(response);
		  $scope.data.workrequests = response.data;
		  prepareData($scope.currentTable);
		}, function error(response) {
			// console.log(response);
		});
	}

	function refreshData() {
		$scope.getCars();
		$scope.getEmployee();
		$scope.getOwners();
		$scope.getWorkrequests();
		$scope.getWorkshops();
	}

	  refreshData();
	  $scope.currentTableHeader = headers.cars;
	  $scope.currentTableData = [];
	  $scope.currentTable = 'cars';
	  $scope.currentInfoObject = null;
	  $scope.actionMode = 'show';
	  $scope.OnAction = false;
	  $scope.onError = false;
	  $scope.errorMessage = '';
	  prepareData($scope.currentTable);
	  $scope.tableSideBorder = false;
	  $scope.currentTableLabel = "Машины";

	  $scope.switchTable = function(label) {
		  $scope.clearActionArea();
		  switch (label) {
			  case 'cars':
				  $scope.currentTableLabel = "Машины";
				  $scope.currentTable = 'cars';
				  $scope.currentTableHeader = headers.cars;
				  break;
			  case 'owners':
				  $scope.currentTableLabel = "Владельцы";
				  $scope.currentTable = 'owners';
				  $scope.currentTableHeader = headers.owners;
				  break;
			  case 'workshops':
				  $scope.currentTableLabel = "Филиалы";
				  $scope.currentTable = 'workshops';
				  $scope.currentTableHeader = headers.workshops;
				  break;
			  case 'employee':
				  $scope.currentTableLabel = "Работники";
				  $scope.currentTable = 'employee';
				  $scope.currentTableHeader = headers.employee;
				  break;
			  case 'workrequests':
				  $scope.currentTableLabel = "Заявки";
				  $scope.currentTable = 'workrequests';
				  $scope.currentTableHeader = headers.workrequests;
				  break;
			  default:
				  $scope.currentTableLabel = "Машины";
				  $scope.currentTable = 'cars';
				  $scope.currentTableHeader = headers.cars;
				  console.log('shut up and take my table')
		  }
		  prepareData(label);
	  };

	  function prepareData(label) {
		  $scope.currentTableData = [];
		  switch (label) {
			  case 'cars':
				  $scope.data.cars.forEach(function(car) {
					  let tempOwner = {};
					  $scope.data.owners.forEach(function(owner) {
						  if (owner.id === car.owner) {
						  	tempOwner = owner;
						  }
					  });
					  let tempObject = {
						  id: car.id,
						  brand: car.brand,
						  model: car.model,
						  owner: tempOwner.fio ? tempOwner.fio : car.owner,
						  regNumber: car.regNumber
					  };
					  $scope.currentTableData.push(tempObject);
				  });
				  break;
			  case 'owners':
				  $scope.data.owners.forEach(function(owner) {
					  let tempObject = {
						  id: owner.id,
						  fio: owner.fio,
						  address: owner.address,
						  passport: owner.passport
					  };
					  $scope.currentTableData.push(tempObject);
				  });
				  break;
			  case 'workshops':
				  $scope.data.workshops.forEach(function(shop) {
					  let tempObject = {
						  id: shop.id,
						  name: shop.name,
						  address: shop.address
					  };
					  $scope.currentTableData.push(tempObject);
				  });
				  break;
			  case 'employee':
				  $scope.data.employee.forEach(function(employee) {
				  	  let tempShop = {};
					  $scope.data.workshops.forEach(function(shop) {
						  if (shop.id === employee.workshop) {
							  tempShop = shop;
						  }
					  });
					  let tempObject = {
						  id: employee.id,
						  fio: employee.fio,
						  worktime: employee.worktime,
						  workshop: tempShop.name ? tempShop.name : employee.workshop
					  };
					  $scope.currentTableData.push(tempObject);
				  });
				  break;
			  case 'workrequests':
				  $scope.data.workrequests.forEach(function(workReq) {
				  	  let tempCar = {};
				  	  let tempEmployee = {};
					  $scope.data.cars.forEach(function(car) {
						  if (car.id === workReq.car) {
							  tempCar = car;
						  }
					  });
					  $scope.data.employee.forEach(function(employee) {
						  if (employee.id === workReq.employee) {
							  tempEmployee = employee;
						  }
					  });
					  let tempObject = {
						  id: workReq.id,
						  car: tempCar.brand ? tempCar.brand + ' ' + tempCar.model : workReq.car,
						  employee: tempEmployee.fio ? tempEmployee.fio : workReq.employee,
						  cost: workReq.cost,
						  deadline: workReq.deadline,
						  description: workReq.description
					  };
					  $scope.currentTableData.push(tempObject);
				  });
				  break;
			  default:
				  console.log('shut up and take my data')
		  }
	  }

	  $scope.showDataOnClick = function(infoObj) {
	  	$scope.actionMode = 'show';
	  	$scope.OnAction = true;
	  	$scope.tableSideBorder = true;
		$scope.currentInfoObject = infoObj;
	  }

	  $scope.isValid = function(value) {
	  	return (typeof(value) !== 'undefined');
	  }

	  $scope.addTableRow = function() {
		  $scope.actionMode = 'add';
		  $scope.OnAction = true;
		  $scope.tableSideBorder = true;
		  switch ($scope.currentTable) {
			  case 'cars':
				  $scope.currentInfoObject = {
					  brand: '',
					  model: '',
					  owner: null,
					  regNumber: ''
				  }
				  break;
			  case 'owners':
				  $scope.currentInfoObject = {
					  fio: '',
					  address: '',
					  passport: ''
				  }
				  break;
			  case 'workshops':
				  $scope.currentInfoObject = {
					  name: '',
					  address: ''
				  }
				  break;
			  case 'employee':
				  $scope.currentInfoObject = {
					  fio: '',
					  worktime: '',
					  workshop: null
				  }
				  break;
			  case 'workrequests':
				  $scope.currentInfoObject = {
					  car: null,
					  employee: null,
					  cost: '',
					  deadline: '',
					  description: ''
				  }
				  break;
			  default:

				  console.log('shut up and take my table')
		  }
	  }

	  $scope.clearActionArea = function() {
		  $scope.onError = false;
		  $scope.OnAction = false;
		  $scope.tableSideBorder = false;
		  $scope.currentInfoObject = null;
	  }

	  $scope.deleteAction = function() {
		  deleteData($scope.currentInfoObject.id);
	  }

	  $scope.createAction = function() {
	  	let tempObject = {};
		  switch ($scope.currentTable) {
			  case 'cars':
				  tempObject = {
					  brand: $scope.currentInfoObject.brand,
					  model: $scope.currentInfoObject.model,
					  owner: $scope.currentInfoObject.owner ? $scope.currentInfoObject.owner.id : $scope.currentInfoObject.owner,
					  regNumber: $scope.currentInfoObject.regNumber
				  }
				  break;
			  case 'owners':
				  tempObject = {
					  fio: $scope.currentInfoObject.fio,
					  address: $scope.currentInfoObject.address,
					  passport: $scope.currentInfoObject.passport
				  }
				  break;
			  case 'workshops':
				  tempObject = {
					  name: $scope.currentInfoObject.name,
					  address: $scope.currentInfoObject.address
				  }
				  break;
			  case 'employee':
				  tempObject = {
					  fio: $scope.currentInfoObject.fio,
					  worktime: $scope.currentInfoObject.worktime,
					  workshop: $scope.currentInfoObject.workshop ? $scope.currentInfoObject.workshop.id : $scope.currentInfoObject.workshop
				  }
				  break;
			  case 'workrequests':
				  tempObject = {
					  car: $scope.currentInfoObject.car ? $scope.currentInfoObject.car.id : $scope.currentInfoObject.car,
					  employee: $scope.currentInfoObject.employee ? $scope.currentInfoObject.employee.id : $scope.currentInfoObject.employee,
					  cost: $scope.currentInfoObject.cost,
					  deadline: $scope.currentInfoObject.deadline,
					  description: $scope.currentInfoObject.description
				  }
				  break;
			  default:
				  console.log('shut up and take my request')
		  }
		  $scope.onError = false;
		  for (const [key, value] of Object.entries(tempObject)) {
			if ((value === null) || (typeof(value) === 'undefined') || (value === '')) {
				$scope.onError = true;
				$scope.errorMessage = 'Не все поля заполнены';
			}
		  }
		  if (!$scope.onError) {
			saveData(tempObject);
		  }
	  }

	  $scope.testClick = function() {
		console.log('shut up and take my header-click')
	  }

	  
  }]);
})();