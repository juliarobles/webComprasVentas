/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
    */
package comprasventasweb.service;

import comprasventasweb.dao.EtiquetaFacade;
import comprasventasweb.dao.ProductoFacade;
import comprasventasweb.dao.SubcategoriaFacade;
import comprasventasweb.dao.UsuarioFacade;
import comprasventasweb.dto.ProductoBasicoDTO;
import comprasventasweb.dto.ProductoDTO;
import comprasventasweb.dto.UsuarioDTO;
import comprasventasweb.entity.Etiqueta;
import comprasventasweb.entity.Producto;
import comprasventasweb.entity.Subcategoria;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;

/**
 *
 * @author Usuario
 */
@Stateless
public class ProductoService {
    
    private static final Logger LOG = Logger.getLogger(ProductoService.class.getName());
    
    @EJB
    private ProductoFacade productoFacade;
    
    @EJB
    private UsuarioFacade usuarioFacade;
    
    @EJB
    private SubcategoriaFacade subcategoriaFacade;
    
    @EJB
    private EtiquetaFacade etiquetaFacade;
    
    @EJB
    private EtiquetaService etiquetaService;
    
    
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
    
    public List<ProductoBasicoDTO> searchAllInverso () {
        List<Producto> listaProductos = this.productoFacade.findAllInverso();
        return this.convertToDTO(listaProductos);
    }
    
    public void createOrUpdate (String id, String vendedor, String titulo, String descripcion, String precio, String subcategoria,
                                String foto, String etiquetas) {
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
        producto.setPrecio(Float.parseFloat(precio));
        producto.setCategoria(this.subcategoriaFacade.find(new Integer(subcategoria)));
        producto.setFoto(foto);
     
        if(esCrearNuevo){
            producto.setEtiquetaList(new ArrayList<>());
            producto.setVendedor(this.usuarioFacade.find(new Integer(vendedor)));
            producto.setFecha(new Date());
            producto.setHora(new Date());
            producto.setValoracionmedia(Float.parseFloat("-1"));
        }
        
        if (esCrearNuevo) {
            this.productoFacade.create(producto);
        } else {
            this.productoFacade.edit(producto);
        } 
        
        if(!esCrearNuevo){
           this.vaciarEtiquetas(producto);
        }
        
        if(etiquetas != null || etiquetas.equals("")){
           String[] split = etiquetas.split("#");
            for(int i = 0; i < split.length; i++){
                String s = split[i];

                while(s != null && s.length() >= 1 && s.charAt(s.length()-1) == ' '){
                    s = s.substring(0, s.length()-1);
                }

                if(s != null && s.length() >= 1){
                    this.etiquetaFacade.createOrUpdate(s, producto);
                }
            } 
        }
        
        
    }

    public List<ProductoBasicoDTO> searchByUser(UsuarioDTO user) {
        List<Producto> listaProductos = this.productoFacade.findByUserId(this.usuarioFacade.find(user.getId()));
        return this.convertToDTO(listaProductos);
    }
    
    public List<ProductoBasicoDTO> searchByKeywords(String search) {
        List<Producto> listaProductos = this.productoFacade.findByKeywords(search);
        return this.convertToDTO(listaProductos);
    }
    
    public ProductoDTO searchById(String str){
        
        Producto producto = this.productoFacade.find(new Integer(str));
        if (producto != null) {
            return producto.getDTO();
        } else {
            return null;
        }
    }
    
    protected void vaciarEtiquetas(Producto producto) {
        for(Etiqueta et : producto.getEtiquetaList()){
            this.etiquetaFacade.removeProducto(et, producto);
            if(et.getProductoList().isEmpty()){
                this.etiquetaService.remove(et.getNombre());
            }
        }
        this.productoFacade.vaciarEtiquetas(producto);
    }
    
    // Este método devuelve false si no se ha realizado el borrado.
    public boolean remove (String productId) {     
        
        // Busco al cliente a través de su clave primaria.
        // Como la clave primaria de la entidad Customer es de tipo Integer, 
        // tengo que hacer la transformación en la llamada a "find".        
        Producto producto = this.productoFacade.find(new Integer(productId));
        if (producto == null) { //Esta situación no debería darse
            LOG.log(Level.SEVERE, "No se ha encontrado el cliente a borrar");
            return false;
        } else {
            this.productoFacade.remove(producto);
            return true;
        }
    }
}
