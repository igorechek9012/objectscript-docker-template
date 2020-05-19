Class Bots.Bots Extends %Persistent
{

Property Name As %String;

Property Owner As Bots.Users;

Index owner On Owner;

ClassMethod List(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, owner->name, name
	    INTO :id, :ownername, :name
	    FROM Bots.Bots
 	)
 	//вариант в массив INTO :singleUserData()
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "ownername": (ownername), "name": (name)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

Storage Default
{
<Data name="BotsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Owner</Value>
</Value>
</Data>
<DataLocation>^Bots.BotsD</DataLocation>
<DefaultData>BotsDefaultData</DefaultData>
<IdLocation>^Bots.BotsD</IdLocation>
<IndexLocation>^Bots.BotsI</IndexLocation>
<StreamLocation>^Bots.BotsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
