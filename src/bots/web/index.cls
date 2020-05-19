Class Bots.Web.Index Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
    &HTML<
    <html>
    <head>
        <link rel="stylesheet" href="/csp/irisapp/webix/webix.min.css" type="text/css" charset="utf-8">
        <script src="/csp/irisapp/webix/webix.min.js" type="text/javascript" charset="utf-8"></script>
        <script src="/csp/irisapp/js/main.js" type="text/javascript" charset="utf-8"></script>
    </head>
    <body>
        <div id="form_div"></div>
        <div id="users_list_div"></div>
    </body>
</html>
    >
    return $$$OK
}

}
