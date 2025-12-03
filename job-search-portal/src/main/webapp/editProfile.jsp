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
    <title>Edit Profile - Job Portal</title>
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

        .page-header .breadcrumb {
            background: none;
            margin: 0;
            padding: 0;
        }

        /* FORM CONTAINER */
        .form-container {
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

        .section-title {
            color: #0d6efd;
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 3px solid #0d6efd;
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 12px;
            font-size: 24px;
        }

        .form-section {
            margin-bottom: 40px;
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 15px;
        }

        .form-control, .form-select {
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            padding: 12px 15px;
            font-size: 15px;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.15);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .input-group-text {
            background: #0d6efd;
            color: white;
            border: none;
            border-radius: 10px 0 0 10px;
        }

        /* BUTTONS */
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
        }

        .btn-custom-secondary {
            background: white;
            color: #0d6efd;
            border: 2px solid #0d6efd;
            padding: 14px 40px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .btn-custom-secondary:hover {
            background: #0d6efd;
            color: white;
        }

        /* ALERTS */
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

        .alert-success {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
        }

        .alert-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
        }

        /* PROFILE IMAGE UPLOAD */
        .profile-upload-section {
            text-align: center;
            padding: 30px;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 15px;
            margin-bottom: 30px;
        }

        .profile-img-preview {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 5px solid #0d6efd;
            object-fit: cover;
            margin: 0 auto 20px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .file-upload-btn {
            position: relative;
            overflow: hidden;
            display: inline-block;
        }

        .file-upload-btn input[type=file] {
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            cursor: pointer;
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

        /* RESPONSIVE DESIGN */
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

            .page-header {
                flex-direction: column;
                text-align: center;
            }

            .page-header h2 {
                margin-bottom: 10px;
            }

            .form-container {
                padding: 25px;
            }
        }

        @media (max-width: 768px) {
            .content {
                padding: 15px;
            }

            .form-container {
                padding: 20px;
            }

            .section-title {
                font-size: 18px;
            }

            .btn-custom-primary, .btn-custom-secondary {
                width: 100%;
                margin-bottom: 10px;
            }

            .profile-img-preview {
                width: 120px;
                height: 120px;
            }
        }

        @media (max-width: 576px) {
            .page-header {
                padding: 20px;
            }

            .page-header h2 {
                font-size: 22px;
            }

            .form-container {
                padding: 15px;
            }

            .section-title {
                font-size: 16px;
            }

            .sidebar a {
                font-size: 14px;
                padding: 12px 20px;
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
    <a href="editProfile.jsp" class="active"><i class="fas fa-user-edit"></i> Edit Profile</a>
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
        <h2><i class="fas fa-user-edit"></i> Edit Profile</h2>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="candidateDashboard.jsp">Dashboard</a></li>
                <li class="breadcrumb-item active">Edit Profile</li>
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

    <!-- FORM CONTAINER -->
    <div class="form-container">
        <form action="UpdateProfileServlet" method="post" enctype="multipart/form-data">

            <!-- PROFILE PICTURE SECTION -->
            <!-- PROFILE PICTURE SECTION -->
<div class="profile-upload-section">
    <%
        // Get current profile picture
        String currentProfilePic = candidate.getProfilePicture();
        
        // Set default if null
        if (currentProfilePic == null || currentProfilePic.trim().isEmpty()) {
            currentProfilePic = "360_F_553796090_XHrE6R9jwmBJUMo9HKl41hyHJ5gqt9oz.jpg";
        }
    %>
    
    <img src="<%= currentProfilePic %>" 
         class="profile-img-preview" 
         id="profilePreview" 
         alt="Profile Picture"
         onerror="this.src='360_F_553796090_XHrE6R9jwmBJUMo9HKl41hyHJ5gqt9oz.jpg'">
    
    <div class="mt-3">
        <label class="file-upload-btn btn btn-custom-primary">
            <i class="fas fa-camera"></i> Change Profile Picture
            <input type="file" name="profilePicture" accept="image/*" onchange="previewImage(event)">
        </label>
    </div>
    
    <% if (currentProfilePic != null && !currentProfilePic.equals("360_F_553796090_XHrE6R9jwmBJUMo9HKl41hyHJ5gqt9oz.jpg")) { %>
        <small class="text-muted d-block mt-2">
            <i class="fas fa-check-circle text-success"></i> Profile picture uploaded
        </small>
    <% } %>
</div>

            <!-- PERSONAL INFORMATION -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-user"></i> Personal Information
                </h3>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Full Name *</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input type="text" class="form-control" name="name" 
                                   value="<%= candidate.getFullName() %>" required>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Email *</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" class="form-control" name="email" 
                                   value="<%= candidate.getEmail() %>" readonly>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Phone Number *</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-phone"></i></span>
                            <input type="tel" class="form-control" name="phone" 
                                   value="<%= candidate.getPhone() != null ? candidate.getPhone() : "" %>" required>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Date of Birth *</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                            <input type="date" class="form-control" name="dob" 
                                   value="<%= candidate.getDob() != null ? candidate.getDob() : "" %>" required>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Gender *</label>
                        <select class="form-select" name="gender" required>
                            <option value="">Select Gender</option>
                            <option value="Male" <%= "Male".equals(candidate.getGender()) ? "selected" : "" %>>Male</option>
                            <option value="Female" <%= "Female".equals(candidate.getGender()) ? "selected" : "" %>>Female</option>
                            <option value="Other" <%= "Other".equals(candidate.getGender()) ? "selected" : "" %>>Other</option>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Category *</label>
                        <select class="form-select" name="category" required>
                            <option value="">Select Category</option>
                            <option value="IT" <%= "IT".equals(candidate.getCategory()) ? "selected" : "" %>>IT</option>
                            <option value="Finance" <%= "Finance".equals(candidate.getCategory()) ? "selected" : "" %>>Finance</option>
                            <option value="Marketing" <%= "Marketing".equals(candidate.getCategory()) ? "selected" : "" %>>Marketing</option>
                            <option value="Healthcare" <%= "Healthcare".equals(candidate.getCategory()) ? "selected" : "" %>>Healthcare</option>
                            <option value="Education" <%= "Education".equals(candidate.getCategory()) ? "selected" : "" %>>Education</option>
                            <option value="Other" <%= "Other".equals(candidate.getCategory()) ? "selected" : "" %>>Other</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- PROFESSIONAL INFORMATION -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-briefcase"></i> Professional Information
                </h3>

                <div class="row">
                    <div class="col-md-12 mb-3">
                        <label class="form-label">Years of Experience *</label>
                        <select class="form-select" name="experience" required>
                            <option value="">Select Experience</option>
                            <option value="Fresher" <%= "Fresher".equals(candidate.getExperience()) ? "selected" : "" %>>Fresher</option>
                            <option value="0-1 years" <%= "0-1 years".equals(candidate.getExperience()) ? "selected" : "" %>>0-1 years</option>
                            <option value="1-3 years" <%= "1-3 years".equals(candidate.getExperience()) ? "selected" : "" %>>1-3 years</option>
                            <option value="3-5 years" <%= "3-5 years".equals(candidate.getExperience()) ? "selected" : "" %>>3-5 years</option>
                            <option value="5-10 years" <%= "5-10 years".equals(candidate.getExperience()) ? "selected" : "" %>>5-10 years</option>
                            <option value="10+ years" <%= "10+ years".equals(candidate.getExperience()) ? "selected" : "" %>>10+ years</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Skills (Comma separated)</label>
                    <textarea class="form-control" name="skills" 
                              placeholder="e.g. Java, Python, React, SQL, Team Leadership"><%= candidate.getSkills() != null ? candidate.getSkills() : "" %></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Employment History</label>
                    <textarea class="form-control" name="employment" 
                              placeholder="Describe your work experience..."><%= candidate.getEmployment() != null ? candidate.getEmployment() : "" %></textarea>
                </div>
            </div>

            <!-- EDUCATION & QUALIFICATIONS -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-graduation-cap"></i> Education & Qualifications
                </h3>

                <div class="mb-3">
                    <label class="form-label">Education</label>
                    <textarea class="form-control" name="education" 
                              placeholder="e.g. B.Tech in Computer Science from XYZ University (2018-2022)"><%= candidate.getEducation() != null ? candidate.getEducation() : "" %></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Certifications</label>
                    <textarea class="form-control" name="certifications" 
                              placeholder="List your certifications..."><%= candidate.getCertifications() != null ? candidate.getCertifications() : "" %></textarea>
                </div>
            </div>

            <!-- PROJECTS & ACHIEVEMENTS -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-trophy"></i> Projects & Achievements
                </h3>

                <div class="mb-3">
                    <label class="form-label">Projects</label>
                    <textarea class="form-control" name="projects" 
                              placeholder="Describe your projects..."><%= candidate.getProjects() != null ? candidate.getProjects() : "" %></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Achievements</label>
                    <textarea class="form-control" name="achievements" 
                              placeholder="List your achievements..."><%= candidate.getAchievements() != null ? candidate.getAchievements() : "" %></textarea>
                </div>
            </div>

            <!-- FORM BUTTONS -->
            <div class="text-center mt-4">
                <button type="submit" class="btn btn-custom-primary">
                    <i class="fas fa-save"></i> Save Changes
                </button>
                <a href="candidateDashboard.jsp" class="btn btn-custom-secondary">
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

    // Close sidebar when clicking outside on mobile
    document.addEventListener('click', function(event) {
        const sidebar = document.getElementById('sidebar');
        const toggle = document.querySelector('.mobile-menu-toggle');
        
        if (window.innerWidth <= 992) {
            if (!sidebar.contains(event.target) && !toggle.contains(event.target)) {
                sidebar.classList.remove('active');
            }
        }
    });

    // Profile Image Preview
    function previewImage(event) {
        const reader = new FileReader();
        reader.onload = function() {
            const preview = document.getElementById('profilePreview');
            preview.src = reader.result;
        };
        reader.readAsDataURL(event.target.files[0]);
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