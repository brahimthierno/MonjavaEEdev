<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.modele.Entreprise, java.text.SimpleDateFormat" %>
<%
// Vérifiez si l'utilisateur est connecté
if(session.getAttribute("user") == null) {
    response.sendRedirect("index.jsp");
    return;
}

Entreprise entreprise = (Entreprise) request.getAttribute("entreprise");
boolean isEdit = (entreprise != null);
String formAction = isEdit ? "entreprise?action=update" : "entreprise?action=create";
String pageTitle = isEdit ? "Modifier une Entreprise" : "Ajouter une Entreprise";

String nom = "";
String adresse = "";
double chiffreAffaire = 0.0;
String dateCreation = "";

if(isEdit) {
    nom = entreprise.getNom();
    adresse = entreprise.getAdresse();
    chiffreAffaire = entreprise.getChiffreAffaire();
    dateCreation = new SimpleDateFormat("yyyy-MM-dd").format(entreprise.getDateCreation());
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
                <li><a href="employe?action=list">Gestion des Employés</a></li>
                <li><a href="entreprise?action=list" class="active">Gestion des Entreprises</a></li>
            </ul>
        </nav>

        <main>
            <div class="form-container">
                <form action="<%= formAction %>" method="post">
                    <% if(isEdit) { %>
                        <input type="hidden" name="id" value="<%= entreprise.getId() %>">
                    <% } %>

                    <div class="form-group">
                        <label for="nom">Nom:</label>
                        <input type="text" id="nom" name="nom" value="<%= nom %>" required>
                    </div>

                    <div class="form-group">
                        <label for="adresse">Adresse:</label>
                        <input type="text" id="adresse" name="adresse" value="<%= adresse %>" required>
                    </div>

                    <div class="form-group">
                        <label for="chiffreAffaire">Chiffre d'Affaire:</label>
                        <input type="number" id="chiffreAffaire" name="chiffreAffaire" value="<%= chiffreAffaire %>" step="0.01" required>
                    </div>

                    <div class="form-group">
                        <label for="dateCreation">Date de Création:</label>
                        <input type="date" id="dateCreation" name="dateCreation" value="<%= dateCreation %>" required>
                    </div>

                    <div class="form-buttons">
                        <button type="submit"><%= isEdit ? "Mettre à jour" : "Ajouter" %></button>
                        <a href="entreprise?action=list" class="btn-cancel">Annuler</a>
                    </div>
                </form>
            </div>
        </main>
    </div>
</body>
</html>