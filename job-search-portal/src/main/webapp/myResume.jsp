<%@ page import="com.iardo.dao.CandidateDAO" %>
<%@ page import="com.iardo.dao.ResumeDAO" %>
<%@ page import="com.iardo.model.Candidate" %>
<%@ page import="com.iardo.model.Resume" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session == null || session.getAttribute("userType") == null 
        || !"candidate".equals(session.getAttribute("userType"))) {
        response.sendRedirect("login.jsp?error=Please login first!");
        return;
    }

    String userEmail = (String) session.getAttribute("userEmail");
    CandidateDAO dao = new CandidateDAO();
    Candidate candidate = dao.getCandidateByEmail(userEmail);

    if (candidate == null) {
        response.sendRedirect("login.jsp?error=User not found!");
        return;
    }

    // Get all resumes for this candidate
    ResumeDAO resumeDAO = new ResumeDAO();
    List<Resume> resumes = resumeDAO.getResumesByCandidateId(candidate.getId());
    ResumeDAO.ResumeStats stats = resumeDAO.getResumeStats(candidate.getId());

    // Get success/error messages
    String successMsg = request.getParameter("success");
    String errorMsg = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Resume</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: #f0f2f5;
            overflow-x: hidden;
        }

        .sidebar {
            height: 100vh;
            background: linear-gradient(180deg, #0d6efd 0%, #0a58ca 100%);
            padding-top: 20px;
            position: fixed;
            width: 250px;
            top: 0;
            left: 0;
            overflow-y: auto;
            transition: all 0.3s;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
        }

        .sidebar a {
            color: #fff;
            padding: 12px 20px;
            display: block;
            text-decoration: none;
            font-size: 15px;
            border-radius: 8px;
            margin: 5px 10px;
            transition: all 0.3s;
        }

        .sidebar a:hover, .sidebar a.active {
            background: rgba(255, 255, 255, 0.2);
            transform: translateX(5px);
        }

        .content {
            margin-left: 270px;
            padding: 30px;
        }

        .resume-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: all 0.3s;
            border: 2px solid #e0e0e0;
        }

        .resume-card:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.12);
            border-color: #0d6efd;
        }

        .resume-card.active {
            border-color: #198754;
            background: #f8fff8;
        }

        .file-icon {
            width: 60px;
            height: 60px;
            background: #e7f1ff;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            color: #0d6efd;
        }

        .upload-zone {
            border: 2px dashed #ccc;
            border-radius: 12px;
            padding: 40px;
            text-align: center;
            background: white;
            transition: all 0.3s;
        }

        .upload-zone:hover {
            border-color: #0d6efd;
            background: #f8f9ff;
        }

        .upload-zone.dragover {
            border-color: #198754;
            background: #f0fff4;
        }

        @media (max-width: 992px) {
            .content { margin-left: 200px; }
            .sidebar { width: 200px; }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            .content { margin-left: 0; padding: 15px; }
        }
    </style>
</head>

<body>


<%@ include file="header.jsp" %>

