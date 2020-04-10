<%-- 
    Document   : verProducto
    Created on : 30-mar-2020, 14:16:53
    Author     : Usuario
    Funcion    : En esta pantalla se podrá ver toda la información del producto con detalle, habrá un botón de comprar que no se implementará.
                 Se mantendrá el botón del perfil y el añadir producto. Además aqui se podrá comentar y valorar el producto.
--%>

<%@page import="comprasventasweb.dto.ProductoDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
           <%
            HttpSession sesion = request.getSession();
            ProductoDTO pr = (ProductoDTO)sesion.getAttribute("producto");
            //De primeras supondremos que producto no es null, si da error pues se arregla y listo (o ponemos una ventana 
        //de ha ocurrido un error)
        //Vamos a poner que ponga un producto aleatorio, luego descomentaremos las lineas de arriba
        
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=pr.getTitulo()%></title>
    </head>
    <body>
        <table>
            <tr>
                <td><img src="<%=pr.getFoto()%>"></td>   
            </tr>
            <tr>
                <td><h3>Descripción del producto</h3></td>   
                 <td><%=pr.getDescripcion()%></td> 
            </tr>
              <tr>
                <td><h3>Precio</h3></td>   
                 <td><%=pr.getPrecio() + " €"%></td> 
            </tr>
                <tr>
                <td><h3>Fecha</h3></td>   
                 <td><%=pr.getFecha()%></td>
                 <td><%=pr.getHora()%></td>
            </tr>
            <tr>
                <td><h3>Valoración</h3></td>   
            </tr>
            <tr>  
                 <td><%=pr.getValoracionmedia()%></td> 
            </tr>
              
            <tr>
                <td><h3>Vendedor</h3></td>   
                <td><%=pr.getVendedor().getNombre()%></a></td> 
            </tr>
        </table>
        
        
        
    </body>
</html>
