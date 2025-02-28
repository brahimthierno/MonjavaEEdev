<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.modele.Entreprise, java.util.List, java.text.SimpleDateFormat" %>
<%
// Vérifiez si l'utilisateur est connecté
if(session.getAttribute("user") == null) {
    response.sendRedirect("index.jsp");
    return;
}

List<Entreprise> entreprises = (List<Entreprise>) request.getAttribute("entreprises");
SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Entreprises</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="dashboard-container">
        <header>
            <h1>Gestion des Entreprises</h1>
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
            <div class="action-buttons">
                <a href="entreprise?action=new" class="btn-add">Ajouter une Entreprise</a>
            </div>

            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Adresse</th>
                        <th>Chiffre d'Affaire</th>
                        <th>Date de Création</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(entreprises != null && !entreprises.isEmpty()) { %>
                        <% for(Entreprise ent : entreprises) { %>
                            <tr>
                                <td><%= ent.getId() %></td>
                                <td><%= ent.getNom() %></td>
                                <td><%= ent.getAdresse() %></td>
                                <td><%= ent.getChiffreAffaire() %></td>
                                <td><%= dateFormat.format(ent.getDateCreation()) %></td>
                                <td>
                                    <a href="entreprise?action=edit&id=<%= ent.getId() %>" class="btn-edit">Modifier</a>
                                    <a href="entreprise?action=delete&id=<%= ent.getId() %>" class="btn-delete" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette entreprise? Cela supprimera également tous les employés associés.');">Supprimer</a>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="6">Aucune entreprise trouvée</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>