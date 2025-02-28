<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.modele.Employe, com.dao.EntrepriseDAO, com.modele.Entreprise, java.util.List, java.text.SimpleDateFormat" %>
<%
    // Vérifiez si l'utilisateur est connecté
    if(session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // Utilisez try-catch pour gérer les exceptions potentielles
    EntrepriseDAO entrepriseDAO = new EntrepriseDAO();
    List<Entreprise> entreprises = null;
    try {
        entreprises = entrepriseDAO.getAllEntreprises();
    } catch (Exception e) {
        request.setAttribute("errorMessage", "Erreur lors de la récupération des entreprises: " + e.getMessage());
        // Rediriger vers une page d'erreur ou gérer autrement
    }
    
    Employe employe = (Employe) request.getAttribute("employe");
    boolean isEdit = (employe != null);
    String formAction = isEdit ? "employe?action=update" : "employe?action=create";
    String pageTitle = isEdit ? "Modifier un Employé" : "Ajouter un Employé";
    
    String matricule = "";
    String nom = "";
    String prenom = "";
    String fonction = "";
    String service = "";
    String dateEmbauche = "";
    String sexe = "";
    double salaireBase = 0.0;
    int entrepriseId = 0;
    
    if(isEdit) {
        matricule = employe.getMatricule() != null ? employe.getMatricule() : "";
        nom = employe.getNom() != null ? employe.getNom() : "";
        prenom = employe.getPrenom() != null ? employe.getPrenom() : "";
        fonction = employe.getFonction() != null ? employe.getFonction() : "";
        service = employe.getService() != null ? employe.getService() : "";
        if (employe.getDateEmbauche() != null) {
            dateEmbauche = new SimpleDateFormat("yyyy-MM-dd").format(employe.getDateEmbauche());
        }
        sexe = employe.getSexe() != null ? employe.getSexe() : "";
        salaireBase = employe.getSalaireBase();
        entrepriseId = employe.getEntrepriseId();
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle %></title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="dashboard-container">
        <header>
            <h1><%= pageTitle %></h1>
            <div class="user-info">
                Bienvenue, <%= session.getAttribute("user") %> | <a href="logout">Déconnexion</a>
            </div>
        </header>
        
        <nav>
            <ul>
                <li><a href="dashboard.jsp">Tableau de Bord</a></li>
                <li><a href="employe?action=list" class="active">Gestion des Employés</a></li>
                <li><a href="entreprise?action=list">Gestion des Entreprises</a></li>
            </ul>
        </nav>
        
        <main>
            <% if(request.getAttribute("errorMessage") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>
            
            <% if(request.getAttribute("successMessage") != null) { %>
                <div class="success-message">
                    <%= request.getAttribute("successMessage") %>
                </div>
            <% } %>
            
            <div class="form-container">
                <form action="<%= formAction %>" method="post" id="employeForm">
                    <div class="form-group">
                        <label for="matricule">Matricule:</label>
                        <input type="text" id="matricule" name="matricule" value="<%= matricule %>" <%= isEdit ? "readonly" : "" %> required>
                    </div>
                    
                    <div class="form-group">
                        <label for="nom">Nom:</label>
                        <input type="text" id="nom" name="nom" value="<%= nom %>" required maxlength="50">
                    </div>
                    
                    <div class="form-group">
                        <label for="prenom">Prénom:</label>
                        <input type="text" id="prenom" name="prenom" value="<%= prenom %>" required maxlength="50">
                    </div>
                    
                    <div class="form-group">
                        <label for="fonction">Fonction:</label>
                        <input type="text" id="fonction" name="fonction" value="<%= fonction %>" required maxlength="50">
                    </div>
                    
                    <div class="form-group">
                        <label for="service">Service:</label>
                        <input type="text" id="service" name="service" value="<%= service %>" required maxlength="50">
                    </div>
                    
                    <div class="form-group">
                        <label for="dateEmbauche">Date d'Embauche:</label>
                        <input type="date" id="dateEmbauche" name="dateEmbauche" value="<%= dateEmbauche %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="sexe">Sexe:</label>
                        <select id="sexe" name="sexe" required>
                            <option value="">Sélectionnez</option>
                            <option value="M" <%= "M".equals(sexe) ? "selected" : "" %>>Masculin</option>
                            <option value="F" <%= "F".equals(sexe) ? "selected" : "" %>>Féminin</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="salaireBase">Salaire de Base:</label>
                        <input type="number" id="salaireBase" name="salaireBase" value="<%= salaireBase %>" step="0.01" min="0" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="entrepriseId">Entreprise:</label>
                        <select id="entrepriseId" name="entrepriseId" required>
                            <option value="">Sélectionnez une entreprise</option>
                            <% if(entreprises != null) { %>
                                <% for(Entreprise ent : entreprises) { %>
                                    <option value="<%= ent.getId() %>" <%= ent.getId() == entrepriseId ? "selected" : "" %>>
                                        <%= ent.getNom() %>
                                    </option>
                                <% } %>
                            <% } %>
                        </select>
                    </div>
                    
                    <div class="form-buttons">
                        <button type="submit"><%= isEdit ? "Mettre à jour" : "Ajouter" %></button>
                        <a href="employe?action=list" class="btn-cancel">Annuler</a>
                    </div>
                </form>
            </div>
        </main>
        <footer>
            <p>&copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> - Système de Gestion des Employés</p>
        </footer>
    </div>
    
    <script>
        document.getElementById('employeForm').addEventListener('submit', function(e) {
            // Validation côté client simple
            var nom = document.getElementById('nom').value.trim();
            var prenom = document.getElementById('prenom').value.trim();
            var salaireBase = document.getElementById('salaireBase').value;
            
            if(nom === '' || prenom === '') {
                e.preventDefault();
                alert('Veuillez remplir tous les champs obligatoires.');
                return false;
            }
            
            if(parseFloat(salaireBase) < 0) {
                e.preventDefault();
                alert('Le salaire ne peut pas être négatif.');
                return false;
            }
            
            return true;
        });
    </script>
</body>
</html>