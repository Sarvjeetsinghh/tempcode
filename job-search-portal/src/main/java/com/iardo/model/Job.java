package com.iardo.model;

public class Job {
    private int id;
    private String title;
    private String description;
    private String company;
    private String location;
    private double salary;
    private String website;

    // ✅ Constructor (optional)
    public Job() {}

    // ✅ Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCompany() { return company; }
    public void setCompany(String company) { this.company = company; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public double getSalary() { return salary; }
    public void setSalary(double salary) { this.salary = salary; }

    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }
}
