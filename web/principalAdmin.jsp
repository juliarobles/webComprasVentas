<%-- 
    Document   : principalAdmin
    Created on : 30-mar-2020, 14:49:52
    Author     : Usuario
    Funcion    : Esta página simplemente debe enlazar a la lista de productos y la lista de usuarios.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú de administración</title>
    </head>
    <body>
        <center><img class="headerImagen" src="imagenes/logo.png" width="800" height="100"></center>
        <br><a href="CerrarSesion">Cerrar sesión</a>
        <h1> Acceder a... </h1>
        <ul>
            <li><a href="ProductosListar">Lista de productos</a>
            <li><a href="UsuarioListar">Lista de usuarios</a>
        </ul>
    </body>
</html>