<!-- SIDEBAR -->
<div class="sidebar">
    <h4 class="text-white text-center mb-4"><i class="bi bi-briefcase-fill me-2"></i>Job Portal</h4>
    <a href="candidateDashboard.jsp"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
    <a href="browseJobs.jsp"><i class="bi bi-search me-2"></i>Browse Jobs</a>
    <a href="myApplications.jsp"><i class="bi bi-file-text-fill me-2"></i>Applications</a>
    <a href="savedJobs.jsp"><i class="bi bi-bookmark-fill me-2"></i>Saved Jobs</a>
    <a href="jobAlerts.jsp"><i class="bi bi-bell-fill me-2"></i>Job Alerts</a>
    <a href="editProfile.jsp"><i class="bi bi-person-circle me-2"></i>My Profile</a>
    <a href="myResume.jsp" class="active"><i class="bi bi-file-earmark-pdf-fill me-2"></i>My Resume</a>
    <a href="logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="content">

    <h2 class="mb-4"><i class="bi bi-file-earmark-pdf-fill me-2"></i>My Resume</h2>

    <% if (successMsg != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i><%= successMsg %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <% if (errorMsg != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i><%= errorMsg %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <div class="alert alert-info mb-4">
        <i class="bi bi-info-circle-fill me-2"></i>
        Upload your resume to apply for jobs quickly. Supported formats: PDF, DOC, DOCX (Max size: 5MB)
    </div>

    <!-- Upload New Resume -->
    <div class="card-body">
        <form action="uploadResume" method="post" enctype="multipart/form-data" id="uploadForm">
            <div class="upload-zone" id="uploadZone">
                <i class="bi bi-cloud-arrow-up" style="font-size: 50px; color: #0d6efd;"></i>
                <h5 class="mt-3">Drag & Drop your resume here</h5>
                <p class="text-muted mb-3">or click to browse files</p>
                <button type="button" class="btn btn-primary" id="browseBtn">Choose File</button>
                <input type="file" name="resumeFile" id="resumeInput" accept=".pdf,.doc,.docx" style="display: none;" required>
                <p class="text-muted small mt-3 mb-0">Supported: PDF, DOC, DOCX • Max size: 5MB</p>
                <p id="selectedFile" class="mt-2 text-success"></p>
            </div>
            <div class="form-check mt-3">
                <input class="form-check-input" type="checkbox" name="makePrimary" value="true" id="makePrimary" 
                    <%= resumes.isEmpty() ? "checked disabled" : "" %>>
                <label class="form-check-label" for="makePrimary">
                    Make this my primary resume
                </label>
            </div>
            <button type="submit" class="btn btn-primary mt-3" id="uploadBtn" style="display: none;">
                <i class="bi bi-upload me-2"></i>Upload Resume
            </button>
        </form>
    </div>

    <!-- Current/Uploaded Resumes -->
    <h5 class="mb-3 mt-4">My Resumes (<%= resumes.size() %>)</h5>

    <% if (resumes.isEmpty()) { %>
        <div class="alert alert-warning">
            <i class="bi bi-info-circle me-2"></i>You haven't uploaded any resumes yet. Upload your first resume to get started!
        </div>
    <% } else { %>
        <% for (Resume resume : resumes) { %>
            <div class="resume-card <%= resume.isPrimary() ? "active" : "" %>">
                <div class="d-flex align-items-start">
                    <div class="file-icon me-3">
                        <% if ("pdf".equals(resume.getFileType())) { %>
                            <i class="bi bi-file-earmark-pdf-fill"></i>
                        <% } else { %>
                            <i class="bi bi-file-earmark-word-fill"></i>
                        <% } %>
                    </div>
                    <div class="flex-grow-1">
                        <div class="d-flex align-items-center mb-2">
                            <h5 class="mb-0 me-2"><%= resume.getFileName() %></h5>
                            <% if (resume.isPrimary()) { %>
                                <span class="badge bg-success">PRIMARY</span>
                            <% } %>
                        </div>
                        <p class="text-muted mb-2">
                            <i class="bi bi-calendar3 me-2"></i>Uploaded: <%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(resume.getUploadedAt()) %>
                            <i class="bi bi-file-earmark ms-3 me-2"></i>Size: <%= resume.getFormattedFileSize() %>
                            <i class="bi bi-eye ms-3 me-2"></i>Views: <%= resume.getViews() %>
                        </p>
                        <% if (resume.isPrimary()) { %>
                            <p class="text-muted small mb-0">
                                This resume is currently being used for job applications
                            </p>
                        <% } %>
                    </div>
                    <div class="d-flex flex-column">
                        <% if (!resume.isPrimary()) { %>
                            <form action="makePrimaryResume" method="post" style="display:inline;">
                                <input type="hidden" name="resumeId" value="<%= resume.getResumeId() %>">
                                <button type="submit" class="btn btn-success btn-sm mb-2">
                                    <i class="bi bi-star"></i> Make Primary
                                </button>
                            </form>
                        <% } %>
                        <a href="downloadResume?id=<%= resume.getResumeId() %>" class="btn btn-outline-primary btn-sm mb-2">
                            <i class="bi bi-download"></i> Download
                        </a>
                        <a href="<%= request.getContextPath() %>/<%= resume.getFilePath() %>" target="_blank" class="btn btn-outline-info btn-sm mb-2">
                            <i class="bi bi-eye"></i> Preview
                        </a>
                        <form action="deleteResume" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this resume?');">
                            <input type="hidden" name="resumeId" value="<%= resume.getResumeId() %>">
                            <button type="submit" class="btn btn-outline-danger btn-sm">
                                <i class="bi bi-trash"></i> Delete
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        <% } %>
    <% } %>

    <!-- Resume Tips -->
    <div class="card shadow-sm border-0 mt-4" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
        <div class="card-body">
            <h5 class="mb-3"><i class="bi bi-lightbulb-fill me-2"></i>Resume Tips</h5>
            <ul class="mb-0">
                <li class="mb-2">Keep your resume up to date with recent experience and skills</li>
                <li class="mb-2">Use a clean, professional format that's easy to read</li>
                <li class="mb-2">Tailor your resume for different job roles when possible</li>
                <li class="mb-2">Include quantifiable achievements and results</li>
                <li class="mb-0">Proofread carefully for spelling and grammar errors</li>
            </ul>
        </div>
    </div>

    <!-- Resume Statistics -->
    <div class="row mt-4">
        <div class="col-md-4 mb-3">
            <div class="card shadow-sm border-0 text-center">
                <div class="card-body">
                    <h2 class="text-primary mb-2"><%= stats.totalViews %></h2>
                    <p class="text-muted mb-0">Total Resume Views</p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card shadow-sm border-0 text-center">
                <div class="card-body">
                    <h2 class="text-success mb-2"><%= stats.totalDownloads %></h2>
                    <p class="text-muted mb-0">Downloads by Recruiters</p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card shadow-sm border-0 text-center">
                <div class="card-body">
                    <h2 class="text-warning mb-2"><%= stats.totalResumes %></h2>
                    <p class="text-muted mb-0">Total Resumes</p>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const uploadZone = document.getElementById('uploadZone');
    const fileInput = document.getElementById('resumeInput');
    const uploadBtn = document.getElementById('uploadBtn');
    const selectedFile = document.getElementById('selectedFile');
    const uploadForm = document.getElementById('uploadForm');
    const browseBtn = document.getElementById('browseBtn');

    // Only the browse button triggers file input
    browseBtn.addEventListener('click', (e) => {
        e.stopPropagation();
        fileInput.click();
    });

    // Drag and drop for the zone itself
    uploadZone.addEventListener('click', (e) => {
        // Only trigger if clicking the zone itself, not the button
        if (e.target === uploadZone || e.target.tagName === 'I' || e.target.tagName === 'H5' || e.target.tagName === 'P') {
            fileInput.click();
        }
    });

    uploadZone.addEventListener('dragover', (e) => {
        e.preventDefault();
        e.stopPropagation();
        uploadZone.classList.add('dragover');
    });

    uploadZone.addEventListener('dragleave', () => {
        uploadZone.classList.remove('dragover');
    });

    uploadZone.addEventListener('drop', (e) => {
        e.preventDefault();
        e.stopPropagation();
        uploadZone.classList.remove('dragover');
        const files = e.dataTransfer.files;
        if (files.length > 0) {
            fileInput.files = files;
            handleFile(files[0]);
        }
    });

    fileInput.addEventListener('change', (e) => {
        if (e.target.files.length > 0) {
            handleFile(e.target.files[0]);
        }
    });

    function handleFile(file) {
        // Check file type
        const allowedTypes = ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'];
        if (!allowedTypes.includes(file.type)) {
            alert('Please upload a PDF, DOC, or DOCX file');
            fileInput.value = '';
            return;
        }

        // Check file size (5MB)
        if (file.size > 5 * 1024 * 1024) {
            alert('File size must be less than 5MB');
            fileInput.value = '';
            return;
        }

        // Show selected file
        selectedFile.textContent = '✓ Selected: ' + file.name;
        uploadBtn.style.display = 'block';
    }

    // Form submission
    uploadForm.addEventListener('submit', (e) => {
        if (fileInput.files.length === 0) {
            e.preventDefault();
            alert('Please select a file to upload');
        }
    });
</script>
</body>
</html>