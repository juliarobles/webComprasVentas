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
         <style>
            
            body {font-family: Arial, Helvetica, sans-serif;}

/* Full-width input fields */
input[type=text], input[type=password] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

/* Set a style for all buttons */


button:hover {
  opacity: 0.8;
}

/* Extra styles for the cancel button */
.cancelbtn {
  width: auto;
  padding: 10px 18px;
  background-color: #f44336;
}

/* Center the image and position the close button */
.imgcontainer3 {
  text-align: center;
  margin: 24px 0 12px 0;
  position: relative;
}

img.avatar {
  width: 20%;
  border-radius: 50%;
}



span.psw {
  float: right;
  padding-top: 16px;
}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: #ffffff; /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
  padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
  border: 1px solid #888;
  width: 40%; /* Could be more or less, depending on screen size */
}

/* The Close Button (x) */
.close {
  position: absolute;
  right: 25px;
  top: 0;
  color: #000;
  font-size: 35px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: red;
  cursor: pointer;
}

/* Add Zoom Animation */
.animate {
  -webkit-animation: animatezoom 0.6s;
  animation: animatezoom 0.6s
}

@-webkit-keyframes animatezoom {
  from {-webkit-transform: scale(0)} 
  to {-webkit-transform: scale(1)}
}
  
@keyframes animatezoom {
  from {transform: scale(0)} 
  to {transform: scale(1)}
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
  span.psw {
     display: block;
     float: none;
  }
  .cancelbtn {
     width: 100%;
  }
}
        </style>
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
                                style="float:left;" ><titulo><%=pr.getTitulo()%></titulo></div>
                           <div class="contenidoVertical" style="margin-left: 20px" style="float:left;" >
                               <categoria>➤<%=pr.getCategoria().getNombre()%></categoria></div>
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
                <div class="usuarioVendedor"><vendedor>@<%=pr.getVendedor().getNombre()%></vendedor></div>
                <div class="descripcion"><textoDescripcion><%=pr.getDescripcion()%></textoDescripcion></div>
            </div>
            <div class="cajaComentarios">
                <h1>Opiniones</h1> 
                      <button onclick="document.getElementById('id01').style.display='block'" style="width:auto;">Comentar</button>

                    <div id="id01" class="modal">

                      <form class="modal-content animate" action="Comentar" method="post">
                        <div class="tituloComentar">
                            <h1>Nuevo comentario</h1>
                        </div>

                        <div class="container3">
                          
                          
                            <textarea class="contenidoComentario"  maxlength="300"cols="60" rows="8" name="comentario" required ></textarea>
                         

                          <button type="submit">Enviar comentario</button>
                          
                        </div>

                        <div class="container3" >
                          <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancelar</button>
                         
                        </div>
                      </form>
                    </div>

                    <script>
                    // Get the modal
                    var modal = document.getElementById('id01');

                    // When the user clicks anywhere outside of the modal, close it
                    window.onclick = function(event) {
                        if (event.target === modal) {
                            modal.style.display = "none";
                        }
                    };
                    </script>
                <%
                List<ComentarioDTO> comentarios = (List)request.getAttribute("listaComentarios");
                if (comentarios == null || comentarios.isEmpty()) {
                %>          
            <h2>Ninguna opinión ha sido publicada todavía</h2>
                <% 
                } else {
                    for(ComentarioDTO c : comentarios){%>
                    <div class="contenedorComentario" >
                        <div class="usuarioComentario">
                            <emisor> @<%=c.getUsuario().getNombre()%> - <%= fecha.format(c.getFecha()) + " - " + hora.format(c.getHora()) %></emisor>
                        </div>
                        <div class="container">
                            <textoComentario><%= c.getTexto() %></textoComentario>
                                
                        </div>
                        
                    </div>
                <%
                    }
                    
                }
                %>
            </div>
    </div> 
        
    </body>
</html>
