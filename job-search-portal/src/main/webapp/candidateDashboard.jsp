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

        /* MAIN CONTENT */
        .content {
            margin-left: 270px;
            padding: 30px;
        }

        /* STAT CARDS */
        .stat-card {
            border-radius: 15px;
            border: none;
            transition: all 0.3s;
            background: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
        }

        .stat-card .icon-box {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .stat-card.primary .icon-box { background: #e7f1ff; color: #0d6efd; }
        .stat-card.success .icon-box { background: #d1e7dd; color: #198754; }
        .stat-card.warning .icon-box { background: #fff3cd; color: #ffc107; }
        .stat-card.info .icon-box { background: #cff4fc; color: #0dcaf0; }

        /* JOB CARDS */
        .job-card {
            border-radius: 12px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s;
            background: white;
            margin-bottom: 15px;
        }

        .job-card:hover {
            border-color: #0d6efd;
            box-shadow: 0 4px 12px rgba(13, 110, 253, 0.15);
        }

        .company-logo {
            width: 50px;
            height: 50px;
            border-radius: 8px;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: #0d6efd;
        }

        .badge-custom {
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
        }

        /* PROFILE QUICK VIEW */
        .profile-quick {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            color: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(13, 110, 253, 0.3);
        }

        .profile-avatar {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            border: 3px solid white;
            object-fit: cover;
        }

        /* RESPONSIVE */
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
    <a href="candidateDashboard.jsp" class="active"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
    <a href="broweJobs.jsp"><i class="bi bi-search me-2"></i>Browse Jobs</a>
    <a href="myApplication.jsp"><i class="bi bi-file-text-fill me-2"></i>Applications</a>
    <a href="savedJobs.jsp"><i class="bi bi-bookmark-fill me-2"></i>Saved Jobs</a>
    <a href="jobAlerts.jsp"><i class="bi bi-bell-fill me-2"></i>Job Alerts</a>
    <a href="editProfile.jsp"><i class="bi bi-person-circle me-2"></i>My Profile</a>
    <a href="myResume.jsp"><i class="bi bi-file-earmark-pdf-fill me-2"></i>My Resume</a>
    <a href="logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="content">

    <!-- HEADER WITH QUICK PROFILE -->
    <div class="profile-quick mb-4">
        <div class="row align-items-center">
            <div class="col-md-8">
                <div class="d-flex align-items-center">
                    <img src="<%= request.getContextPath() + "/" + 
                           (candidate.getProfilePicture() != null && !candidate.getProfilePicture().isEmpty()
                            ? candidate.getProfilePicture() : "images/default.png") %>"
                         class="profile-avatar me-3" alt="Profile">
                    <div>
                        <h3 class="mb-1">Welcome back, <%= candidate.getFullName() %>!</h3>
                        <p class="mb-0 opacity-75"><i class="bi bi-briefcase me-2"></i><%= candidate.getCategory() != null ? candidate.getCategory() : "Job Seeker" %></p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                <% if (completion < 100) { %>
                <div class="alert alert-warning mb-0 d-inline-block">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <small>Profile <%= completion %>% complete</small>
                    <a href="editProfile.jsp" class="text-dark ms-2"><strong>Complete Now</strong></a>
                </div>
                <% } else { %>
                <div class="alert alert-success mb-0 d-inline-block">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    <small>Profile Complete!</small>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- STATISTICS CARDS -->
    <div class="row mb-4">
        <div class="col-md-3 col-sm-6 mb-3">
            <div class="stat-card card primary">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="text-muted mb-1">Applications</p>
                            <h3 class="mb-0">0</h3>
                        </div>
                        <div class="icon-box">
                            <i class="bi bi-file-text-fill"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-3">
            <div class="stat-card card success">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="text-muted mb-1">Shortlisted</p>
                            <h3 class="mb-0">0</h3>
                        </div>
                        <div class="icon-box">
                            <i class="bi bi-check-circle-fill"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-3">
            <div class="stat-card card warning">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="text-muted mb-1">Saved Jobs</p>
                            <h3 class="mb-0">0</h3>
                        </div>
                        <div class="icon-box">
                            <i class="bi bi-bookmark-fill"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-3">
            <div class="stat-card card info">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="text-muted mb-1">Profile Views</p>
                            <h3 class="mb-0"></h3>
                        </div>
                        <div class="icon-box">
                            <i class="bi bi-eye-fill"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- RECOMMENDED JOBS -->
        <div class="col-lg-8">
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-white border-0 pt-3">
                    <h5 class="mb-0"><i class="bi bi-stars text-warning me-2"></i>Recommended Jobs For You</h5>
                </div>
                <div class="card-body">
                    
                    <!-- Job Card 1 -->
                    <div class="job-card p-3">
                        <div class="d-flex">
                            <div class="company-logo me-3">TCS</div>
                            <div class="flex-grow-1">
                                <h6 class="mb-1">Senior Java Developer</h6>
                                <p class="text-muted mb-2 small">Tata Consultancy Services • Bangalore, India</p>
                                <div class="mb-2">
                                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-currency-rupee"></i>8-12 LPA</span>
                                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-briefcase"></i>3-5 Years</span>
                                    <span class="badge-custom bg-success text-white">Full Time</span>
                                </div>
                                <p class="small mb-2"><strong>Skills:</strong> <%= candidate.getSkills() != null ? candidate.getSkills() : "Java, Spring Boot, Microservices" %></p>
                            </div>
                            <div class="ms-3">
                                <button class="btn btn-outline-primary btn-sm mb-2 w-100"><i class="bi bi-bookmark"></i></button>
                                <button class="btn btn-primary btn-sm w-100">Apply</button>
                            </div>
                        </div>
                    </div>

                    <!-- Job Card 2 -->
                    <div class="job-card p-3">
                        <div class="d-flex">
                            <div class="company-logo me-3">INF</div>
                            <div class="flex-grow-1">
                                <h6 class="mb-1">Full Stack Developer</h6>
                                <p class="text-muted mb-2 small">Infosys • Pune, India</p>
                                <div class="mb-2">
                                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-currency-rupee"></i>6-10 LPA</span>
                                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-briefcase"></i>2-4 Years</span>
                                    <span class="badge-custom bg-success text-white">Full Time</span>
                                </div>
                                <p class="small mb-2"><strong>Skills:</strong> React, Node.js, MongoDB, Express</p>
                            </div>
                            <div class="ms-3">
                                <button class="btn btn-outline-primary btn-sm mb-2 w-100"><i class="bi bi-bookmark"></i></button>
                                <button class="btn btn-primary btn-sm w-100">Apply</button>
                            </div>
                        </div>
                    </div>

                    <!-- Job Card 3 -->
                    <div class="job-card p-3">
                        <div class="d-flex">
                            <div class="company-logo me-3">WIP</div>
                            <div class="flex-grow-1">
                                <h6 class="mb-1">Software Engineer</h6>
                                <p class="text-muted mb-2 small">Wipro • Hyderabad, India</p>
                                <div class="mb-2">
                                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-currency-rupee"></i>5-8 LPA</span>
                                    <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-briefcase"></i>1-3 Years</span>
                                    <span class="badge-custom bg-info text-white">Hybrid</span>
                                </div>
                                <p class="small mb-2"><strong>Skills:</strong> Python, Django, REST API, PostgreSQL</p>
                            </div>
                            <div class="ms-3">
                                <button class="btn btn-outline-primary btn-sm mb-2 w-100"><i class="bi bi-bookmark"></i></button>
                                <button class="btn btn-primary btn-sm w-100">Apply</button>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-3">
                        <a href="#" class="btn btn-outline-primary">View All Jobs <i class="bi bi-arrow-right ms-2"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- SIDEBAR WIDGETS -->
        <div class="col-lg-4">
            
            <!-- RECENT ACTIVITY -->
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-white border-0 pt-3">
                    <h6 class="mb-0"><i class="bi bi-clock-history me-2"></i>Recent Activity</h6>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <small class="text-muted">2 hours ago</small>
                        <p class="mb-0 small">Applied for <strong>Java Developer</strong> at TCS</p>
                    </div>
                    <div class="mb-3">
                        <small class="text-muted">5 hours ago</small>
                        <p class="mb-0 small">Saved <strong>UI/UX Designer</strong> job</p>
                    </div>
                    <div class="mb-3">
                        <small class="text-muted">1 day ago</small>
                        <p class="mb-0 small">Profile viewed by <strong>Infosys</strong></p>
                    </div>
                    <div>
                        <small class="text-muted">2 days ago</small>
                        <p class="mb-0 small">Updated profile information</p>
                    </div>
                </div>
            </div>

            <!-- PROFILE COMPLETION -->
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-white border-0 pt-3">
                    <h6 class="mb-0"><i class="bi bi-bar-chart-fill me-2"></i>Profile Strength</h6>
                </div>
                <div class="card-body">
                    <div class="progress mb-3" style="height: 8px;">
                        <div class="progress-bar bg-success" style="width: <%= completion %>%;"></div>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="small">Complete</span>
                        <strong><%= completion %>%</strong>
                    </div>
                    <% if (completion < 100) { %>
                    <div class="alert alert-light small mb-0">
                        <i class="bi bi-lightbulb text-warning me-2"></i>
                        Add skills and projects to improve visibility!
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- TIPS -->
            <div class="card shadow-sm border-0" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                <div class="card-body">
                    <h6 class="mb-3"><i class="bi bi-lightbulb-fill me-2"></i>Job Search Tip</h6>
                    <p class="small mb-0">Update your profile regularly and apply to jobs within 24 hours of posting to increase your chances!</p>
                </div>
            </div>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>