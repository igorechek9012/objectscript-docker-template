Class Carworkshop.Owners Extends %Persistent
{

Property fio As %String;

Property address As %String;

Property passport As %String;

ClassMethod List(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, fio, address, passport
	    INTO :id, :fio, :address, :passport
	    FROM Carworkshop.Owners
 	)
 	//вариант в массив INTO :singleUserData()
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "fio": (fio), "address": (address), "passport": (passport)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

Storage Default
{
<Data name="OwnersDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>fio</Value>
</Value>
<Value name="3">
<Value>address</Value>
</Value>
<Value name="4">
<Value>passport</Value>
</Value>
</Data>
<DataLocation>^Carworkshop.OwnersD</DataLocation>
<DefaultData>OwnersDefaultData</DefaultData>
<IdLocation>^Carworkshop.OwnersD</IdLocation>
<IndexLocation>^Carworkshop.OwnersI</IndexLocation>
<StreamLocation>^Carworkshop.OwnersS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
