Class Carworkshop.Workrequests Extends %Persistent
{

Property car As Carworkshop.Cars;

Property employee As Carworkshop.Employee;

Property cost As %String;

Property deadline As %String;

Property description As %String;

// Селектим запрос из базы для получения списка машинок

ClassMethod List(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, car->id, employee->id, cost, deadline, description
	    INTO :id, :carId, :employeeId, :cost, :deadline, description
	    FROM Carworkshop.Workrequests
 	)
 	//вариант в массив INTO :singleUserData()
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "car": (carId), "employee": (employeeId), "cost": (cost), "deadline": (deadline), "description": (description)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

Storage Default
{
<Data name="AutoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>car</Value>
</Value>
<Value name="3">
<Value>employee</Value>
</Value>
<Value name="4">
<Value>cost</Value>
</Value>
<Value name="5">
<Value>deadline</Value>
</Value>
<Value name="6">
<Value>description</Value>
</Value>
</Data>
<DataLocation>^Carworkshop.WorkrequestsD</DataLocation>
<DefaultData>WorkrequestsDefaultData</DefaultData>
<IdLocation>^Carworkshop.WorkrequestsD</IdLocation>
<IndexLocation>^Carworkshop.WorkrequestsI</IndexLocation>
<StreamLocation>^Carworkshop.WorkrequestsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
