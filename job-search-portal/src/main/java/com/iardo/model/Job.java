package com.iardo.model;

import java.sql.Timestamp;

public class Job {
    private int id;
    private int employerId;
    private String title;
    private String description;
    private String location;
    private String jobType;
    private String salary;
    private String experience;
    private String skills;
    private String status;
    private Timestamp postedDate;
    private Timestamp deadline;

    // Constructors
    public Job() {}

    public Job(int id, int employerId, String title, String description, String location,
               String jobType, String salary, String experience, String skills, 
               String status, Timestamp postedDate, Timestamp deadline) {
        this.id = id;
        this.employerId = employerId;
        this.title = title;
        this.description = description;
        this.location = location;
        this.jobType = jobType;
        this.salary = salary;
        this.experience = experience;
        this.skills = skills;
        this.status = status;
        this.postedDate = postedDate;
        this.deadline = deadline;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEmployerId() {
        return employerId;
    }

    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
        this.salary = salary;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getPostedDate() {
        return postedDate;
    }

    public void setPostedDate(Timestamp postedDate) {
        this.postedDate = postedDate;
    }

    public Timestamp getDeadline() {
        return deadline;
    }

    public void setDeadline(Timestamp deadline) {
        this.deadline = deadline;
    }

    @Override
    public String toString() {
        return "Job{" +
                "id=" + id +
                ", employerId=" + employerId +
                ", title='" + title + '\'' +
                ", location='" + location + '\'' +
                ", jobType='" + jobType + '\'' +
                ", salary='" + salary + '\'' +
                ", status='" + status + '\'' +
                ", postedDate=" + postedDate +
                '}';
    }
}