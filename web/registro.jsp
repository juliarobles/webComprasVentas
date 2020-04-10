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
        <link rel="stylesheet" href="CSS/registro.css">
        <%
        //Poner las cosas que se tiene que comprobar al hacer el registro
        //Nombre, correo (comprobar requerimientos), contraseña, nombre de usuario
        String statusUsuario, statusNombre, statusCorreo, statusContraseña;
        
        statusUsuario = (String)request.getAttribute("statusUsuario");
        if(statusUsuario == null){
            statusUsuario = "";
        }

            statusCorreo = (String)request.getAttribute("statusCorreo");
        if(statusCorreo == null){
            statusCorreo = "";
        }
              statusContraseña = (String)request.getAttribute("statusContraseña");
        if(statusContraseña == null){
            statusContraseña = "";
        }
        
               statusNombre = (String)request.getAttribute("statusNombre");
        if(statusNombre == null){
            statusNombre = "";
        }
        //String prueba = "hola";
        %>
        <div>
            <h1>¡Bienvenido!</h1>
        <h3>Introduce tus datos</h3>
        <form method="post" action="RegistrarUsuario">
            
            
            
         <!--   <table>
                <tr>
        <td>Usuario:</td>
        <td><input type="text" maxlength ="50" size="50" name="usuario" pattern="[A-Za-z0-9]+" required></td> 
        <td><%=statusUsuario%></td>
    </tr>
        <tr>
        <td>Correo electrónico:</td>
        <td><input type="email" maxlength ="100" size="50" name="correo" required></td> 
        <td><%=statusCorreo%></td>
    </tr>
        <tr>
        <td>Nombre:</td>
        <td><input type="text" maxlength ="100" size="50" name="nombre" pattern="[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,'-]{1,100}" required></td> 
        <td><%=statusNombre%></td>
    </tr>
        <tr>
        <td>Contraseña:</td>
        <td><input type="password" minlength="8" maxlength ="50" size="50" name="pass" pattern="[A-Za-z0-9!?-]{8,50}" required></td> 
        <td><%=statusContraseña%></td>
    </tr>
    <tr>
        <td><input type="submit" value="Enviar"></td>
    </tr> 
        
            </table>-->
        </form>
        </div>
        
    
    
     <!--
     Meter comprobación de contraseña (mirar más adelante)
     Meter valor del administrador 
     Meter foto
     Generar ID y meter usuario en la base de datos
     -->
    </body>
</html>
