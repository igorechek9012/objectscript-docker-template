Class Carworkshop.Rest Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

/// Docs here https://cedocs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GREST_services#GREST_urlmap
XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/test" Method="GET" Call="Test"/>

  <Route Url="/cars/create" Method="POST" Call="SaveCar"/>
  <Route Url="/cars/delete" Method="POST" Call="DeleteCar"/>
  <Route Url="/cars" Method="Get" Call="Carlist"/>

  <Route Url="/owners/create" Method="POST" Call="SaveOwner"/>
  <Route Url="/owners/delete" Method="POST" Call="DeleteOwner"/>
  <Route Url="/owners" Method="Get" Call="Ownerlist"/>

  <Route Url="/employee/create" Method="POST" Call="SaveEmployee"/>
  <Route Url="/employee/delete" Method="POST" Call="DeleteEmployee"/>
  <Route Url="/employee" Method="Get" Call="Employeelist"/>

  <Route Url="/workshops/create" Method="POST" Call="SaveWorkshop"/>
  <Route Url="/workshops/delete" Method="POST" Call="DeleteWorkshop"/>
  <Route Url="/workshops" Method="Get" Call="Workshoplist"/>

  <Route Url="/workrequests/create" Method="POST" Call="SaveWorkrequest"/>
  <Route Url="/workrequests/delete" Method="POST" Call="DeleteWorkrequest"/>
  <Route Url="/workrequests" Method="Get" Call="Workrequestlist"/>
</Routes>
}

ClassMethod Test() As %Status
{
    write "hello this is test"
    return $$$OK
}

ClassMethod SaveCar() As %Status
{
  set brand = %request.Get("brand") 
  set model = %request.Get("model")
  set owner = %request.Get("owner")
  set regNumber = %request.Get("regNumber")
  set result = {}

  set obj = ##class(Carworkshop.Cars).%New()
  set obj.brand = brand
  set obj.model = model
  do obj.ownerSetObjectId(owner)
  set obj.regnumber = regNumber
  set saveResult = obj.%Save() 

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  write result.%ToJSON()
  Quit $$$OK
}

ClassMethod SaveOwner() As %Status
{
  set fio = %request.Get("fio") 
  set address = %request.Get("address")
  set passport = %request.Get("passport")
  set result = {}
  
  set obj = ##class(Carworkshop.Owners).%New()
  set obj.fio = fio
  set obj.address = address
  set obj.passport = passport
  set saveResult = obj.%Save() 

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  write result.%ToJSON()
  Quit $$$OK
}

ClassMethod SaveWorkshop() As %Status
{
  set name = %request.Get("name") 
  set address = %request.Get("address")
  set result = {}
  
  set obj = ##class(Carworkshop.Workshops).%New()
  set obj.name = name
  set obj.address = address
  set saveResult = obj.%Save()

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  write result.%ToJSON()
  Quit $$$OK
}

ClassMethod SaveEmployee() As %Status
{
  set fio = %request.Get("fio") 
  set worktime = %request.Get("worktime")
  set workshop = %request.Get("workshop")
  set result = {}
  
  set obj = ##class(Carworkshop.Employee).%New()
  set obj.fio = fio
  set obj.worktime = worktime
  do obj.workshopSetObjectId(workshop)
  set saveResult = obj.%Save()

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  write result.%ToJSON()
  Quit $$$OK
}

ClassMethod SaveWorkrequest() As %Status
{
  set car = %request.Get("car") 
  set employee = %request.Get("employee")
  set cost = %request.Get("cost")
  set deadline = %request.Get("deadline")
  set description = %request.Get("description")
  
  set result = {}
  
  set obj = ##class(Carworkshop.Workrequests).%New()
  do obj.carSetObjectId(car)
  do obj.employeeSetObjectId(employee)
  set obj.cost = cost
  set obj.deadline = deadline
  set obj.description = description
  set saveResult = obj.%Save()

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  write result.%ToJSON()
  Quit $$$OK
}

ClassMethod DeleteOwner() As %Status
{
  set id = %request.Get("id")

  set deleteResult = ##class(Carworkshop.Owners).%DeleteId(id)
  set result = {}

  if $$$ISOK(deleteResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(deleteResult)
  set result.message = ErrorMessage

  write result.%ToJSON()
  Quit $$$OK
}

ClassMethod DeleteCar() As %Status
{
  set id = %request.Get("id")

  set deleteResult = ##class(Carworkshop.Cars).%DeleteId(id)
  set result = {}

  if $$$ISOK(deleteResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(deleteResult)
  set result.message = ErrorMessage

  write result.%ToJSON()
  Quit $$$OK
}

ClassMethod DeleteEmployee() As %Status
{
  set id = %request.Get("id")

  set deleteResult = ##class(Carworkshop.Employee).%DeleteId(id)
  set result = {}

  if $$$ISOK(deleteResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(deleteResult)
  set result.message = ErrorMessage

  write result.%ToJSON()
  Quit $$$OK
}

ClassMethod DeleteWorkshop() As %Status
{
  set id = %request.Get("id")

  set deleteResult = ##class(Carworkshop.Workshops).%DeleteId(id)
  set result = {}

  if $$$ISOK(deleteResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(deleteResult)
  set result.message = ErrorMessage

  write result.%ToJSON()
  Quit $$$OK
}

ClassMethod DeleteWorkrequest() As %Status
{
  set id = %request.Get("id")

  set deleteResult = ##class(Carworkshop.Workrequests).%DeleteId(id)
  set result = {}

  if $$$ISOK(deleteResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(deleteResult)
  set result.message = ErrorMessage

  write result.%ToJSON()
  Quit $$$OK
}

ClassMethod Ownerlist() As %Status
{
  do ##class(Carworkshop.Owners).List(.ownersArray)
  write ownersArray.%ToJSON()
  Return $$$OK
}

// Метод получения списка с нашими автошками

ClassMethod Carlist() As %Status
{
  do ##class(Carworkshop.Cars).List(.carsArray)
  write carsArray.%ToJSON()
  Return $$$OK
}

ClassMethod Employeelist() As %Status
{
  do ##class(Carworkshop.Employee).List(.employeeArray)
  write employeeArray.%ToJSON()
  Return $$$OK
}

ClassMethod Workshoplist() As %Status
{
  do ##class(Carworkshop.Workshops).List(.workshopArray)
  write workshopArray.%ToJSON()
  Return $$$OK
}

ClassMethod Workrequestlist() As %Status
{
  do ##class(Carworkshop.Workrequests).List(.workrequestsArray)
  write workrequestsArray.%ToJSON()
  Return $$$OK
}

}
