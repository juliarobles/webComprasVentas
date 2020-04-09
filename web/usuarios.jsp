<%-- 
    Document   : usuarios
    Created on : 07-abr-2020, 18:15:20
    Author     : yisus
--%>

<%@page import="comprasventasweb.dto.UsuarioDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu Principal Usuarios</title>
    </head>
    <%
        List<UsuarioDTO> usuarios = (List)request.getAttribute("listaUsuario");
    %>
    <body>
        <h1>NOMBRE WEB A DECIDIR AUN</h1>
        <%
        if (usuarios == null || usuarios.isEmpty()) {
        %>          
            <h2>Ningún usuario ha sido creado todavía</h2>
         <%
        } else {
        %>
        <table border="1">
        <tr>
            <th>ID</th>
            <th>USUARIO</th>
            <th>EMAIL</th>
            <th>NOMBRE</th>
            <th>ADMINISTRADOR</th>
            <th>FOTO</th>
            <th></th>
            <th></th>
        </tr>
        <%    
            for (UsuarioDTO usuario : usuarios) {
        %>
        <tr>
            <td><%= usuario.getId() %></td>
            <td><%= usuario.getUsuario() %></td>
            <td><%= usuario.getEmail()  %></td>
            <td><%= usuario.getNombre() %></td>
            <% if (usuario.getAdministrador()){
            %>
            <td>Si</td>
            <% }else{%>
            <td>No</td>
            <%}%>
            <td><img src=<%= usuario.getFoto() %> width="200" height="200"></td>
            <td><a href="UsuarioEditar?id=<%= usuario.getId() %>">Editar</a></td>
            <td><a href="UsuarioBorrar?id=<%= usuario.getId() %>">Borrar</a></td>
<%
            }
        }
%>                     
                     
    </body>
</html>
