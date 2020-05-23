Class Carworkshop.Web.Index Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
    &HTML<
    <div ng-app="app">
    <script src="/csp/irisapp/angular/lib/angular.min.js"></script>
    <link rel="stylesheet" href="/csp/irisapp/angular/app/styles.css" />
    <script src="/csp/irisapp/angular/app/app.js"></script>
    <main ng-controller="AppController" class="main-page">
        <div class="header">
            <div class="header-title" ng-click="testClick()">
                Автосервис "ТАЧКУ НА ПРОКАЧКУ"
            </div>
        </div>
        <div class="main-wrap">
            <div class="side-menu">
                <div class="menu-button" ng-click="switchTable('cars')">
                    Машины
                </div>
                <div class="menu-button" ng-click="switchTable('owners')">
                    Владельцы
                </div>
                <div class="menu-button" ng-click="switchTable('workrequests')">
                    Заявки
                </div>
                <div class="menu-button" ng-click="switchTable('workshops')">
                    Филиалы
                </div>
                <div class="menu-button" ng-click="switchTable('employee')">
                    Работники
                </div>
            </div>
            <div class="table-side">
                <div class="table-area" ng-class="{'border-on': tableSideBorder}">
                    <table>
                        <caption class="table-name">
                            <div class="table-name-label">
                            {{currentTableLabel}}
                            </div>
                            <div ng-click="addTableRow()" class="table-add-button">
                                +
                            </div></caption>
                        <tr>
                            <th ng-repeat="label in currentTableHeader">{{label}}</th>
                        </tr>
                        <tr ng-repeat="row in currentTableData" ng-click="showDataOnClick(row)" class="selected-row">
                            <td ng-repeat="(key, value) in row">{{value}}</td>
                        </tr>
                    </table>
                </div>
                <div class="action-area" ng-if="OnAction">
                    <div class="error-window" ng-if="onError">
                    {{errorMessage}}
                    </div>
                    <div class="action-label-area">
                        {{actionMode === 'show' ? 'Просмотр' : 'Создать запись'}}
                    </div>
                    <div class="fields-area">
                        <div class="action-field" ng-if="isValid(currentInfoObject.car)">
                            <div class = "field-name">
                                Машина
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.car}}
                            </div>
                            <select ng-model="currentInfoObject.car" ng-if="actionMode === 'add'">
                                <option ng-repeat="car in data.cars" ng-value="car">{{car.id + '. ' + car.brand + ' ' + car.model}}</option>
                            </select>
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.workshop)">

                            <div class = "field-name">
                                Филиал
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.workshop}}
                            </div>
                            <select ng-model="currentInfoObject.workshop" ng-if="actionMode === 'add'">
                                <option ng-repeat="workshop in data.workshops" ng-value="workshop">{{workshop.id + '. ' + workshop.name}}</option>
                            </select>
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.employee)">

                            <div class = "field-name">
                                Работник
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.employee}}
                            </div>
                            <select ng-model="currentInfoObject.employee" ng-if="actionMode === 'add'">
                                <option ng-repeat="employee in data.employee" ng-value="employee">{{employee.id + '. ' + employee.fio}}</option>
                            </select>
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.owner)">

                            <div class = "field-name">
                                Владелец
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.owner}}
                            </div>
                            <select ng-model="currentInfoObject.owner" ng-if="actionMode === 'add'">
                                <option ng-repeat="owner in data.owners" ng-value="owner">{{owner.id + '. ' + owner.fio}}</option>
                            </select>
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.brand)">

                            <div class = "field-name">
                                Марка
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.brand}}
                            </div>
                            <input type="text" ng-model="currentInfoObject.brand" ng-if="actionMode === 'add'">
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.model)">

                            <div class = "field-name">
                                Модель
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.model}}
                            </div>
                            <input type="text" ng-model="currentInfoObject.model" ng-if="actionMode === 'add'">
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.regNumber)">

                            <div class = "field-name">
                                Регистрационный номер
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.regNumber}}
                            </div>
                            <input type="text" ng-model="currentInfoObject.regNumber" ng-if="actionMode === 'add'">
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.fio)">

                            <div class = "field-name">
                                ФИО
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.fio}}
                            </div>
                            <input type="text" ng-model="currentInfoObject.fio" ng-if="actionMode === 'add'">
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.address)">

                            <div class = "field-name">
                                Адрес
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.address}}
                            </div>
                            <input type="text" ng-model="currentInfoObject.address" ng-if="actionMode === 'add'">
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.passport)">

                            <div class = "field-name">
                                Паспорт
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.passport}}
                            </div>
                            <input type="text" ng-model="currentInfoObject.passport" ng-if="actionMode === 'add'">
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.worktime)">

                            <div class = "field-name">
                                Стаж (лет)
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.worktime}}
                            </div>
                            <input type="text" ng-model="currentInfoObject.worktime" ng-if="actionMode === 'add'">
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.name)">

                            <div class = "field-name">
                                Наименование филиала
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.name}}
                            </div>
                            <input type="text" ng-model="currentInfoObject.name" ng-if="actionMode === 'add'">
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.cost)">

                            <div class = "field-name">
                                Стоимость (руб)
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.cost}}
                            </div>
                            <input type="text" ng-model="currentInfoObject.cost" ng-if="actionMode === 'add'">
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.deadline)">

                            <div class = "field-name">
                                Срок (кол-во дней)
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.deadline}}
                            </div>
                            <input type="text" ng-model="currentInfoObject.deadline" ng-if="actionMode === 'add'">
                        </div>
                        <div class="action-field" ng-if="isValid(currentInfoObject.description)">

                            <div class = "field-name">
                                Описание
                            </div>
                            <div ng-if="actionMode === 'show'" class="field-value">
                                {{currentInfoObject.description}}
                            </div>
                            <input type="text" ng-model="currentInfoObject.description" ng-if="actionMode === 'add'">
                        </div>
                    </div>
                    <div class="action-btn-area">
                        <div class="btn delete" ng-click="deleteAction()" ng-if="actionMode === 'show'">
                            Удалить
                        </div>
                        <div class="btn create" ng-click="createAction()" ng-if="actionMode === 'add'">
                            Создать
                        </div>
                        <div class="btn cancel" ng-click="clearActionArea()">
                            Отмена
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
    >
    return $$$OK
}

}
