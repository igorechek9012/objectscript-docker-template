Class Carworkshop.Employee Extends %Persistent
{

Property fio As %String;

Property worktime As %String;

Property workshop As Carworkshop.Workshops;

// Селектим запрос из базы для получения списка машинок

ClassMethod List(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, fio, worktime, workshop->id
	    INTO :id, :fio, :worktime, :workshopId
	    FROM Carworkshop.Employee
 	)
 	//вариант в массив INTO :singleUserData()
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "fio": (fio), "worktime": (worktime), "workshop": (workshopId)}
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
<Value>fio</Value>
</Value>
<Value name="3">
<Value>worktime</Value>
</Value>
<Value name="4">
<Value>workshop</Value>
</Value>
</Data>
<DataLocation>^Carworkshop.EmployeeD</DataLocation>
<DefaultData>EmployeeDefaultData</DefaultData>
<IdLocation>^Carworkshop.EmployeeD</IdLocation>
<IndexLocation>^Carworkshop.EmployeeI</IndexLocation>
<StreamLocation>^Carworkshop.EmployeeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
