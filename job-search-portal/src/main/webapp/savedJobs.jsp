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
    <title>Saved Jobs</title>
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

        .job-card {
            border-radius: 12px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s;
            background: white;
            margin-bottom: 20px;
            position: relative;
            overflow: hidden;
        }

        .job-card:hover {
            border-color: #0d6efd;
            box-shadow: 0 4px 12px rgba(13, 110, 253, 0.15);
            transform: translateY(-2px);
        }

        .job-card .saved-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #ffc107;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 12px;
        }

        .company-logo {
            width: 60px;
            height: 60px;
            border-radius: 10px;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: #0d6efd;
            font-size: 18px;
        }

        .badge-custom {
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
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
    <a href="myApplications.jsp"><i class="bi bi-file-text-fill me-2"></i>Applications</a>
    <a href="savedJobs.jsp" class="active"><i class="bi bi-bookmark-fill me-2"></i>Saved Jobs</a>
    <a href="jobAlerts.jsp"><i class="bi bi-bell-fill me-2"></i>Job Alerts</a>
    <a href="editProfile.jsp"><i class="bi bi-person-circle me-2"></i>My Profile</a>
    <a href="myResume.jsp"><i class="bi bi-file-earmark-pdf-fill me-2"></i>My Resume</a>
    <a href="logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="content">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0"><i class="bi bi-bookmark-fill me-2 text-warning"></i>Saved Jobs</h2>
        <div>
            <button class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> Clear All</button>
        </div>
    </div>

    <div class="alert alert-info">
        <i class="bi bi-info-circle-fill me-2"></i>
        You have <strong>8 jobs</strong> saved. Apply before they expire!
    </div>

    <!-- Saved Job 1 -->
    <div class="job-card p-4">
        <span class="saved-badge"><i class="bi bi-bookmark-fill"></i> Saved</span>
        <div class="d-flex">
            <div class="company-logo me-3">TCS</div>
            <div class="flex-grow-1">
                <h5 class="mb-1">Senior Java Developer</h5>
                <p class="text-muted mb-2">Tata Consultancy Services • Bangalore</p>
                <div class="mb-3">
                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-currency-rupee"></i> 8-12 LPA</span>
                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-briefcase"></i> 3-5 Years</span>
                    <span class="badge-custom bg-success text-white">Full Time</span>
                </div>
                <p class="mb-2"><strong>Required Skills:</strong> Java, Spring Boot, Microservices, MySQL, AWS</p>
                <small class="text-muted"><i class="bi bi-clock"></i> Saved 2 days ago • <i class="bi bi-hourglass-split"></i> Expires in 5 days</small>
            </div>
            <div class="ms-3 d-flex flex-column">
                <button class="btn btn-primary mb-2">Apply Now</button>
                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i> Remove</button>
            </div>
        </div>
    </div>

    <!-- Saved Job 2 -->
    <div class="job-card p-4">
        <span class="saved-badge"><i class="bi bi-bookmark-fill"></i> Saved</span>
        <div class="d-flex">
            <div class="company-logo me-3">INF</div>
            <div class="flex-grow-1">
                <h5 class="mb-1">Full Stack Developer</h5>
                <p class="text-muted mb-2">Infosys Limited • Pune</p>
                <div class="mb-3">
                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-currency-rupee"></i> 6-10 LPA</span>
                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-briefcase"></i> 2-4 Years</span>
                    <span class="badge-custom bg-success text-white">Full Time</span>
                </div>
                <p class="mb-2"><strong>Required Skills:</strong> React, Node.js, MongoDB, Express, TypeScript</p>
                <small class="text-muted"><i class="bi bi-clock"></i> Saved 4 days ago • <i class="bi bi-hourglass-split"></i> Expires in 10 days</small>
            </div>
            <div class="ms-3 d-flex flex-column">
                <button class="btn btn-primary mb-2">Apply Now</button>
                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i> Remove</button>
            </div>
        </div>
    </div>

    <!-- Saved Job 3 -->
    <div class="job-card p-4">
        <span class="saved-badge"><i class="bi bi-bookmark-fill"></i> Saved</span>
        <div class="d-flex">
            <div class="company-logo me-3">WIP</div>
            <div class="flex-grow-1">
                <h5 class="mb-1">Python Developer</h5>
                <p class="text-muted mb-2">Wipro Technologies • Hyderabad</p>
                <div class="mb-3">
                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-currency-rupee"></i> 5-8 LPA</span>
                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-briefcase"></i> 1-3 Years</span>
                    <span class="badge-custom bg-info text-white">Hybrid</span>
                </div>
                <p class="mb-2"><strong>Required Skills:</strong> Python, Django, REST API, PostgreSQL, Docker</p>
                <small class="text-muted"><i class="bi bi-clock"></i> Saved 1 week ago • <i class="bi bi-hourglass-split"></i> Expires in 3 days</small>
            </div>
            <div class="ms-3 d-flex flex-column">
                <button class="btn btn-primary mb-2">Apply Now</button>
                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i> Remove</button>
            </div>
        </div>
    </div>

    <!-- Saved Job 4 -->
    <div class="job-card p-4">
        <span class="saved-badge"><i class="bi bi-bookmark-fill"></i> Saved</span>
        <div class="d-flex">
            <div class="company-logo me-3">ACC</div>
            <div class="flex-grow-1">
                <h5 class="mb-1">Frontend Developer</h5>
                <p class="text-muted mb-2">Accenture • Mumbai</p>
                <div class="mb-3">
                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-currency-rupee"></i> 4-7 LPA</span>
                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-briefcase"></i> 1-3 Years</span>
                    <span class="badge-custom bg-success text-white">Full Time</span>
                </div>
                <p class="mb-2"><strong>Required Skills:</strong> React, JavaScript, HTML5, CSS3, Redux</p>
                <small class="text-muted"><i class="bi bi-clock"></i> Saved 3 days ago • <i class="bi bi-hourglass-split"></i> Expires in 7 days</small>
            </div>
            <div class="ms-3 d-flex flex-column">
                <button class="btn btn-primary mb-2">Apply Now</button>
                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i> Remove</button>
            </div>
        </div>
    </div>

    <!-- Saved Job 5 -->
    <div class="job-card p-4">
        <span class="saved-badge"><i class="bi bi-bookmark-fill"></i> Saved</span>
        <div class="d-flex">
            <div class="company-logo me-3">HCL</div>
            <div class="flex-grow-1">
                <h5 class="mb-1">DevOps Engineer</h5>
                <p class="text-muted mb-2">HCL Technologies • Noida</p>
                <div class="mb-3">
                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-currency-rupee"></i> 9-14 LPA</span>
                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-briefcase"></i> 4-6 Years</span>
                    <span class="badge-custom bg-success text-white">Full Time</span>
                </div>
                <p class="mb-2"><strong>Required Skills:</strong> AWS, Docker, Kubernetes, Jenkins, Terraform</p>
                <small class="text-muted"><i class="bi bi-clock"></i> Saved 1 week ago • <i class="bi bi-hourglass-split"></i> Expires in 2 days</small>
            </div>
            <div class="ms-3 d-flex flex-column">
                <button class="btn btn-primary mb-2">Apply Now</button>
                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i> Remove</button>
            </div>
        </div>
    </div>

    <!-- Saved Job 6 -->
    <div class="job-card p-4">
        <span class="saved-badge"><i class="bi bi-bookmark-fill"></i> Saved</span>
        <div class="d-flex">
            <div class="company-logo me-3">CTS</div>
            <div class="flex-grow-1">
                <h5 class="mb-1">UI/UX Designer</h5>
                <p class="text-muted mb-2">Cognizant • Chennai</p>
                <div class="mb-3">
                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-currency-rupee"></i> 5-9 LPA</span>
                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-briefcase"></i> 2-4 Years</span>
                    <span class="badge-custom bg-info text-white">Hybrid</span>
                </div>
                <p class="mb-2"><strong>Required Skills:</strong> Figma, Adobe XD, Sketch, Prototyping, Wireframing</p>
                <small class="text-muted"><i class="bi bi-clock"></i> Saved 5 days ago • <i class="bi bi-hourglass-split"></i> Expires in 8 days</small>
            </div>
            <div class="ms-3 d-flex flex-column">
                <button class="btn btn-primary mb-2">Apply Now</button>
                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-bookmark-x"></i> Remove</button>
            </div>
        </div>
    </div>

    <!-- Empty State (Show when no saved jobs) -->
    <!-- Uncomment this when there are no saved jobs -->
    <!--
    <div class="text-center py-5">
        <i class="bi bi-bookmark" style="font-size: 80px; color: #ccc;"></i>
        <h4 class="mt-3">No Saved Jobs Yet</h4>
        <p class="text-muted">Start saving jobs you're interested in to apply later!</p>
        <a href="browseJobs.jsp" class="btn btn-primary mt-3">Browse Jobs</a>
    </div>
    -->

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>