<%-- 
    Document   : paginaPrincipal
    Created on : 30-mar-2020, 14:03:57
    Author     : Usuario
    Funcion    : Aqui se verá el listado de productos y se podrá pulsar sobre ellos para verlos con mayor detalle, tambien contará con
                 un boton para acceder a su perfil con los productos vendidos por el propio usuario y con otro para añadir un nuevo producto
--%>

<%@page import="comprasventasweb.dto.SubcategoriaBasicaDTO"%>
<%@page import="comprasventasweb.dto.CategoriaDTO"%>
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
        List<CategoriaDTO> categorias = (List) request.getAttribute("listaCategorias");

        SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat hora = new SimpleDateFormat("HH:mm");
        
    %>
    <body>
        <% String busqueda = (String) request.getAttribute("busqueda");
            if(busqueda == null){
                busqueda = "";
            }
           String sel = (String) request.getAttribute("selectBusqueda");
           int categoria = -1;
           String cate = (String) request.getAttribute("categoria");
           int subcategoria = -1;
           String subcate = (String) request.getAttribute("subcategoria");
           if(subcate != null){
               subcategoria = Integer.parseInt(subcate);
           } else if (cate != null) {
               categoria = Integer.parseInt(cate);
           }
           request.removeAttribute("subcategoria");
           request.removeAttribute("categoria");
           
           String[][] buscar = {{"TituloDescripcion", "Título y descripción"}, {"Titulo","Título"}, {"Descripcion","Descripción"}, {"Etiqueta","Etiquetas"}, 
                            {"FechaHora", "Fecha y hora"}, {"Fecha","Fecha"}, {"Hora","Hora"}};

        %>
        
        <!--<div class="header">
        
        </div>-->
        <div class="navbar" id="navbar">
        <img class="headerImagen" src="imagenes/logoblanco.png" width="100" height="30">
        <script type="text/javascript" src="javascript/buscador.js"></script> 
        <form action="ProductosListar">
            <select class="selectBuscar" id="selectBuscar" name="selectBuscar" onchange="changePlaceholder()">
                <%
                    for(String[] m : buscar){
                        String seleccionado = "";
                        if(sel!= null && sel.equals(m[0])){
                            seleccionado = "selected";
                        }
                %>
                    <option <%= seleccionado %> value=<%= m[0] %>><%= m[1]%></option>
                <%
                    }
                %>
                <!--
                <option value="TituloDescripcion">Título y descripción</option>
                <option value="Titulo">Título</option>
                <option value="Descripcion">Descripción</option>
                <option value="Etiqueta">Etiquetas</option>
                <option value="FechaHora">Fecha y hora</option>
                <option value="Fecha">Fecha</option>
                <option value="Hora">Hora</option>-->
            </select>
            <input type="text" name="busqueda" id="busqueda" value="<%=busqueda%>" placeholder="" size="30" maxlength="300" minlength="1" required>
        </form>
        
        <form action="ProductosListar">
            <select class="categorias" id = "categoria" name="categoria" onchange="this.form.submit()">
                            <option value="">Todas las categorías</option>
                        <%
                            
                            for (CategoriaDTO cat : categorias) {
                                String seleccionado = "";
                                if (categoria != -1 && categoria == cat.getId()) {
                                    seleccionado = "selected";
                                } 
    %>
                            <option <%= seleccionado %> value=<%= "A" + cat.getId() %>><%= cat.getNombre() %></option>
    <%                          for(SubcategoriaBasicaDTO sub : cat.getSubcategoriaList()){
                                    seleccionado = "";
                                    if (subcategoria != -1 && subcategoria == sub.getId()) {
                                        seleccionado = "selected";
                                    } 
    %>
                            <option <%= seleccionado %> value=<%= "B" + sub.getId() %>><%= "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + sub.getNombre() %></option>
    <%
                                }
                            }
    %>  
            </select>
        </form>
            <a href="CerrarSesion">Cerrar sesión</a>
            <a href="PerfilUsuario">Perfil</a>
            <a class="Crear" href="ProductoCrear">Nuevo producto</a>
        </div>    
            
        <div class="main">
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
           <a href="verProducto" class="card">
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
        <!--<script type="text/javascript" src="javascript/navbar.js"></script>-->
        </div>
    </body>
</html>
