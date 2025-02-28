package com.dao;

import com.modele.Entreprise;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

public class EntrepriseDAO {
    
    // Créer une entreprise
    public boolean creerEntreprise(Entreprise entreprise) {
        String query = "INSERT INTO entreprise (nom, adresse, chiffreAffaire, dateCreation) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, entreprise.getNom());
            ps.setString(2, entreprise.getAdresse());
            ps.setDouble(3, entreprise.getChiffreAffaire());
            ps.setDate(4, new java.sql.Date(entreprise.getDateCreation().getTime()));
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        entreprise.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Obtenir toutes les entreprises
    public List<Entreprise> getAllEntreprises() {
        List<Entreprise> entreprises = new ArrayList<>();
        String query = "SELECT * FROM entreprise";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Entreprise ent = new Entreprise();
                ent.setId(rs.getInt("id"));
                ent.setNom(rs.getString("nom"));
                ent.setAdresse(rs.getString("adresse"));
                ent.setChiffreAffaire(rs.getDouble("chiffreAffaire"));
                ent.setDateCreation(rs.getDate("dateCreation"));
                
                entreprises.add(ent);
            }
            
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }
        
        return entreprises;
    }
    
    // Méthodes pour mettre à jour et supprimer des entreprises
    // ...
 // Dans EntrepriseDAO.java

    public Entreprise getEntrepriseById(int id) {
        String query = "SELECT * FROM entreprise WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Entreprise ent = new Entreprise();
                    ent.setId(rs.getInt("id"));
                    ent.setNom(rs.getString("nom"));
                    ent.setAdresse(rs.getString("adresse"));
                    ent.setChiffreAffaire(rs.getDouble("chiffreAffaire"));
                    ent.setDateCreation(rs.getDate("dateCreation"));
                    
                    return ent;
                }
            }
            
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    public boolean updateEntreprise(Entreprise entreprise) {
        String query = "UPDATE entreprise SET nom = ?, adresse = ?, chiffreAffaire = ?, dateCreation = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, entreprise.getNom());
            ps.setString(2, entreprise.getAdresse());
            ps.setDouble(3, entreprise.getChiffreAffaire());
            ps.setDate(4, new java.sql.Date(entreprise.getDateCreation().getTime()));
            ps.setInt(5, entreprise.getId());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteEntreprise(int id) {
        // Note: Vous devriez d'abord supprimer tous les employés associés à cette entreprise
        // ou définir une contrainte ON DELETE CASCADE dans votre base de données
        
        String query = "DELETE FROM entreprise WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
            return false;
        }
    }
}