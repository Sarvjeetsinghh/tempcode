<%@ page import="com.iardo.dao.CandidateDAO" %>
<%@ page import="com.iardo.model.Candidate" %>
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

    String successMsg = request.getParameter("success");
    String errorMsg = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload CV - Job Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            padding: 20px 0;
        }

        /* SIDEBAR */
        .sidebar {
            height: 100vh;
            background: linear-gradient(180deg, #0d6efd 0%, #084298 100%);
            padding-top: 20px;
            position: fixed;
            width: 250px;
            top: 0;
            left: 0;
            overflow-y: auto;
            box-shadow: 4px 0 15px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            transition: all 0.3s ease;
        }

        .sidebar-header {
            padding: 20px;
            text-align: center;
            color: white;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-header h4 {
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .sidebar a {
            color: #fff;
            padding: 15px 25px;
            display: block;
            text-decoration: none;
            font-size: 16px;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }

        .sidebar a:hover {
            background: rgba(255, 255, 255, 0.1);
            border-left: 4px solid #fff;
            padding-left: 30px;
        }

        .sidebar a.active {
            background: rgba(255, 255, 255, 0.15);
            border-left: 4px solid #ffc107;
        }

        .sidebar a i {
            margin-right: 10px;
            width: 20px;
        }

        /* MAIN CONTENT */
        .content {
            margin-left: 270px;
            padding: 30px;
        }

        .page-header {
            background: white;
            padding: 25px 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h2 {
            color: #0d6efd;
            font-weight: 600;
            margin: 0;
        }

        /* UPLOAD CONTAINER */
        .upload-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
            padding: 40px;
            animation: slideUp 0.5s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .upload-area {
            border: 3px dashed #0d6efd;
            border-radius: 15px;
            padding: 60px 40px;
            text-align: center;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .upload-area:hover {
            border-color: #084298;
            background: linear-gradient(135deg, #e9ecef 0%, #dee2e6 100%);
            transform: scale(1.02);
        }

        .upload-area.dragover {
            border-color: #28a745;
            background: #d4edda;
        }

        .upload-icon {
            font-size: 80px;
            color: #0d6efd;
            margin-bottom: 20px;
        }

        .current-cv-section {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            border: 2px solid #28a745;
        }

        .current-cv-section h4 {
            color: #155724;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .current-cv-section h4 i {
            margin-right: 10px;
            font-size: 28px;
        }

        .cv-info {
            background: white;
            padding: 20px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .cv-icon {
            font-size: 50px;
            color: #dc3545;
            margin-right: 20px;
        }

        .btn-custom-primary {
            background: linear-gradient(135deg, #0d6efd 0%, #084298 100%);
            color: white;
            border: none;
            padding: 14px 40px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(13, 110, 253, 0.3);
        }

        .btn-custom-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(13, 110, 253, 0.4);
            color: white;
        }

        .btn-download {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .btn-download:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
            color: white;
        }

        .file-info {
            margin-top: 20px;
            padding: 15px;
            background: #e7f3ff;
            border-radius: 10px;
            display: none;
        }

        .alert {
            border-radius: 12px;
            border: none;
            padding: 15px 20px;
            font-weight: 500;
            animation: slideDown 0.5s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* MOBILE MENU TOGGLE */
        .mobile-menu-toggle {
            display: none;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1001;
            background: #0d6efd;
            color: white;
            border: none;
            padding: 12px 18px;
            border-radius: 10px;
            font-size: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        /* RESPONSIVE */
        @media (max-width: 992px) {
            .content {
                margin-left: 0;
                padding: 20px;
                margin-top: 70px;
            }

            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .mobile-menu-toggle {
                display: block;
            }

            .upload-container {
                padding: 25px;
            }

            .upload-area {
                padding: 40px 20px;
            }
        }
    </style>
</head>

<body>

<!-- MOBILE MENU TOGGLE -->
<button class="mobile-menu-toggle" onclick="toggleSidebar()">
    <i class="fas fa-bars"></i>
</button>

<!-- SIDEBAR -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <h4><i class="fas fa-briefcase"></i> Job Portal</h4>
        <p class="mb-0" style="font-size: 13px; opacity: 0.8;">Welcome, <%= candidate.getFullName() %></p>
    </div>
    <a href="candidateDashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
    <a href="editProfile.jsp"><i class="fas fa-user-edit"></i> Edit Profile</a>
    <a href="uploadCV.jsp" class="active"><i class="fas fa-file-upload"></i> Upload CV</a>
    <a href="#"><i class="fas fa-file-alt"></i> Applied Jobs</a>
    <a href="#"><i class="fas fa-star"></i> Recommended Jobs</a>
    <a href="#"><i class="fas fa-heart"></i> Saved Jobs</a>
    <a href="#"><i class="fas fa-bell"></i> Notifications</a>
    <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="content">

    <!-- PAGE HEADER -->
    <div class="page-header">
        <h2><i class="fas fa-file-upload"></i> Upload CV</h2>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="candidateDashboard.jsp">Dashboard</a></li>
                <li class="breadcrumb-item active">Upload CV</li>
            </ol>
        </nav>
    </div>

    <!-- SUCCESS/ERROR MESSAGES -->
    <% if (successMsg != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle"></i> <%= successMsg %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <% if (errorMsg != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle"></i> <%= errorMsg %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <!-- CURRENT CV SECTION -->
    <% if (candidate.getCv() != null && !candidate.getCv().isEmpty()) { %>
        <div class="current-cv-section">
            <h4><i class="fas fa-check-circle"></i> Your Current CV</h4>
            <div class="cv-info">
                <div class="d-flex align-items-center">
                    <i class="fas fa-file-pdf cv-icon"></i>
                    <div>
                        <h5 class="mb-1">CV Uploaded</h5>
                        <p class="text-muted mb-0"><%= candidate.getCv() %></p>
                    </div>
                </div>
                <div>
                    <a href="<%= candidate.getCv() %>" target="_blank" class="btn btn-download me-2">
                        <i class="fas fa-download"></i> Download CV
                    </a>
                    <a href="<%= candidate.getCv() %>" target="_blank" class="btn btn-outline-primary">
                        <i class="fas fa-eye"></i> View
                    </a>
                </div>
            </div>
        </div>
    <% } else { %>
        <div class="alert alert-info">
            <i class="fas fa-info-circle"></i> You haven't uploaded your CV yet. Upload one below to increase your chances of getting hired!
        </div>
    <% } %>

    <!-- UPLOAD CONTAINER -->
    <div class="upload-container">
        <h3 class="text-center mb-4">
            <i class="fas fa-cloud-upload-alt text-primary"></i> 
            <%= (candidate.getCv() != null && !candidate.getCv().isEmpty()) ? "Replace Your CV" : "Upload Your CV" %>
        </h3>

        <form action="UploadCVServlet" method="post" enctype="multipart/form-data" id="uploadForm">
            
            <div class="upload-area" id="uploadArea">
                <div class="upload-icon">
                    <i class="fas fa-file-upload"></i>
                </div>
                <h4>Drag & Drop your CV here</h4>
                <p class="text-muted mb-3">or click to browse</p>
                <input type="file" name="cvFile" id="cvFile" accept=".pdf,.doc,.docx" 
                       style="display: none;" required onchange="showFileInfo()">
                <button type="button" class="btn btn-custom-primary" onclick="document.getElementById('cvFile').click()">
                    <i class="fas fa-folder-open"></i> Choose File
                </button>
                <p class="text-muted mt-3 mb-0">
                    <small><i class="fas fa-info-circle"></i> Accepted formats: PDF, DOC, DOCX (Max 15MB)</small>
                </p>
            </div>

            <div class="file-info" id="fileInfo">
                <div class="d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-file-alt fa-2x text-primary me-3"></i>
                        <div>
                            <strong id="fileName">No file selected</strong>
                            <p class="text-muted mb-0" id="fileSize"></p>
                        </div>
                    </div>
                    <button type="button" class="btn btn-sm btn-outline-danger" onclick="clearFile()">
                        <i class="fas fa-times"></i> Remove
                    </button>
                </div>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-custom-primary btn-lg">
                    <i class="fas fa-upload"></i> Upload CV
                </button>
                <a href="candidateDashboard.jsp" class="btn btn-outline-secondary btn-lg ms-2">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>

        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Toggle Sidebar for Mobile
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('active');
    }

    // Drag and Drop functionality
    const uploadArea = document.getElementById('uploadArea');
    const fileInput = document.getElementById('cvFile');

    uploadArea.addEventListener('dragover', (e) => {
        e.preventDefault();
        uploadArea.classList.add('dragover');
    });

    uploadArea.addEventListener('dragleave', () => {
        uploadArea.classList.remove('dragover');
    });

    uploadArea.addEventListener('drop', (e) => {
        e.preventDefault();
        uploadArea.classList.remove('dragover');
        
        const files = e.dataTransfer.files;
        if (files.length > 0) {
            fileInput.files = files;
            showFileInfo();
        }
    });

    // Show file information
    function showFileInfo() {
        const file = fileInput.files[0];
        if (file) {
            const fileName = file.name;
            const fileSize = (file.size / 1024 / 1024).toFixed(2); // Convert to MB
            
            document.getElementById('fileName').textContent = fileName;
            document.getElementById('fileSize').textContent = 'Size: ' + fileSize + ' MB';
            document.getElementById('fileInfo').style.display = 'block';
        }
    }

    // Clear file selection
    function clearFile() {
        fileInput.value = '';
        document.getElementById('fileInfo').style.display = 'none';
    }

    // Auto-dismiss alerts after 5 seconds
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>

</body>
</html>