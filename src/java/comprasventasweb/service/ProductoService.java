/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comprasventasweb.service;

import comprasventasweb.dao.ProductoFacade;
import comprasventasweb.dao.SubcategoriaFacade;
import comprasventasweb.dao.UsuarioFacade;
import comprasventasweb.dto.ProductoBasicoDTO;
import comprasventasweb.entity.Producto;
import comprasventasweb.entity.Subcategoria;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
    
    @EJB
    private UsuarioFacade usuarioFacade;
    
    @EJB
    private SubcategoriaFacade subcategoriaFacade;
    
    
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
    
    public void createOrUpdate (String id, String vendedor, String titulo, String descripcion, String precio, String subcategoria,
                                String foto) {
        Producto producto;
        boolean esCrearNuevo = false;
        
        if (id == null || id.isEmpty()) { // Estamos en el caso de creación de un nuevo cliente
            producto = new Producto(0); // Aunque el id es autoincremental, hay ocasiones en las que
                                       // si no se le da un valor por defecto, da un error al guardarlo.
            esCrearNuevo = true;
        } else {
            producto = this.productoFacade.find(new Integer(id));
        }

        producto.setTitulo(titulo);
        producto.setDescripcion(descripcion);
        producto.setVendedor(this.usuarioFacade.find(new Integer(vendedor)));
        producto.setPrecio(Float.parseFloat(precio));
        producto.setCategoria(this.subcategoriaFacade.find(new Integer(subcategoria)));
        producto.setFecha(new Date());
        producto.setHora(new Date());
        producto.setFoto(foto);
        producto.setValoracionmedia(Float.parseFloat("-1"));                       

        if (esCrearNuevo) {
            this.productoFacade.create(producto);
        } else {
            this.productoFacade.edit(producto);
        }                
    }
}
