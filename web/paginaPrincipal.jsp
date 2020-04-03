<%-- 
    Document   : paginaPrincipal
    Created on : 30-mar-2020, 14:03:57
    Author     : Usuario
    Funcion    : Aqui se verá el listado de productos y se podrá pulsar sobre ellos para verlos con mayor detalle, tambien contará con
                 un boton para acceder a su perfil con los productos vendidos por el propio usuario y con otro para añadir un nuevo producto
--%>

<%@page import="comprasventasweb.dto.ProductoBasicoDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú principal</title>
    </head>
    <%
        List<ProductoBasicoDTO> productos = (List)request.getAttribute("listaProductos");
    %>
    <body>
        <h1>NOMBRE WEB A DECIDIR AUN</h1>
        <a href="ProductoCrear">Nuevo producto</a>
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
            <th>VENDEDOR</th>
            <th>FECHA Y HORA</th>
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
            <td><%= producto.getVendedor().getUsuario() %></td>
            <td><%= producto.getFecha() %></td> 
        </tr>
        <%
            }// for
        }//if
        %>
        </table>
    </body>
</html>
