/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comprasventasweb.service;

import comprasventasweb.dao.UsuarioFacade;
import comprasventasweb.dto.UsuarioDTO;
import comprasventasweb.entity.Usuario;
import javax.ejb.EJB;
import javax.ejb.Stateless;

/**
 *
 * @author Usuario
 */

@Stateless
public class UsuarioService {
    
    @EJB
    private UsuarioFacade usuarioFacade; 
    
    public UsuarioDTO searchByUserId(Integer id){
        return this.usuarioFacade.find(id).getDTO();
    }
    
    public UsuarioDTO buscarPorCorreo(String user){
        return this.usuarioFacade.buscarPorCorreo(user).getDTO();
    }

    public UsuarioDTO buscarPorUsuario(String usuario) {//To do
        return this.usuarioFacade.buscarPorUsuario(usuario).getDTO();
    }

    public void create(String usuario, String correo, String nombre, String pass, boolean b) {    
        //Actualizar cuando se pueda y si es necesario a createOrUpdate
        Usuario user;
        user = new Usuario(0);
        
        user.setAdministrador(b);
        user.setUsuario(usuario);
        user.setEmail(correo);
        user.setNombre(nombre);
        user.setPassword(pass);
        
        this.usuarioFacade.create(user);
        
    }

  
    
    
}
