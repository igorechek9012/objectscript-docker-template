Class Carworkshop.Cars Extends %Persistent
{

Property brand As %String;

Property model As %String;

Property owner As Carworkshop.Owners;

Property regnumber As %String;

// Селектим запрос из базы для получения списка машинок

ClassMethod List(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, brand, model, owner->id, regnumber
	    INTO :id, :brand, :model, :ownerId, :regnumber
	    FROM Carworkshop.Cars
 	)
 	//вариант в массив INTO :singleUserData()
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "brand": (brand), "model": (model), "owner": (ownerId), "regNumber": (regnumber)}
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
<Value>brand</Value>
</Value>
<Value name="3">
<Value>model</Value>
</Value>
<Value name="4">
<Value>regNumber</Value>
</Value>
<Value name="5">
<Value>owner</Value>
</Value>
</Data>
<Data name="CarsDefaultData">
<Subscript>"1"</Subscript>
<Value name="1">
<Value>regnumber</Value>
</Value>
</Data>
<DataLocation>^Carworkshop.CarsD</DataLocation>
<DefaultData>CarsDefaultData</DefaultData>
<IdLocation>^Carworkshop.CarsD</IdLocation>
<IndexLocation>^Carworkshop.CarsI</IndexLocation>
<StreamLocation>^Carworkshop.CarsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
