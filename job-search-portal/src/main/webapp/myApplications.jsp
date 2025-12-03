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
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Applications</title>
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

        .application-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            border-left: 4px solid #0d6efd;
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .application-card:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.12);
            transform: translateX(5px);
        }

        .status-badge {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-pending { background: #fff3cd; color: #856404; }
        .status-shortlisted { background: #d1e7dd; color: #0f5132; }
        .status-rejected { background: #f8d7da; color: #842029; }
        .status-interview { background: #cfe2ff; color: #084298; }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .stat-card h2 {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 5px;
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

<!-- SIDEBAR -->
<div class="sidebar">
    <h4 class="text-white text-center mb-4"><i class="bi bi-briefcase-fill me-2"></i>Job Portal</h4>
    <a href="candidateDashboard.jsp"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
    <a href="browseJobs.jsp"><i class="bi bi-search me-2"></i>Browse Jobs</a>
    <a href="myApplications.jsp" class="active"><i class="bi bi-file-text-fill me-2"></i>Applications</a>
    <a href="savedJobs.jsp"><i class="bi bi-bookmark-fill me-2"></i>Saved Jobs</a>
    <a href="jobAlerts.jsp"><i class="bi bi-bell-fill me-2"></i>Job Alerts</a>
    <a href="editProfile.jsp"><i class="bi bi-person-circle me-2"></i>My Profile</a>
    <a href="myResume.jsp"><i class="bi bi-file-earmark-pdf-fill me-2"></i>My Resume</a>
    <a href="logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="content">

    <h2 class="mb-4"><i class="bi bi-file-text-fill me-2"></i>My Applications</h2>

    <!-- Statistics -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="stat-card" style="border-top: 4px solid #0d6efd;">
                <h2 class="text-primary">12</h2>
                <p class="text-muted mb-0">Total Applied</p>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stat-card" style="border-top: 4px solid #198754;">
                <h2 class="text-success">5</h2>
                <p class="text-muted mb-0">Shortlisted</p>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stat-card" style="border-top: 4px solid #ffc107;">
                <h2 class="text-warning">4</h2>
                <p class="text-muted mb-0">Under Review</p>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stat-card" style="border-top: 4px solid #dc3545;">
                <h2 class="text-danger">3</h2>
                <p class="text-muted mb-0">Rejected</p>
            </div>
        </div>
    </div>

    <!-- Filter Tabs -->
    <ul class="nav nav-pills mb-4">
        <li class="nav-item">
            <a class="nav-link active" href="#">All Applications (12)</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Shortlisted (5)</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Under Review (4)</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#">Rejected (3)</a>
        </li>
    </ul>

    <!-- Application 1 - Shortlisted -->
    <div class="application-card" style="border-left-color: #198754;">
        <div class="d-flex justify-content-between align-items-start mb-3">
            <div>
                <h5 class="mb-1">Senior Java Developer</h5>
                <p class="text-muted mb-1">Tata Consultancy Services • Bangalore</p>
                <small class="text-muted"><i class="bi bi-calendar3"></i> Applied on: Oct 25, 2024</small>
            </div>
            <span class="status-badge status-shortlisted">SHORTLISTED</span>
        </div>
        <p class="mb-2"><strong>Applied for:</strong> Full Time • 8-12 LPA • 3-5 Years Experience</p>
        <div class="alert alert-success mb-0">
            <i class="bi bi-check-circle-fill me-2"></i>
            <strong>Great news!</strong> Your profile has been shortlisted. Interview scheduled on Nov 5, 2024 at 2:00 PM.
        </div>
        <div class="mt-3">
            <button class="btn btn-primary btn-sm me-2"><i class="bi bi-eye"></i> View Details</button>
            <button class="btn btn-outline-secondary btn-sm"><i class="bi bi-x-circle"></i> Withdraw</button>
        </div>
    </div>

    <!-- Application 2 - Interview Scheduled -->
    <div class="application-card" style="border-left-color: #0dcaf0;">
        <div class="d-flex justify-content-between align-items-start mb-3">
            <div>
                <h5 class="mb-1">Full Stack Developer</h5>
                <p class="text-muted mb-1">Infosys Limited • Pune</p>
                <small class="text-muted"><i class="bi bi-calendar3"></i> Applied on: Oct 20, 2024</small>
            </div>
            <span class="status-badge status-interview">INTERVIEW SCHEDULED</span>
        </div>
        <p class="mb-2"><strong>Applied for:</strong> Full Time • 6-10 LPA • 2-4 Years Experience</p>
        <div class="alert alert-info mb-0">
            <i class="bi bi-camera-video-fill me-2"></i>
            <strong>Interview Details:</strong> Technical Round - Nov 8, 2024 at 11:00 AM (Virtual)
        </div>
        <div class="mt-3">
            <button class="btn btn-primary btn-sm me-2"><i class="bi bi-eye"></i> View Details</button>
            <button class="btn btn-success btn-sm me-2"><i class="bi bi-calendar-check"></i> Add to Calendar</button>
            <button class="btn btn-outline-secondary btn-sm"><i class="bi bi-x-circle"></i> Withdraw</button>
        </div>
    </div>

    <!-- Application 3 - Under Review -->
    <div class="application-card" style="border-left-color: #ffc107;">
        <div class="d-flex justify-content-between align-items-start mb-3">
            <div>
                <h5 class="mb-1">Python Developer</h5>
                <p class="text-muted mb-1">Wipro Technologies • Hyderabad</p>
                <small class="text-muted"><i class="bi bi-calendar3"></i> Applied on: Oct 18, 2024</small>
            </div>
            <span class="status-badge status-pending">UNDER REVIEW</span>
        </div>
        <p class="mb-2"><strong>Applied for:</strong> Hybrid • 5-8 LPA • 1-3 Years Experience</p>
        <div class="progress mb-2" style="height: 8px;">
            <div class="progress-bar bg-warning" style="width: 50%;"></div>
        </div>
        <small class="text-muted">Your application is being reviewed by the hiring team.</small>
        <div class="mt-3">
            <button class="btn btn-primary btn-sm me-2"><i class="bi bi-eye"></i> View Details</button>
            <button class="btn btn-outline-secondary btn-sm"><i class="bi bi-x-circle"></i> Withdraw</button>
        </div>
    </div>

    <!-- Application 4 - Under Review -->
    <div class="application-card" style="border-left-color: #ffc107;">
        <div class="d-flex justify-content-between align-items-start mb-3">
            <div>
                <h5 class="mb-1">Frontend Developer</h5>
                <p class="text-muted mb-1">Accenture • Mumbai</p>
                <small class="text-muted"><i class="bi bi-calendar3"></i> Applied on: Oct 15, 2024</small>
            </div>
            <span class="status-badge status-pending">UNDER REVIEW</span>
        </div>
        <p class="mb-2"><strong>Applied for:</strong> Full Time • 4-7 LPA • 1-3 Years Experience</p>
        <div class="progress mb-2" style="height: 8px;">
            <div class="progress-bar bg-warning" style="width: 30%;"></div>
        </div>
        <small class="text-muted">Application received. Waiting for initial screening.</small>
        <div class="mt-3">
            <button class="btn btn-primary btn-sm me-2"><i class="bi bi-eye"></i> View Details</button>
            <button class="btn btn-outline-secondary btn-sm"><i class="bi bi-x-circle"></i> Withdraw</button>
        </div>
    </div>

    <!-- Application 5 - Rejected -->
    <div class="application-card" style="border-left-color: #dc3545;">
        <div class="d-flex justify-content-between align-items-start mb-3">
            <div>
                <h5 class="mb-1">Backend Developer</h5>
                <p class="text-muted mb-1">Tech Mahindra • Chennai</p>
                <small class="text-muted"><i class="bi bi-calendar3"></i> Applied on: Oct 10, 2024</small>
            </div>
            <span class="status-badge status-rejected">REJECTED</span>
        </div>
        <p class="mb-2"><strong>Applied for:</strong> Full Time • 7-10 LPA • 3-5 Years Experience</p>
        <div class="alert alert-danger mb-0">
            <i class="bi bi-x-circle-fill me-2"></i>
            Unfortunately, your application was not shortlisted for this position. Keep trying!
        </div>
        <div class="mt-3">
            <button class="btn btn-outline-primary btn-sm me-2"><i class="bi bi-eye"></i> View Feedback</button>
            <button class="btn btn-outline-secondary btn-sm"><i class="bi bi-archive"></i> Archive</button>
        </div>
    </div>

    <!-- Pagination -->
    <nav class="mt-4">
        <ul class="pagination justify-content-center">
            <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">Next</a></li>
        </ul>
    </nav>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>