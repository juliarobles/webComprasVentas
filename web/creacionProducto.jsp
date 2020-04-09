<%-- 
    Document   : producto
    Created on : 30-mar-2020, 14:04:51
    Author     : Usuario
    Funcion    : Aqui se podrá crear un nuevo producto o editar uno existente, 
--%>

<%@page import="comprasventasweb.dto.EtiquetaDTO"%>
<%@page import="comprasventasweb.dto.SubcategoriaBasicaDTO"%>
<%@page import="comprasventasweb.dto.ProductoDTO"%>
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
            String id = "", titulo = "", descripcion = "", precio = "", foto = "", vendedor = "", etiquetas = "";
            int categoria = -1, subcategoria = -1;
            //Vendedor nunca puede ser null, ya hemos iniciado sesion con un usuario, pero como aun no esta implementado el login
            //no puedo hacer esto. Pondremos a pepito propietario de todo por ahora.
            List<CategoriaDTO> categorias = (List) request.getAttribute("listaCategorias");
            
            ProductoDTO producto = (ProductoDTO)request.getAttribute("producto");
            String editar = null;
            
            if(producto != null){
                id = producto.getId() + "";
                titulo = producto.getTitulo();
                descripcion = producto.getDescripcion();
                precio = producto.getPrecio()+"";
                categoria = producto.getCategoria().getCategoriaPadre().getId();
                subcategoria = producto.getCategoria().getId();
                foto = producto.getFoto();
                vendedor = producto.getVendedor().getId()+"";
                StringBuilder sb = new StringBuilder();
                for(EtiquetaDTO et : producto.getEtiquetas()){
                    sb.append("#");
                    sb.append(et.getNombre());
                    sb.append(" ");
                }
                etiquetas = sb.toString();
                editar = "1";
            } 
            
            //Aqui va el si no es nulo noseque entonces rellenar todo (para el editar)
            //Recuerda coger el id de categoria y no la categoria entera
        %>
        <form action="ProductoGuardar">
            <input type="hidden" name="editar" value="<%= editar %>" />
            <input type="hidden" name="id" value="<%= id %>" />
            <input type="hidden" name="vendedor" value="<%= vendedor %>" />
            <script type="text/javascript" src="javascript/subcategoria.js"></script>
            <script type="text/javascript" src="javascript/comprobacionesProducto.js"></script>
            <table>
                <tr>
                    <td>Titulo</td>
                    <td><input type="text" name="titulo" value="<%= titulo %>" size="30" minlength="1" maxlength="100" required/></td> 
                </tr>
                <tr>
                    <td>Descripcion</td>
                    <td><input type="text" name="descripcion" value="<%= descripcion %>" size="30" maxlength="500" /></td> 
                </tr>
                <tr>
                    <td>Categoria</td>
                    <td>
                        <select id = "categoria" name="categoria" onchange="cargarSubcategorias();">
                            <option value="">Seleccione una categoria...</option>
                        <%
                            
                            for (CategoriaDTO cat : categorias) {
                                String seleccionado = "";
                                if (categoria != -1 && categoria == cat.getId()) {
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
                        <select id="subcategoria" name="subcategoria" required>
                            <%
                                if(subcategoria == -1){
                            %>
                                <option value="">Seleccione una subcategoria...</option>
                            <%
                                } else {
                                   for (SubcategoriaBasicaDTO cat : producto.getCategoria().getCategoriaPadre().getSubcategoriaList()) {
                                    String seleccionado = "";
                                    if (subcategoria != -1 && subcategoria == cat.getId()) {
                                        seleccionado = "selected";
                                    }
                            %>
                                <option <%= seleccionado %> value=<%= cat.getId() %>><%= cat.getNombre() %></option>
                            <%
                                    }
                                }
                            %>
                            
                        </select>
                    </td> 
                </tr>
                <tr>
                    <td>Precio</td>
                    <td><input type="number" name="precio" value="<%= precio %>" size="30" min="0" maxlength="50" required/></td> 
                </tr>
                <tr>
                    <td>Foto</td>
                    <td><input type="url" name="foto" value="<%= foto %>" size="30" maxlength="520" /></td>
                </tr>
                <tr>
                    <td>Etiquetas</td>
                    <td><input type="text" name="etiquetas" value="<%= etiquetas %>" size="30" maxlength="200" /></td>
                </tr>
            </table>
            <button type="submit" onclick="comprobar()">Publicar producto</button>
        </form>
    </body>
</html>
