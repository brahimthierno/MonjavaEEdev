package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import com.modele.Employe;

public class EmployeDAO {
    
    // Créer un employé
    public boolean creerEmploye(Employe employe) {
        String query = "INSERT INTO employe (matricule, nom, prenom, fonction, service, dateEmbauche, sexe, salaireBase, entreprise_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, employe.getMatricule());
            ps.setString(2, employe.getNom());
            ps.setString(3, employe.getPrenom());
            ps.setString(4, employe.getFonction());
            ps.setString(5, employe.getService());
            ps.setDate(6, new java.sql.Date(employe.getDateEmbauche().getTime()));
            ps.setString(7, employe.getSexe());
            ps.setDouble(8, employe.getSalaireBase());
            ps.setInt(9, employe.getEntrepriseId());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Obtenir tous les employés
    public List<Employe> getAllEmployes() {
        List<Employe> employes = new ArrayList<>();
        String query = "SELECT * FROM employe";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Employe emp = new Employe();
                emp.setMatricule(rs.getString("matricule"));
                emp.setNom(rs.getString("nom"));
                emp.setPrenom(rs.getString("prenom"));
                emp.setFonction(rs.getString("fonction"));
                emp.setService(rs.getString("service"));
                emp.setDateEmbauche(rs.getDate("dateEmbauche"));
                emp.setSexe(rs.getString("sexe"));
                emp.setSalaireBase(rs.getDouble("salaireBase"));
                emp.setEntrepriseId(rs.getInt("entreprise_id"));
                
                employes.add(emp);
            }
            
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }
        
        return employes;
    }
    
    // Obtenez un employé par matricule
    public Employe getEmployeByMatricule(String matricule) {
        String query = "SELECT * FROM employe WHERE matricule = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, matricule);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Employe emp = new Employe();
                    emp.setMatricule(rs.getString("matricule"));
                    emp.setNom(rs.getString("nom"));
                    emp.setPrenom(rs.getString("prenom"));
                    emp.setFonction(rs.getString("fonction"));
                    emp.setService(rs.getString("service"));
                    emp.setDateEmbauche(rs.getDate("dateEmbauche"));
                    emp.setSexe(rs.getString("sexe"));
                    emp.setSalaireBase(rs.getDouble("salaireBase"));
                    emp.setEntrepriseId(rs.getInt("entreprise_id"));
                    
                    return emp;
                }
            }
            
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Méthodes pour mettre à jour et supprimer des employés
    // ...
}