<%-- 
    Document   : verProducto
    Created on : 30-mar-2020, 14:16:53
    Author     : Usuario
    Funcion    : En esta pantalla se podrá ver toda la información del producto con detalle, habrá un botón de comprar que no se implementará.
                 Se mantendrá el botón del perfil y el añadir producto. Además aqui se podrá comentar y valorar el producto.
--%>

<%@page import="comprasventasweb.dto.ComentarioDTO"%>
<%@page import="comprasventasweb.entity.Comentario"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="comprasventasweb.dto.ProductoDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
        HttpSession sesion = request.getSession();
        ProductoDTO pr = (ProductoDTO)sesion.getAttribute("producto");
        Integer valoracion = (Integer)request.getAttribute("valoracion");
        //De primeras supondremos que producto no es null, si da error pues se arregla y listo (o ponemos una ventana 
        //de ha ocurrido un error)
        //Vamos a poner que ponga un producto aleatorio, luego descomentaremos las lineas de arriba
        
            SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat hora = new SimpleDateFormat("HH:mm");
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=pr.getTitulo()%></title>
    </head>
    <body>
       <link rel="stylesheet" href="CSS/formularios.css">
        <link rel="stylesheet" href="CSS/verProducto.css">
        <script type="text/javascript" src="javascript/ponerEstrellas.js"></script>
        <a class="volver" href="ProductosListar">&#8592 Volver al menú principal </a></br>
        <div class="todo">
            <div class="contenido1" >
                <img class="imagen" src="<%=pr.getFoto()%>">
            </div>
            <div class="contenido" style="height: 90px" >
                <div class="contenidoIzquierda">
                    <div class="contenedorVertical" style="margin-left: 35px">
                           <div class="contenidoVertical" 
                                style="float:left;" ><h1 ><%=pr.getTitulo()%></h1></div>
                           <div class="contenidoVertical" style="margin-left: 20px" style="float:left;" >
                               <h1 style="font-size: 25px">➤<%=pr.getCategoria().getNombre()%></h1></div>
                    </div>
                </div> 
                
                <div class="contenidoDerecha">
                    
                    <div class="contenedorVertical">
                        <input type="hidden" id="val" name="val" value="<%= valoracion %>" />
                        <div class="centrado"   ><h1 >Valoraci&oacute;n</h1></div>
                        <div class="contenidoVertical"  >
                                <form method="post" action="GuardarValoracion?id=<%= pr.getId() %>" style="width:100%">
                                <p class="clasificacion">
                                    <input id="radio1" type="radio" name="estrellas" value="5" onclick="javascript:submit()"><!--
                                    --><label id="valor5" class="estrella" for="radio1">★</label><!--
                                    --><input id="radio2" type="radio" name="estrellas" value="4"onclick="javascript:submit()"><!--
                                    --><label id="valor4" class="estrella"  for="radio2">★</label><!--
                                    --><input id="radio3" type="radio" name="estrellas" value="3"onclick="javascript:submit()"><!--
                                    --><label id="valor3" class="estrella" for="radio3">★</label><!--
                                    --><input id="radio4" type="radio" name="estrellas" value="2"onclick="javascript:submit()"><!--
                                    --><label id="valor2" class="estrella" for="radio4">★</label><!--
                                    --><input id="radio5" type="radio" name="estrellas" value="1"onclick="javascript:submit()"><!--
                                    --><label id="valor1" class="estrella" for="radio5">★</label>
                                    
                                </p>
                                
                            </form>
                            
                        </div>
                    </div>  
                </div>
            </div>
            <div class="contenedorVertical">
                <div class="contenidoVertical"><h1 class="margen">Vendedor: <%=pr.getVendedor().getNombre()%></h1></div>
                <div class="contenidoVertical"><p><%=pr.getDescripcion()%></p></div>
            </div>
            <div class ="comentarios">
                <h1>Opiniones</h1>
                <%
                List<ComentarioDTO> comentarios = (List)request.getAttribute("listaComentarios");
                if (comentarios == null || comentarios.isEmpty()) {
                %>          
            <h2>Ninguna opinión ha sido publicada todavía</h2>
                <% 
                } else {
                    for(ComentarioDTO c : comentarios){%>
                        <hr>
                        Autor: <%=c.getUsuario().getNombre()%><br>
                        Fecha: <%= fecha.format(c.getFecha()) + " " + hora.format(c.getHora()) %><br><br>
                        <%= c.getTexto() %><br>
                <%
                    }
                    
                }
                %>
            </div>
        </div>
        
    </body>
</html>
