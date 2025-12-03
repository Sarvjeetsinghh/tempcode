package com.iardo.model;

import java.sql.Timestamp;

public class Resume {
    private int resumeId;
    private int candidateId;
    private String fileName;
    private String filePath;
    private String fileType;
    private long fileSize;
    private boolean isPrimary;
    private int views;
    private int downloads;
    private Timestamp uploadedAt;
    
    // Constructors
    public Resume() {}
    
    public Resume(int candidateId, String fileName, String filePath, 
                  String fileType, long fileSize, boolean isPrimary) {
        this.candidateId = candidateId;
        this.fileName = fileName;
        this.filePath = filePath;
        this.fileType = fileType;
        this.fileSize = fileSize;
        this.isPrimary = isPrimary;
    }
    
    // Getters and Setters
    public int getResumeId() {
        return resumeId;
    }
    
    public void setResumeId(int resumeId) {
        this.resumeId = resumeId;
    }
    
    public int getCandidateId() {
        return candidateId;
    }
    
    public void setCandidateId(int candidateId) {
        this.candidateId = candidateId;
    }
    
    public String getFileName() {
        return fileName;
    }
    
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    
    public String getFilePath() {
        return filePath;
    }
    
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
    
    public String getFileType() {
        return fileType;
    }
    
    public void setFileType(String fileType) {
        this.fileType = fileType;
    }
    
    public long getFileSize() {
        return fileSize;
    }
    
    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
    }
    
    public boolean isPrimary() {
        return isPrimary;
    }
    
    public void setIsPrimary(boolean isPrimary) {
        this.isPrimary = isPrimary;
    }
    
    public int getViews() {
        return views;
    }
    
    public void setViews(int views) {
        this.views = views;
    }
    
    public int getDownloads() {
        return downloads;
    }
    
    public void setDownloads(int downloads) {
        this.downloads = downloads;
    }
    
    public Timestamp getUploadedAt() {
        return uploadedAt;
    }
    
    public void setUploadedAt(Timestamp uploadedAt) {
        this.uploadedAt = uploadedAt;
    }
    
    // Helper method to get formatted file size
    public String getFormattedFileSize() {
        if (fileSize < 1024) {
            return fileSize + " B";
        } else if (fileSize < 1024 * 1024) {
            return String.format("%.2f KB", fileSize / 1024.0);
        } else {
            return String.format("%.2f MB", fileSize / (1024.0 * 1024.0));
        }
    }
}