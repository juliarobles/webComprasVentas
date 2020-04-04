<%-- 
    Document   : perfil
    Created on : 30-mar-2020, 14:13:09
    Author     : Usuario
    Funcion    : Aqui el usuario podrá ver sus datos y los productos que vende, podrá editarlos o eliminarlos
                 Si nos sobra tiempo haremos un boton para que edite el perfil
--%>

<%@page import="comprasventasweb.dto.ProductoBasicoDTO"%>
<%@page import="java.util.List"%>
<%@page import="comprasventasweb.dto.UsuarioDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
        UsuarioDTO user = (UsuarioDTO)session.getAttribute("usuario");
         if (user == null) {
            response.sendRedirect("login.jsp");  
            return;
        }
        List<ProductoBasicoDTO> productos = (List)request.getAttribute("productosUsuario");
     %>
    <body>
        <img id="avatar" src=<%= user.getFoto() %> width="200" height="200">
        <h1> <%= user.getNombre() %> </h1>
        <h2> <%= user.getUsuario() %> </h2>
        <%
        if (productos == null || productos.isEmpty()) {
        %>          
            <h2>Ningún producto ha sido publicado todavía</h2>
         <%
        } else {
        %>
        <table border="1">
        <tr>
            <th>ID</th>
            <th>TITULO</th>
            <th>DESCRIPCION</th>
            <th>PRECIO</th>         
            <th>FOTO</th>
            <th>MEDIA</th>
            <th>FECHA Y HORA</th>
            <th></th>
            <th></th>
        </tr>
        <%    
            for (ProductoBasicoDTO producto : productos) {
        %>
        <tr>
            <td><%= producto.getId() %></td>
            <td><%= producto.getTitulo()  %></td>
            <td><%= producto.getDescripcion() %></td>
            <td><%= producto.getPrecio() %></td>
            <% try{
                     %>
                     <td><img src=<%= producto.getFoto() %> width="200" height="200"></td>
                     <% } catch(Exception e){
                     %>
                    <td><%= producto.getFoto() %></td>
                    <%
                        }
                     %>
            
            <td><%= producto.getValoracionmedia() %></td> 
            <td><%= producto.getFecha() %></td>
            <td><a href="ProductoEditar?id=<%= producto.getId() %>">Editar</a></td>
            <td><a href="ProductoBorrar?id=<%= producto.getId() %>">Borrar</a></td>
        </tr>
        <%
            }// for
        %>
        </table>
        <%
        }//if
        %>
    </body>
</html>
