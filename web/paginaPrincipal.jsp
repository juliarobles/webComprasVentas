<%-- 
    Document   : paginaPrincipal
    Created on : 30-mar-2020, 14:03:57
    Author     : Usuario
    Funcion    : Aqui se verá el listado de productos y se podrá pulsar sobre ellos para verlos con mayor detalle, tambien contará con
                 un boton para acceder a su perfil con los productos vendidos por el propio usuario y con otro para añadir un nuevo producto
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="comprasventasweb.dto.ProductoBasicoDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú principal</title>
        <link rel="stylesheet" href="CSS/paginaPrincipal.css">
    </head>
    <%
        List<ProductoBasicoDTO> productos = (List)request.getAttribute("listaProductos");

        SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat hora = new SimpleDateFormat("HH:mm");
    %>
    <body>
        <img class="headerImagen" src="imagenes/logo.png" width="800" height="100">
        <a href="CerrarSesion">Cerrar sesión</a>
        <a href="ProductoCrear">Nuevo producto</a>
        <a href="PerfilUsuario">Perfil</a>
        <br>
        <%
        if (productos == null || productos.isEmpty()) {
        %>          
            <h2>Ningún producto ha sido publicado todavía</h2>
         <%
        } else {
        %>
        <div class="band">
        <%    
            String precio = "", valoracion = "";
            for (ProductoBasicoDTO producto : productos) {
                Float p = producto.getPrecio();
                if(p % 1 == 0){
                    precio = p.intValue() + "";
                } else {
                    precio = p + "";
                }
                if(producto.getValoracionmedia() < 0){
                    valoracion = "-";
                } else {
                    valoracion = producto.getValoracionmedia() + "";
                }
        %>
        <div class="item">
           <a href="PerfilUsuario" class="card">
            <div class="imagen">
                <img src=<%= producto.getFoto() %>>
            </div>
            <article>
                <div class ="top">
                   <vendedor>@<%= producto.getVendedor().getUsuario() %></vendedor>
                   <valoracion><%= valoracion %>★</valoracion>
                </div>
                <h4 class="tituloCard"><%= producto.getTitulo()  %></h1>
                <p class = "descripcionCard"><%= producto.getDescripcion() %></p>
                <div class="bottom">
                    <precio><%= precio %>€</precio>
                    <fecha><%= fecha.format(producto.getFecha()) + " " + hora.format(producto.getHora()) %></fecha>
                    
                </div>
            </article>
           </a>
        </div>
        
        
        <!--
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
            <td><%= producto.getHora() %></td>
        </tr>
        -->
        <%
            }// for
        %>
        <!--
        </table>
        -->
        </div>
        <%
        }//if
        %>
    </body>
</html>
