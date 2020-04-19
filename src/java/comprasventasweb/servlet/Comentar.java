/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comprasventasweb.servlet;

import comprasventasweb.dao.ComentarioFacade;
import comprasventasweb.dto.ProductoDTO;
import comprasventasweb.dto.UsuarioDTO;
import comprasventasweb.entity.Producto;
import comprasventasweb.entity.Usuario;
import comprasventasweb.service.ComentarioService;
import java.io.IOException;
import java.io.PrintWriter;
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
 * @author danim
 */
@WebServlet(name = "Comentar", urlPatterns = {"/Comentar"})
public class Comentar extends HttpServlet {
        
        
    @EJB
    private ComentarioService comentarioService;
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
       System.out.println("He entrado al servlet de comentar");
       
       HttpSession sesion = request.getSession();
       //Hacer siempre para comprobar el usuario
       if(sesion.getAttribute("usuario")==null){
           response.sendRedirect("login.jsp");
       }
       //Saco los parámetros del comentario
  
       ProductoDTO pr = (ProductoDTO)sesion.getAttribute("producto");
       UsuarioDTO usu = (UsuarioDTO)sesion.getAttribute("usuario");
       String contenido = request.getParameter("comentario");
       
       
       this.comentarioService.comentario(pr, usu, contenido);
       
       System.out.println(pr.getTitulo()+ " " + usu.getUsuario() + " " + contenido);
       
      
       RequestDispatcher rd = request.getRequestDispatcher("VerProducto?id=" + pr.getId());
       rd.forward(request, response);
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
