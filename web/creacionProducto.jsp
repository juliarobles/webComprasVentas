<%-- 
    Document   : producto
    Created on : 30-mar-2020, 14:04:51
    Author     : Usuario
    Funcion    : Aqui se podrá crear un nuevo producto o editar uno existente, 
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="comprasventasweb.dto.CategoriaDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nuevo producto</title>
    </head>
    <body>
        <%
            String id = "", titulo = "", descripcion = "", precio = "", categoria = null, foto = "", vendedor = "1";
            //Vendedor nunca puede ser null, ya hemos iniciado sesion con un usuario, pero como aun no esta implementado el login
            //no puedo hacer esto. Pondremos a pepito propietario de todo por ahora.
            List<CategoriaDTO> categorias = (List) request.getAttribute("listaCategorias");
            
            //Aqui va el si no es nulo noseque entonces rellenar todo (para el editar)
            //Recuerda coger el id de categoria y no la categoria entera
        %>
        <form action="ProductoGuardar">
            <input type="hidden" name="id" value="<%= id %>" />
            <input type="hidden" name="vendedor" value="<%= vendedor %>" />
            <script type="text/javascript" src="javascript/subcategoria.js"></script>
            <table>
                <tr>
                    <td>Titulo</td>
                    <td><input type="text" name="titulo" value="<%= titulo %>" size="30" max="30" maxlength="30" /></td> 
                </tr>
                <tr>
                    <td>Descripcion</td>
                    <td><input type="text" name="descripcion" value="<%= descripcion %>" size="30" max="30" maxlength="30" /></td> 
                </tr>
                <tr>
                    <td>Categoria</td>
                    <td>
                        <select id = "categoria" name="categoria" onchange="cargarSubcategorias();">
                            <option value="">Seleccione una categoria...</option>
                        <%
                            
                            for (CategoriaDTO cat : categorias) {
                                String seleccionado = "";
                                if (categoria != null && categoria.equals(cat.getId())) {
                                    seleccionado = "selected";
                                }
                                Gson gson = new Gson();
                                String json = gson.toJson(cat.getSubcategoriaList().toArray()).toString();
    %>
                            <option <%= seleccionado %> value=<%= json %>><%= cat.getNombre() %></option>
    <%
                            }
    %>  
                        </select>
                    </td> 
                </tr>
                <tr>
                    <td>Subcategoria</td>
                    <td>
                        <select id="subcategoria" name="subcategoria" >
                            <option value="">Seleccione una subcategoria...</option>
                        </select>
                    </td> 
                </tr>
                <tr>
                    <td>Precio</td>
                    <td><input type="text" name="precio" value="<%= precio %>" size="30" max="30" maxlength="30" /></td> 
                </tr>
                <tr>
                    <td>Foto</td>
                    <td><input type="text" name="foto" value="<%= foto %>" size="30" max="30" maxlength="30" /></td>
                </tr>
            </table>
            <button type="submit">Publicar producto</button>
        </form>
    </body>
</html>
