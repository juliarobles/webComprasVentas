/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comprasventasweb.service;

import comprasventasweb.dao.ComentarioFacade;
import comprasventasweb.dao.ProductoFacade;
import comprasventasweb.dto.ComentarioDTO;
import comprasventasweb.dto.ProductoDTO;
import comprasventasweb.entity.Comentario;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;

/**
 *
 * @author rober
 */
@Stateless
public class ComentarioService {
    
    @EJB
    private ComentarioFacade comentarioFacade;
    
    @EJB
    private ProductoFacade productoFacade;
    
    protected List<ComentarioDTO> convertToDTO (List<Comentario> listaComentarios) {
        List<ComentarioDTO> listaDTO = null;
        if (listaComentarios != null) {
            listaDTO = new ArrayList<>();
            for (Comentario c : listaComentarios) {
                listaDTO.add(c.getDTO());
            }
        }
        return listaDTO;
    } 
    
    public List<ComentarioDTO> searchByProducto(ProductoDTO producto) {
        List<Comentario> listaComentarios = this.comentarioFacade.findByProducto(this.productoFacade.findById(producto.getId()));
        return this.convertToDTO(listaComentarios);
    }
}
