Class Carworkshop.Workshops Extends %Persistent
{

Property name As %String;

Property address As %String;

// Селектим запрос из базы для получения списка машинок

ClassMethod List(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, name, address
	    INTO :id, :name, :address
	    FROM Carworkshop.Workshops
 	)
 	//вариант в массив INTO :singleUserData()
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "name": (name), "address": (address)}
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
<Value>name</Value>
</Value>
<Value name="3">
<Value>address</Value>
</Value>
</Data>
<DataLocation>^Carworkshop.WorkshopsD</DataLocation>
<DefaultData>WorkshopsDefaultData</DefaultData>
<IdLocation>^Carworkshop.WorkshopsD</IdLocation>
<IndexLocation>^Carworkshop.WorkshopsI</IndexLocation>
<StreamLocation>^Carworkshop.WorkshopsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
