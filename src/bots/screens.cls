Class Bots.Screens Extends %Persistent
{

Property Text As %String;

Property Bot As Bots.Bots;

Index bot On Bot;

Storage Default
{
<Data name="ScreensDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Text</Value>
</Value>
<Value name="3">
<Value>Bot</Value>
</Value>
</Data>
<DataLocation>^Bots.ScreensD</DataLocation>
<DefaultData>ScreensDefaultData</DefaultData>
<IdLocation>^Bots.ScreensD</IdLocation>
<IndexLocation>^Bots.ScreensI</IndexLocation>
<StreamLocation>^Bots.ScreensS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
