<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Vérifiez si l'utilisateur est connecté
    if(session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard Admin</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="dashboard-container">
        <header>
            <h1>Tableau de bord - Gestion des Employés et Entreprises</h1>
            <div class="user-info">
                Bienvenue, <%= session.getAttribute("user") %> | <a href="logout">Déconnexion</a>
            </div>
        </header>
        
        <nav>
            <ul>
                <li><a href="employe?action=list">Gestion des Employés</a></li>
                <li><a href="entreprise?action=list">Gestion des Entreprises</a></li>
            </ul>
        </nav>
        
        <main>
            <div class="dashboard-summary">
                <h2>Bienvenue dans votre tableau de bord</h2>
                <p>Utilisez les liens de navigation pour gérer les employés et les entreprises.</p>
            </div>
        </main>
    </div>
</body>
</html>