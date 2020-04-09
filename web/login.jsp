<%-- 
    Document   : login
    Created on : 30-mar-2020, 14:03:06
    Author     : Usuario
    Funcion    : Aqui el usuario se podra logear o pulsar sobre registrarse para ir a la pantalla de registro
--%>

<%@page import="comprasventasweb.dto.UsuarioDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Iniciar sesi&oacute;n</title>
    </head>
    <body>
        <%
        //Lo primero es crear el usuario donde guardaremos los datos para comprobar su existencia
        UsuarioDTO usuario;
        //Además tendremos una cadena de caracteres status que nos dirá si el usuario está conectado o 
        //no para redireccionarle directamente al inicio de la app con su cuenta metida
        String status;
        
        //Ahora comprobaremos si hay una sesion ya iniciada viendo si el atributo usuario de sesion es null o no
        usuario = (UsuarioDTO)session.getAttribute("usuario");
        
        //Comprobamos si no es null
        if(usuario != null){
            //Aqui redireccionaremos la pagina al inicio de la aplicacion
            if(usuario.getAdministrador()){
                response.sendRedirect("ProductosListar");
            } else {
                response.sendRedirect("PrincipalAdmin");
            }
            //Con esto redireccionaremos al menu si en efecto hay usuario en la sesion
            return;
        }
        
           
         //En cualquier otro caso
         

        status = (String)request.getAttribute("estado");
        //Obtenemos el estado para ver si no hemos accedido a la cuenta por algo o si es la primera
        //vez que entramos o algo asi, importante
        if (status == null) {
            status = "";//Si no hay estado lo igualamos a esto para que no de error
        } 
        %>
        <h2>Iniciar sesi&oacute;n</h2>
        <!--
        Nota 1: Esto solo esta puesto para que yo pudiera acceder a lo que hacia, puedes quitarlo sin miedo
        Nota 2: Cuando tengas que crear el usuario recuerda usar UsuarioDTO y no Usuario
        -->
        
        <form method="post" action="Autenticar">
            <table>
                <tr>
                    <td>Email:</td>
                    <td><input type="text" name="usuario"/></td>                
                </tr>
                <tr>
                    <td>Contraseña:</td>
                    <td><input type="password" name="clave"/></td>                                    
                </tr>            
                <tr>
                    <td colspan="2"><input type="submit" value="Enviar"/></td>
                </tr>
                <tr>                
                    <td colspan="2"><%= status %></td>                    
                </tr>
            </table>
        </form> 
        <form>
            <tr>
            <a href="registro.jsp">¿No tienes cuenta?</a>
            </tr>
        </form>
    </body>
</html>
