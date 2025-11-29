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

    int completion = candidate.getProfileCompletion();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Candidate Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: #f0f2f5;
            overflow-x: hidden;
        }

        /* SIDEBAR */
        .sidebar {
            height: 100vh;
            background: #0d6efd;
            padding-top: 20px;
            position: fixed;
            width: 230px;
            top: 0;
            left: 0;
            overflow-y: auto;
            transition: all 0.3s;
        }

        .sidebar a {
            color: #fff;
            padding: 12px 20px;
            display: block;
            text-decoration: none;
            font-size: 16px;
            border-radius: 5px;
            margin: 2px 10px;
            transition: background 0.3s, transform 0.2s;
        }

        .sidebar a:hover {
            background: #084298;
            transform: translateX(5px);
        }

        /* MAIN CONTENT */
        .content {
            margin-left: 250px;
            padding: 20px;
        }

        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 3px solid #0d6efd;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .profile-img:hover {
            transform: scale(1.05);
        }

        .card {
            border-radius: 12px;
        }

        .card-header {
            font-weight: 600;
            font-size: 16px;
        }

        .progress {
            height: 25px;
            border-radius: 12px;
        }

        .progress-bar {
            font-weight: 600;
        }

        /* RESPONSIVE RULES */
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

            .sidebar a { display: inline-block; padding: 10px; }
            .content { margin-left: 0; margin-top: 10px; padding: 10px; }

            .card-body.d-flex {
                flex-direction: column;
                text-align: center;
            }

            .card-body .ms-auto {
                margin-left: 0 !important;
                margin-top: 10px;
            }

            .profile-img { margin-bottom: 10px; }
        }

        @media (max-width: 480px) {
            .sidebar a { font-size: 14px; padding: 8px; }
            .profile-img { width: 70px; height: 70px; }
        }

        /* CARD HOVER EFFECT */
        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            transition: 0.3s;
        }

    </style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h4 class="text-white text-center mb-4">Candidate Panel</h4>
    <a href="candidateDashboard.jsp"><i class="bi bi-house-door-fill me-2"></i>Dashboard</a>
    <a href="editProfile.jsp"><i class="bi bi-pencil-square me-2"></i>Edit Profile</a>
    <a href="#"><i class="bi bi-briefcase-fill me-2"></i>Applied Jobs</a>
    <a href="#"><i class="bi bi-stars me-2"></i>Recommended Jobs</a>
    <a href="#"><i class="bi bi-bookmark-fill me-2"></i>Saved Jobs</a>
    <a href="logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="content container mt-4">

    <!-- Profile Header -->
    <div class="card shadow-sm mb-4">
        <div class="card-body d-flex align-items-center">
        
        

          <img src="360_F_553796090_XHrE6R9jwmBJUMo9HKl41hyHJ5gqt9oz.jpg"
                 class="profile-img me-3" alt="Profile Picture">
       
            <div>
                <h4 class="mb-1"><%= candidate.getFullName() %></h4>
                <p class="text-muted mb-0"><i class="bi bi-envelope-fill me-1"></i> <%= candidate.getEmail() %></p>
                <p class="text-muted mb-0"><i class="bi bi-person-badge-fill me-1"></i> Category: <%= candidate.getCategory() %></p>
            </div>

            <div class="ms-auto">
                <a href="editProfile.jsp" class="btn btn-outline-primary me-2"><i class="bi bi-pencil-square"></i> Update Profile</a>
                <a href="#" class="btn btn-primary"><i class="bi bi-upload"></i> Upload CV</a>
            </div>
        </div>
    </div>

    <!-- Profile Completion -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <h5 class="mb-3"><i class="bi bi-bar-chart-fill me-2"></i>Profile Strength</h5>
            <div class="progress mb-2">
                <div class="progress-bar bg-success" role="progressbar"
                     style="width: <%= completion %>%;">
                    <%= completion %>% Complete
                </div>
            </div>
            <p class="text-muted">Improve your profile to get better job recommendations and visibility.</p>
        </div>
    </div>

    <!-- Overview Section -->
    <div class="row">

        <!-- Personal Info -->
        <div class="col-md-6">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-light">
                    <i class="bi bi-person-fill me-2"></i>Personal Information
                </div>
                <div class="card-body">
                    <p><strong>Phone:</strong> <%= candidate.getPhone() != null ? candidate.getPhone() : "Not Updated" %></p>
                    <p><strong>Gender:</strong> <%= candidate.getGender() != null ? candidate.getGender() : "Not Updated" %></p>
                    <p><strong>Date of Birth:</strong> <%= candidate.getDob() != null ? candidate.getDob() : "Not Updated" %></p>
                    <p><strong>Experience:</strong> <%= candidate.getExperience() != null ? candidate.getExperience() : "Not Updated" %></p>
                </div>
            </div>
        </div>

        <!-- Skills & Professional Info -->
        <div class="col-md-6">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-light">
                    <i class="bi bi-gear-fill me-2"></i>Skills & Professional Info
                </div>
                <div class="card-body">
                    <p><strong>Skills:</strong> <%= candidate.getSkills() != null ? candidate.getSkills() : "Not Added" %></p>
                    <p><strong>Education:</strong> <%= candidate.getEducation() != null ? candidate.getEducation() : "Not Added" %></p>
                    <p><strong>Projects:</strong> <%= candidate.getProjects() != null ? candidate.getProjects() : "Not Added" %></p>
                    <p><strong>Certifications:</strong> <%= candidate.getCertifications() != null ? candidate.getCertifications() : "Not Added" %></p>
                </div>
            </div>
        </div>

    </div>

    <!-- JOB RECOMMENDATIONS -->
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-light">
            <i class="bi bi-lightbulb-fill me-2"></i>Recommended Jobs For You
        </div>
        <div class="card-body">
            <div class="alert alert-info d-flex align-items-center">
                <i class="bi bi-info-circle-fill me-2"></i>
                Job recommendations will appear here based on your skills: 
                <strong class="ms-1"><%= candidate.getSkills() != null ? candidate.getSkills() : "Add skills to get job suggestions" %></strong>
            </div>
            <p class="text-muted">Integrate job API or database to display real-time job recommendations.</p>
        </div>
    </div>

</div>

</body>
</html>
