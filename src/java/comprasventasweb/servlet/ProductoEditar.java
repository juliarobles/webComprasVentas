/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comprasventasweb.servlet;

import comprasventasweb.service.ProductoService;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "ProductoEditar", urlPatterns = {"/ProductoEditar"})
public class ProductoEditar extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(ProductoEditar.class.getName());
    
    @EJB
    private ProductoService productoService;
    
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
        /*
        HttpSession session = request.getSession();
        
        if (session.getAttribute("usuario")==null) { // Se ha llamado al servlet sin haberse autenticado
            response.sendRedirect("login.jsp");            
        } else {        
            String str = request.getParameter("id");
            if (str == null) {
                LOG.log(Level.SEVERE, "No se ha encontrado el producto a editar");
                response.sendRedirect("menu.jsp");            
            } else {
                ProductoBasicoDTO = this.productoService.searchById(str);
                if (cliente == null) { //Esta situación no debería darse
                    LOG.log(Level.SEVERE, "No se ha encontrado el cliente a editar");
                    response.sendRedirect("menu.jsp");
                } else {
                    List<MicroMarketDTO> listaSupermercados = this.supermercadosService.searchAll();
                    List<DiscountCodeDTO> listaDescuentos = this.codigosDescuentoService.searchAll();
                    
                    request.setAttribute("cliente", cliente);
                    request.setAttribute("listaSupermercados", listaSupermercados);
                    request.setAttribute("listaDescuentos", listaDescuentos);
                    
                    RequestDispatcher rd = request.getRequestDispatcher("cliente.jsp");
                    rd.forward(request, response);
                }       
            }
        }
        */
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
