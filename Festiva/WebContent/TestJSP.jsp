<%-- 
    Document   : form
    Created on : 04.10.2016, 15:47:20
    Author     : Alina Fankhänel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello Form!</h1>
        <p>Insert your E-Mail-Address!</p>
        <form action="TestServlet" method="GET">
            <input name="email" type="email" value="alina.fankhaenel@festiva.de">     
            <input value="Sending" type="submit">
        </form>
    </body>
</html>
