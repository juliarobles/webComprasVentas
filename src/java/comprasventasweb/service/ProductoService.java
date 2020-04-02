/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comprasventasweb.service;

import comprasventasweb.dao.ProductoFacade;
import comprasventasweb.dto.ProductoBasicoDTO;
import comprasventasweb.entity.Producto;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;

/**
 *
 * @author Usuario
 */
@Stateless
public class ProductoService {
    
    @EJB
    private ProductoFacade productoFacade;
    
    
    protected List<ProductoBasicoDTO> convertToDTO (List<Producto> listaProductos) {
        List<ProductoBasicoDTO> listaDTO = null;
        if (listaProductos != null) {
            listaDTO = new ArrayList<>();
            for (Producto p : listaProductos) {
                listaDTO.add(p.getDTOBasico());
            }
        }
        return listaDTO;
    }    
    
    public List<ProductoBasicoDTO> searchAll () {
        List<Producto> listaProductos = this.productoFacade.findAll();
        return this.convertToDTO(listaProductos);
    }
}
