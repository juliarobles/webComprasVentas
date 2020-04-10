/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comprasventasweb.servlet;

import comprasventasweb.dto.CategoriaDTO;
import comprasventasweb.dto.ProductoBasicoDTO;
import comprasventasweb.dto.ProductoDTO;
import comprasventasweb.dto.UsuarioDTO;
import comprasventasweb.service.CategoriaService;
import comprasventasweb.service.ProductoService;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Usuario
 */



@WebServlet(name = "ProductosListar", urlPatterns = {"/ProductosListar"})
public class ProductosListar extends HttpServlet {

    @EJB
    private ProductoService productoServices;
    
    @EJB
    private CategoriaService categoriaService;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UsuarioDTO usuario;
        RequestDispatcher rd;
        
        String search = (String)request.getParameter("busqueda");
        String searchEtiquetas = (String)request.getParameter("busquedaEtiquetas");
        String categoria = (String) request.getParameter("categoria");
        if(categoria == ""){
            categoria = null;
        }
        
        usuario = (UsuarioDTO)session.getAttribute("usuario");
        if (usuario == null) { 
            response.sendRedirect("login.jsp");
            
        } else if (usuario.getAdministrador()){
            List<ProductoDTO> listaProductos = this.productoServices.searchAllInverso2();                       
            request.setAttribute("listaProductos", listaProductos);
            rd = request.getRequestDispatcher("productosAdmin.jsp");
            rd.forward(request, response);
            
        }else {
            
            List<ProductoBasicoDTO> listaProductos;
            
            if(search == null && searchEtiquetas == null && categoria == null){                          
                listaProductos = this.productoServices.searchAllInverso();                       
                            
            }else if(searchEtiquetas == null && categoria == null){
                String[] words = search.split(" ");
                listaProductos = this.productoServices.searchByKeywords(words[0]);
                for(int i=1; i<words.length; i++){
                    //System.out.println(word);
                    List<ProductoBasicoDTO> listaWord = this.productoServices.searchByKeywords(words[i]);
                    for (ProductoBasicoDTO p : listaWord) {   
                        listaProductos.add(p);
                    }
                }
                
            } else if (searchEtiquetas == null){
                int id = Integer.parseInt(categoria.substring(1, categoria.length()));
                if(categoria.charAt(0) == 'B'){
                    listaProductos = this.productoServices.searchBySubcategory(id);
                    request.setAttribute("subcategoria", id+"");
                }else{
                    listaProductos = this.productoServices.searchByCategory(id);
                    request.setAttribute("categoria", id+"");
                }
                
            }else{
                String[] words = searchEtiquetas.split(" ");
                listaProductos = this.productoServices.searchByEtiquetas(words[0]);
                for(int i=1; i<words.length; i++){
                    //System.out.println(word);
                    List<ProductoBasicoDTO> listaWord = this.productoServices.searchByEtiquetas(words[i]);
                    for (ProductoBasicoDTO p : listaWord) {   
                        listaProductos.add(p);
                    }
                }
            }
            
            List<CategoriaDTO> categorias = this.categoriaService.searchAll(); 
            request.setAttribute("listaCategorias", categorias);
            
            request.setAttribute("listaProductos", listaProductos);
            rd = request.getRequestDispatcher("paginaPrincipal.jsp");
            rd.forward(request, response);
        }
        
            
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
