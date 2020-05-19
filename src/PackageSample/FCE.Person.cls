Class FCE.Person Extends %Persistent
{

Property numD As %Double;

Property Address As User.Address;

Property Document As User.Document;

Property Name As %String [ InitialExpression = "a" ];

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Address</Value>
</Value>
<Value name="4">
<Value>Document</Value>
</Value>
<Value name="5">
<Value>num</Value>
</Value>
<Value name="6">
<Value>numD</Value>
</Value>
</Data>
<DataLocation>^FCE.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^FCE.PersonD</IdLocation>
<IndexLocation>^FCE.PersonI</IndexLocation>
<StreamLocation>^FCE.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
