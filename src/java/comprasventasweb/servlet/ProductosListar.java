/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comprasventasweb.servlet;

import comprasventasweb.dto.ProductoBasicoDTO;
import comprasventasweb.dto.ProductoDTO;
import comprasventasweb.dto.UsuarioDTO;
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
        
        usuario = (UsuarioDTO)session.getAttribute("usuario");
        if (usuario == null) { 
            response.sendRedirect("login.jsp");
        } else {
            RequestDispatcher rd;
            if (usuario.getAdministrador()){
                List<ProductoDTO> listaProductos = this.productoServices.searchAllInverso2();                       
                request.setAttribute("listaProductos", listaProductos);
                rd = request.getRequestDispatcher("productosAdmin.jsp");
            } else {                        
                List<ProductoBasicoDTO> listaProductos = this.productoServices.searchAllInverso();                       
                request.setAttribute("listaProductos", listaProductos);
                rd = request.getRequestDispatcher("paginaPrincipal.jsp");  
            }
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
