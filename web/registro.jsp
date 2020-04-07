<%-- 
    Document   : registro
    Created on : 30-mar-2020, 14:03:26
    Author     : Usuario
    Funcion    : Aqui se podrá registrar un usuario (los admin no pueden registrarse)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nuevo usuario</title>
    </head>
    <body>
        
        <%
        //Poner las cosas que se tiene que comprobar al hacer el registro
        //Nombre, correo (comprobar requerimientos), contraseña, nombre de usuario
        %>
        <h1>¡Bienvenido!</h1>
        <h3>Introduce tus datos</h3>
        <form method="post" action="RegistrarUsuario">
            <table>
                <tr>
        <td>Usuario:</td>
        <td><input type="text" maxlength ="50" size="50" name="usuario"></td> 
    </tr>
        <tr>
        <td>Correo electrónico:</td>
        <td><input type="text" maxlength ="100" size="50" name="correo"></td> 
    </tr>
        <tr>
        <td>Nombre:</td>
        <td><input type="text" maxlength ="100" size="50" name="nombre"></td> 
    </tr>
        <tr>
        <td>Contraseña:</td>
        <td><input type="password" maxlength ="50" size="50" name="pass"></td> 
    </tr>
    <tr>
        <td><input type="submit" value="Enviar"></td>
    </tr> 
        
            </table>
        </form>
    
    
     <!--
     Meter comprobación de contraseña (mirar más adelante)
     Meter valor del administrador 
     Meter foto
     Generar ID y meter usuario en la base de datos
     -->
    </body>
</html>
