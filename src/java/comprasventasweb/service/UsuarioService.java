/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comprasventasweb.service;

import comprasventasweb.dao.UsuarioFacade;
import comprasventasweb.dto.UsuarioDTO;
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
}
