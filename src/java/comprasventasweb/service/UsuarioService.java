/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comprasventasweb.service;

import comprasventasweb.dao.UsuarioFacade;
import comprasventasweb.dto.UsuarioDTO;
import comprasventasweb.entity.Usuario;
import java.util.ArrayList;
import java.util.List;
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
    
    protected List<UsuarioDTO> convertToDTO (List<Usuario> listaUsuarios){
       List<UsuarioDTO> listaDTO = null;
        if (listaUsuarios != null) {
            listaDTO = new ArrayList<>();
            for (Usuario a : listaUsuarios) {
                listaDTO.add(a.getDTO());
            }
        }
        return listaDTO; 
    }
    
    public List<UsuarioDTO> searchAll() {
        List<Usuario> listaUsuarios = this.usuarioFacade.findAll();
        return this.convertToDTO(listaUsuarios);//To change body of generated methods, choose Tools | Templates.
    }
    
    public UsuarioDTO searchByUserId(Integer id){
        return this.usuarioFacade.find(id).getDTO();
    }
    
    public UsuarioDTO buscarPorCorreo(String user){
        
        Usuario usu = this.usuarioFacade.buscarPorCorreo(user);
        if(usu != null){
            return usu.getDTO();
        }else{
            return null;
        }
    }

    public UsuarioDTO buscarPorUsuario(String usuario) {//To do
         
        Usuario usu = this.usuarioFacade.buscarPorUsuario(usuario);
        if(usu != null){
            return usu.getDTO();
        }else{
            return null;
        }
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
        user.setFoto("");
        this.usuarioFacade.create(user);
        
    }

    public void createOrUpdate (Integer id, String usuario, String email, String nombre, String password, Boolean administador,
                                String foto) {
        Usuario usuarioMod;
        boolean esCrearNuevo = false;
        
        if (id == null) { // Estamos en el caso de creación de un nuevo cliente
            usuarioMod = new Usuario(0); // Aunque el id es autoincremental, hay ocasiones en las que
                                       // si no se le da un valor por defecto, da un error al guardarlo.
            esCrearNuevo = true;
        } else {
            usuarioMod = this.usuarioFacade.find(id);
        }

        
        usuarioMod.setId(id);
        usuarioMod.setUsuario(usuario);
        usuarioMod.setEmail(email);
        usuarioMod.setNombre(nombre);
        usuarioMod.setPassword(password);
        usuarioMod.setAdministrador(administador);
        usuarioMod.setFoto(foto);
        
        if (esCrearNuevo) {
            this.usuarioFacade.create(usuarioMod);
        } else {
            this.usuarioFacade.edit(usuarioMod);
        } 
      
    }
  
}
