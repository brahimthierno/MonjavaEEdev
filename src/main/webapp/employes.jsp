<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.modele.Employe, , java.util.List, java.util.ArrayList, java.text.SimpleDateFormat" %>
<%@ page import="com.modele.Entreprise" %>


<%
    // Vérification de la session utilisateur
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // Récupération de la liste des employés
    List<Employe> employes = (List<Employe>) request.getAttribute("employes");
    if (employes == null) {
        employes = new ArrayList<>();
    }
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Employés</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="dashboard-container">
        <header>
            <h1>Gestion des Employés</h1>
            <div class="user-info">
                Bienvenue, <%= session.getAttribute("user") %> | <a href="logout.jsp">Déconnexion</a>
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
            <% if(request.getAttribute("message") != null) { %>
                <div class="message">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>
            
            <div class="action-buttons">
                <a href="employe?action=new" class="btn-add">Ajouter un Employé</a>
            </div>

            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Matricule</th>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Fonction</th>
                            <th>Service</th>
                            <th>Date d'Embauche</th>
                            <th>Sexe</th>
                            <th>Salaire de Base</th>
                            <th>Entreprise</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (!employes.isEmpty()) { %>
                            <% for (Employe emp : employes) { %>
                                <tr>
                                    <td><%= emp.getMatricule() != null ? emp.getMatricule() : "N/A" %></td>
                                    <td><%= emp.getNom() != null ? emp.getNom() : "N/A" %></td>
                                    <td><%= emp.getPrenom() != null ? emp.getPrenom() : "N/A" %></td>
                                    <td><%= emp.getFonction() != null ? emp.getFonction() : "N/A" %></td>
                                    <td><%= emp.getService() != null ? emp.getService() : "N/A" %></td>
                                    <td><%= emp.getDateEmbauche() != null ? dateFormat.format(emp.getDateEmbauche()) : "N/A" %></td>
                                    <td><%= "M".equals(emp.getSexe()) ? "Masculin" : "Féminin" %></td>
                                    <td class="text-right"><%= emp.getSalaireBase() > 0 ? String.format("%.2f", emp.getSalaireBase()) : "N/A" %></td>
                                    <td><%= emp.getEntreprise() != null ? emp.getEntreprise().getNom() : "N/A" %></td>
                                    <td class="actions">
                                        <a href="employe?action=edit&matricule=<%= emp.getMatricule() %>" class="btn-edit">Modifier</a>
                                        <a href="javascript:void(0);" 
                                           onclick="confirmerSuppression('<%= emp.getMatricule() %>', '<%= emp.getNom() %> <%= emp.getPrenom() %>')" 
                                           class="btn-delete">Supprimer</a>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="10" class="no-data">Aucun employé trouvé</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </main>
        
        <footer>
            <p>&copy; <%= new SimpleDateFormat("yyyy").format(new java.util.Date()) %> - Système de Gestion des Employés</p>
        </footer>
    </div>
    
    <script>
        function confirmerSuppression(matricule, nom) {
            if (confirm('Êtes-vous sûr de vouloir supprimer l\'employé ' + nom + ' ?')) {
                window.location.href = 'employe?action=delete&matricule=' + matricule;
            }
        }
    </script>
</body>
</html>
