package com.iardo.model;

public class Candidate {
    private int id;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String gender;
    private String category;
    private String dob;
    private String experience;
    private String profilePicture;
    private int agreeTerms;
    private String registrationDate;
    private String cv;
    
    // New fields for complete profile
    private String skills;
    private String employment;
    private String education;
    private String projects;
    private String certifications;
    private String achievements;
    private int profileCompletion;

    // Default Constructor
    public Candidate() {
    }

    // Constructor with all fields
    public Candidate(int id, String name, String email, String password, String phone, 
                     String gender, String category, String dob, String experience, 
                     String profilePicture, int agreeTerms, String registrationDate, String cv,
                     String skills, String employment, String education, String projects,
                     String certifications, String achievements) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.gender = gender;
        this.category = category;
        this.dob = dob;
        this.experience = experience;
        this.profilePicture = profilePicture;
        this.agreeTerms = agreeTerms;
        this.registrationDate = registrationDate;
        this.cv = cv;
        this.skills = skills;
        this.employment = employment;
        this.education = education;
        this.projects = projects;
        this.certifications = certifications;
        this.achievements = achievements;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return name;
    }

    public void setFullName(String fullName) {
        this.name = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    public int getAgreeTerms() {
        return agreeTerms;
    }

    public void setAgreeTerms(int agreeTerms) {
        this.agreeTerms = agreeTerms;
    }

    public String getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(String registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getCv() {
        return cv;
    }

    public void setCv(String cv) {
        this.cv = cv;
    }

    // New fields getters and setters
    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public String getEmployment() {
        return employment;
    }

    public void setEmployment(String employment) {
        this.employment = employment;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getProjects() {
        return projects;
    }

    public void setProjects(String projects) {
        this.projects = projects;
    }

    public String getCertifications() {
        return certifications;
    }

    public void setCertifications(String certifications) {
        this.certifications = certifications;
    }

    public String getAchievements() {
        return achievements;
    }

    public void setAchievements(String achievements) {
        this.achievements = achievements;
    }

    public int getProfileCompletion() {
        return profileCompletion;
    }

    public void setProfileCompletion(int profileCompletion) {
        this.profileCompletion = profileCompletion;
    }

    @Override
    public String toString() {
        return "Candidate{" +
                "id=" + id +
                ", fullName='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", gender='" + gender + '\'' +
                ", category='" + category + '\'' +
                ", dob='" + dob + '\'' +
                ", experience='" + experience + '\'' +
                ", profileCompletion=" + profileCompletion + "%" +
                '}';
    }
}