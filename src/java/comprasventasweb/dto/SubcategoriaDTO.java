/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comprasventasweb.dto;

/**
 *
 * @author Usuario
 */
public class SubcategoriaDTO {
    private Integer id;
    private String nombre;
    private CategoriaDTO categoriaPadre;

    public SubcategoriaDTO() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public CategoriaDTO getCategoriaPadre() {
        return categoriaPadre;
    }

    public void setCategoriaPadre(CategoriaDTO categoriaPadre) {
        this.categoriaPadre = categoriaPadre;
    }
    
    
    
}