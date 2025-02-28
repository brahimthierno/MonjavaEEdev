package com.modele;

import java.util.Date;

public class Employe {
    private String matricule;
    private String nom;
    private String prenom;
    private String fonction;
    private String service;
    private Date dateEmbauche;
    private String sexe;
    private double salaireBase;
    private int entrepriseId;

    // Constructeurs, getters et setters
    public Employe() {}

    public Employe(String matricule, String nom, String prenom, String fonction,
            String service, Date dateEmbauche, String sexe, double salaireBase, int entrepriseId) {
        this.matricule = matricule;
        this.nom = nom;
        this.prenom = prenom;
        this.fonction = fonction;
        this.service = service;
        this.dateEmbauche = dateEmbauche;
        this.sexe = sexe;
        this.salaireBase = salaireBase;
        this.entrepriseId = entrepriseId;
    }

    // Getters et setters
    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getFonction() {
        return fonction;
    }

    public void setFonction(String fonction) {
        this.fonction = fonction;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public Date getDateEmbauche() {
        return dateEmbauche;
    }

    public void setDateEmbauche(Date dateEmbauche) {
        this.dateEmbauche = dateEmbauche;
    }

    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public double getSalaireBase() {
        return salaireBase;
    }

    public void setSalaireBase(double salaireBase) {
        this.salaireBase = salaireBase;
    }

    public int getEntrepriseId() {
        return entrepriseId;
    }

    public void setEntrepriseId(int entrepriseId) {
        this.entrepriseId = entrepriseId;
    }
}