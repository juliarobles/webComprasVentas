/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comprasventasweb.service;

import comprasventasweb.dao.ProductoFacade;
import comprasventasweb.dao.UsuarioFacade;
import comprasventasweb.dao.ValoracionFacade;
import comprasventasweb.dto.ProductoDTO;
import comprasventasweb.dto.UsuarioDTO;
import comprasventasweb.dto.ValoracionDTO;
import comprasventasweb.entity.Producto;
import comprasventasweb.entity.Usuario;
import comprasventasweb.entity.Valoracion;
import java.util.List;
import javax.ejb.EJB;

/**
 *
 * @author danim
 */
public class ValoracionService {
     @EJB
     private ValoracionFacade valoracionFacade;
     
     @EJB 
     private ProductoFacade productoFacade;
     
     @EJB
     private UsuarioFacade usuarioFacade;
     
     @EJB 
     private ProductoService productoService;
     
     @EJB
     private UsuarioService usuarioService;
     
      public void createOrUpdate (int nota, int usuario, int producto) {
        Valoracion val= this.valoracionFacade.searchByProductoYUser(usuario, producto).get(0);
        
        boolean esCrearNuevo = false;
        
        if ( val ==null ) { // Estamos en el caso de creación de un nuevo cliente
            val = new Valoracion(); // Aunque el id es autoincremental, hay ocasiones en las que
                                       // si no se le da un valor por defecto, da un error al guardarlo.
            esCrearNuevo = true;
        } 

        
        val.setNota(nota);
        val.setProducto1(this.productoFacade.find(producto+""));
        val.setUsuario1(this.usuarioFacade.find(usuario));
       
        
        if (esCrearNuevo) {
            this.valoracionFacade.create(val);
        } else {
            this.valoracionFacade.edit(val);
        } 
    }
         
   
    
    public void valorar(int v, ProductoDTO pr, UsuarioDTO usu){
        //Primero tenemos que ver si el usuario ha valorado ya antes este producto
        
       
            this.createOrUpdate(v, usu.getId(), pr.getId());
        
        
        //Finalmente actualizamos la media de las valoraciones
            actualizarMedia(pr.getId());
    }
    
    public void actualizarMedia (int producto){
        List<Valoracion> lista=  this.valoracionFacade.obtenerListaValoraciones(producto);
        float media = 0;
        for(Valoracion v:lista){
            if(v.getNota()<=5 && v.getNota()>=0){
               media+=v.getNota();   
            }
          
         }
        media = media/lista.size();
        
        Producto pr =this.productoFacade.find(producto);
       pr.setValoracionmedia(media);
       this.productoFacade.edit(pr);
    }
}