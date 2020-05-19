Class Bots.Rest Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

/// Docs here https://cedocs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GREST_services#GREST_urlmap
XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/test" Method="GET" Call="Test"/>
  <Route Url="/save" Method="POST" Call="Save"/>
  <Route Url="/users/list" Method="GET" Call="Userslist"/>
  <Route Url="/list" Method="GET" Call="Botslist"/>
</Routes>
}

ClassMethod Test() As %Status
{
    write "hello this is test"
    return $$$OK
}

ClassMethod Save() As %Status
{
  set name = %request.Get("fname")
  set owner = %request.Get("fowner")
  set result = {}

  set obj = ##class(Bots.Bots).%New()
  set obj.Name = name
  do obj.OwnerSetObjectId(owner)
  set saveResult = obj.%Save()

  if $$$ISOK(saveResult) set result = {"result": true}
  else  set result = {"result": false}
  set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
  set result.message = ErrorMessage

  write result.%ToJSON()
  Quit $$$OK
}

ClassMethod Userslist() As %Status
{
  do ##class(Bots.Users).List(.usersArray)
  write usersArray.%ToJSON()
  Return $$$OK
}

ClassMethod Botslist() As %Status
{
  do ##class(Bots.Bots).List(.botsArray)
  write botsArray.%ToJSON()
  Return $$$OK
}

}
