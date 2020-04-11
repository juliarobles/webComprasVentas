/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comprasventasweb.dao;

import comprasventasweb.entity.Categoria;
import comprasventasweb.entity.Etiqueta;
import comprasventasweb.entity.Producto;
import comprasventasweb.entity.Subcategoria;
import comprasventasweb.entity.Usuario;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Usuario
 */
@Stateless
public class ProductoFacade extends AbstractFacade<Producto> {

    @PersistenceContext(unitName = "ProyWebComprasVentasPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ProductoFacade() {
        super(Producto.class);
    }
    
    public List<Producto> findByUserId(Usuario user) {        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByVendedor");
        q.setParameter("user", user);
        
        return q.getResultList();
    }
    
    public List<Producto> findByKeywords(String search) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByKeywords");
        q.setParameter("titulo", "%"+search+"%");
            
        return q.getResultList();
    }
    
    public List<Producto> findByEtiquetas(String search) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByEtiquetas");
        q.setParameter("etiqueta", "%"+search+"%");
        System.out.println(q.getResultList()); //Para ver si devulve algo   
        return q.getResultList();
    }
    
    public List<Producto> findAllInverso(){
       Query q = this.getEntityManager().createNamedQuery("Producto.findAllInverso");
       return q.getResultList(); 
    }
    
    public void vaciarEtiquetas(Producto producto) {
         EntityManager em = this.getEntityManager();
         producto.setEtiquetaList(new ArrayList<>());
         em.persist(producto);
    }
    
    public List<Producto> findBySubcategory(Subcategoria id) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findBySubcategory");
        q.setParameter("id", id);
            
        return q.getResultList();
    }
    
    public List<Producto> findByCategory(Categoria id) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByCategory");
        q.setParameter("id", id);
            
        return q.getResultList();
    }
    
}
