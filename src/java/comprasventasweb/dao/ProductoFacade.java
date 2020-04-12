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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
    
    public List<Producto> findByTituloDescripcion(String search) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByTituloDescripcion");
        q.setParameter("titulo", "%"+search+"%");
            
        return q.getResultList();
    }
    
    public List<Producto> findByTitulo(String search) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByTitulo");
        q.setParameter("titulo", "%"+search+"%");
            
        return q.getResultList();
    }
    
    public List<Producto> findByDescripcion(String search) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByDescripcion");
        q.setParameter("descripcion", "%"+search+"%");
            
        return q.getResultList();
    }
    
    public List<Producto> findByFecha(String search) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByFecha");
        Date date; 
        try {
            date = new SimpleDateFormat("dd/MM/yyyy").parse(search);
            q.setParameter("fecha", date);
        } catch (ParseException ex) {
            Logger.getLogger(ProductoFacade.class.getName()).log(Level.SEVERE, null, ex);
        }
        return q.getResultList();
        
    }
    
    public List<Producto> findByHora(String search) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByFecha");
        Date date; 
        try {
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");  
            LocalDateTime now = LocalDateTime.now();
            String nueva = dtf.format(now)+" "+search;
            date = new SimpleDateFormat("dd/MM/yyyy kk:mm").parse(nueva);
            q.setParameter("fecha", date);
        } catch (ParseException ex) {
            Logger.getLogger(ProductoFacade.class.getName()).log(Level.SEVERE, null, ex);
        }
        return q.getResultList();
        
    }
    
    public List<Producto> findByFechaHora(String search) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByFecha");
        Date date; 
        try {
            date = new SimpleDateFormat("dd/MM/yyyy kk:mm").parse(search);
            q.setParameter("fecha", date);
        } catch (ParseException ex) {
            Logger.getLogger(ProductoFacade.class.getName()).log(Level.SEVERE, null, ex);
        }
        return q.getResultList();
        
    }
    
    public List<Producto> findByFechaEntre(String inicio, String end) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByFechaEntre");
        Date date;
        Date date2; 
        try {
            date = new SimpleDateFormat("dd/MM/yyyy").parse(inicio);
            date2 = new SimpleDateFormat("dd/MM/yyyy").parse(end);
            q.setParameter("inicio", date);
            q.setParameter("end", date2);
            
        } catch (ParseException ex) {
            Logger.getLogger(ProductoFacade.class.getName()).log(Level.SEVERE, null, ex);
        }
        return q.getResultList();
        
    }
    
    public List<Producto> findByHoraEntre(String inicio, String end) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByFechaEntre");
        Date date;
        Date date2; 
        try {
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");  
            LocalDateTime now = LocalDateTime.now();
            String nueva1 = dtf.format(now)+" "+inicio;
            String nueva2 = dtf.format(now)+" "+end;
            date = new SimpleDateFormat("dd/MM/yyyy kk:mm").parse(nueva1);
            date2 = new SimpleDateFormat("dd/MM/yyyy kk:mm").parse(nueva2);
            q.setParameter("inicio", date);
            q.setParameter("end", date2);
            
        } catch (ParseException ex) {
            Logger.getLogger(ProductoFacade.class.getName()).log(Level.SEVERE, null, ex);
        }
        return q.getResultList();
        
    }
    
    public List<Producto> findByFechaHoraEntre(String inicio, String end) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByFechaEntre");
        Date date;
        Date date2; 
        try {
            date = new SimpleDateFormat("dd/MM/yyyy kk:mm").parse(inicio);
            date2 = new SimpleDateFormat("dd/MM/yyyy kk:mm").parse(end);
            q.setParameter("inicio", date);
            q.setParameter("end", date2);
            
        } catch (ParseException ex) {
            Logger.getLogger(ProductoFacade.class.getName()).log(Level.SEVERE, null, ex);
        }
        return q.getResultList();
        
    }
    
    
    public List<Producto> findByEtiquetas(String search) {        
        
        Query q = this.getEntityManager().createNamedQuery("Producto.findByEtiquetas");
        q.setParameter("etiqueta", search);
        //System.out.println(q.getResultList()); //Para ver si devulve algo   
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
