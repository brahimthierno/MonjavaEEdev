package com.servlets;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.EntrepriseDAO;
import com.modele.Entreprise;

public class EntrepriseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private EntrepriseDAO entrepriseDAO = new EntrepriseDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteEntreprise(request, response);
                break;
            default:
                listEntreprises(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "create":
                createEntreprise(request, response);
                break;
            case "update":
                updateEntreprise(request, response);
                break;
            default:
                listEntreprises(request, response);
                break;
        }
    }
    
    private void listEntreprises(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Entreprise> entreprises = entrepriseDAO.getAllEntreprises();
        request.setAttribute("entreprises", entreprises);
        request.getRequestDispatcher("entreprises.jsp").forward(request, response);
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("entreprise-form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Entreprise entreprise = getEntrepriseById(id); // Vous devez implémenter cette méthode dans DAO
        request.setAttribute("entreprise", entreprise);
        request.getRequestDispatcher("entreprise-form.jsp").forward(request, response);
    }
    
    private void createEntreprise(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String nom = request.getParameter("nom");
        String adresse = request.getParameter("adresse");
        double chiffreAffaire = Double.parseDouble(request.getParameter("chiffreAffaire"));
        String dateCreationStr = request.getParameter("dateCreation");
        
        Date dateCreation = null;
        try {
            dateCreation = new SimpleDateFormat("yyyy-MM-dd").parse(dateCreationStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        Entreprise entreprise = new Entreprise();
        entreprise.setNom(nom);
        entreprise.setAdresse(adresse);
        entreprise.setChiffreAffaire(chiffreAffaire);
        entreprise.setDateCreation(dateCreation);
        
        entrepriseDAO.creerEntreprise(entreprise);
        response.sendRedirect("entreprise?action=list");
    }
    
    private void updateEntreprise(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String adresse = request.getParameter("adresse");
        double chiffreAffaire = Double.parseDouble(request.getParameter("chiffreAffaire"));
        String dateCreationStr = request.getParameter("dateCreation");
        
        Date dateCreation = null;
        try {
            dateCreation = new SimpleDateFormat("yyyy-MM-dd").parse(dateCreationStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        Entreprise entreprise = new Entreprise(id, nom, adresse, chiffreAffaire, dateCreation);
        
        // Appelez une méthode de mise à jour dans DAO
        updateEntreprise(entreprise); // Vous devez implémenter cette méthode dans DAO
        response.sendRedirect("entreprise?action=list");
    }
    
    private void deleteEntreprise(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        // Appelez une méthode de suppression dans DAO
        deleteEntreprise(id); // Vous devez implémenter cette méthode dans DAO
        response.sendRedirect("entreprise?action=list");
    }
    
    // Méthodes fictives (à implémenter dans DAO)
    private Entreprise getEntrepriseById(int id) {
        // Cette méthode devrait être implémentée dans EntrepriseDAO
        return null;
    }
    
    private void updateEntreprise(Entreprise entreprise) {
        // Cette méthode devrait être implémentée dans EntrepriseDAO
    }
    
    private void deleteEntreprise(int id) {
        // Cette méthode devrait être implémentée dans EntrepriseDAO
    }
}