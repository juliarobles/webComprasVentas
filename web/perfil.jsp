<%-- 
    Document   : perfil
    Created on : 30-mar-2020, 14:13:09
    Author     : Usuario
    Funcion    : Aqui el usuario podrá ver sus datos y los productos que vende, podrá editarlos o eliminarlos
                 Si nos sobra tiempo haremos un boton para que edite el perfil
--%>

<%@page import="java.text.SimpleDateFormat"%>
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
        <link rel="stylesheet" href="CSS/formularios.css">
        <link rel="stylesheet" href="CSS/perfil.css">
        <a class="volver" href="ProductosListar">&#8592 Volver al menú principal </a></br>
        <div class="todo">
        <img class="avatar" id="avatar" src=<%= user.getFoto() %> width="200" height="200">
        <h1> <%= user.getNombre() %> </h1>
        <h2> @<%= user.getUsuario() %> </h2>
        <h3> Mis productos </h3>
        <%
        if (productos == null || productos.isEmpty()) {
        %>          
            <h2>Ningún producto ha sido publicado todavía</h2>
         <%
        } else {
            SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat hora = new SimpleDateFormat("HH:mm");
        %>
        <table>
        <tr>
            <th>FOTO</th>
            <th>TITULO</th>
            <th>DESCRIPCION</th>
            <th>PRECIO</th>         
            <th>MEDIA</th>
            <th>FECHA Y HORA</th>
            <th></th>
            <th></th>
        </tr>
        <%    
            for (ProductoBasicoDTO producto : productos) {
                String valoracion = "Sin valoraciones", precio = "";
                if(producto.getValoracionmedia() != -1){
                    valoracion = producto.getValoracionmedia()+"";
                }
                Float p = producto.getPrecio();
                if(p % 1 == 0){
                    precio = p.intValue() + "";
                } else {
                    precio = p + "";
                }
        %>
        <tr>
            <td width="100px" height="100px"><img class="imagen" src=<%= producto.getFoto() %>></td>
            <td><%= producto.getTitulo()  %></td>
            <td width="300px"><%= producto.getDescripcion() %></td>
            <td><%= precio %>€</td>     
            <td><%= valoracion %></td> 
            <td><%= (fecha.format(producto.getFecha()) + " " + hora.format(producto.getHora()) )%></td>
            <td><a class="editar" href="ProductoEditar?id=<%= producto.getId() %>">Editar</a></td>
            <td><a class="borrar" href="ProductoBorrar?id=<%= producto.getId() %>" onclick="return confirm('¿Estás seguro?');">Borrar</a></td>
        </tr>
        <%
            }// for
        %>
        </table>
        <%
        }//if
        %>
        </div>
    </body>
</html>
