<%@ page import="com.iardo.dao.EmployerDAO" %>
<%@ page import="com.iardo.model.Employer" %>
<%@ page import="com.iardo.model.Job" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String fromPostJob = request.getParameter("fromPostJob");

    // Session validation except when redirected after posting job
    if ((session == null || session.getAttribute("userType") == null 
        || !"employer".equals(session.getAttribute("userType")))
        && fromPostJob == null) {

        response.sendRedirect("login.jsp?error=Please+login+as+employer");
        return;
    }

    Integer employerId = (Integer) session.getAttribute("employerId");
    String userEmail = (String) session.getAttribute("userEmail");

    // If coming from post job redirect, session is still valid
    if (employerId == null) {
        response.sendRedirect("login.jsp?error=Invalid+session");
        return;
    }

    EmployerDAO dao = new EmployerDAO();
    Employer employer = dao.getEmployerByEmail(userEmail);

    if (employer == null) {
        response.sendRedirect("login.jsp?error=User+not+found");
        return;
    }

    @SuppressWarnings("unchecked")
    List<Job> jobs = (List<Job>) request.getAttribute("jobs");
    int jobCount = (jobs != null) ? jobs.size() : 0;
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employer Dashboard - DreamJob</title>
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
        }

        .sidebar {
            height: 100vh;
            background: linear-gradient(180deg, #0d6efd 0%, #084298 100%);
            padding-top: 20px;
            position: fixed;
            width: 250px;
            overflow-y: auto;
            box-shadow: 4px 0 15px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .sidebar-header {
            padding: 20px;
            text-align: center;
            color: white;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 10px;
        }

        .sidebar a {
            color: #fff;
            padding: 15px 25px;
            display: block;
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }

        .sidebar a:hover, .sidebar a.active {
            background: rgba(255, 255, 255, 0.1);
            border-left: 4px solid #ffc107;
            padding-left: 30px;
        }

        .content {
            margin-left: 270px;
            padding: 30px;
        }

        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }

        .stats-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
        }

        .job-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }

        .job-card:hover {
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.15);
            transform: translateX(5px);
        }

        .badge-custom {
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 12px;
        }

        @media (max-width: 992px) {
            .content {
                margin-left: 0;
                margin-top: 70px;
            }

            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
            }
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <h4><i class="fas fa-building"></i> DreamJob</h4>
        <p class="mb-0"><%= employer.getCompanyName() %></p>
    </div>
    <a href="employerDashboard" class="active">
        <i class="fas fa-home"></i> Dashboard
    </a>
    <a href="postJob.jsp">
        <i class="fas fa-plus-circle"></i> Post New Job
    </a>
    <a href="manageJobs.jsp">
        <i class="fas fa-briefcase"></i> Manage Jobs
    </a>
    <a href="applications.jsp">
        <i class="fas fa-file-alt"></i> Applications
    </a>
    <a href="employerProfile.jsp">
        <i class="fas fa-user-tie"></i> Company Profile
    </a>
    <a href="logout">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>
</div>

<!-- MAIN CONTENT -->
<div class="content">

    <!-- Welcome Header -->
    <div class="card mb-4" style="border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.1);">
        <div class="card-body p-4">
            <div class="d-flex align-items-center justify-content-between flex-wrap">
                <div>
                    <h3 class="mb-1">Welcome back, <%= employer.getCompanyName() %>! 👋</h3>
                    <p class="text-muted mb-0">
                        <i class="fas fa-envelope"></i> <%= employer.getEmail() %>
                    </p>
                </div>
                <a href="postJob.jsp" class="btn btn-primary btn-lg">
                    <i class="fas fa-plus"></i> Post New Job
                </a>
            </div>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="stats-card">
                <div class="d-flex align-items-center">
                    <div class="stats-icon bg-primary bg-gradient text-white me-3">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <div>
                        <h6 class="text-muted mb-0">Total Jobs Posted</h6>
                        <h2 class="mb-0"><%= jobCount %></h2>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="stats-card">
                <div class="d-flex align-items-center">
                    <div class="stats-icon bg-success bg-gradient text-white me-3">
                        <i class="fas fa-users"></i>
                    </div>
                    <div>
                        <h6 class="text-muted mb-0">Total Applications</h6>
                        <h2 class="mb-0">0</h2>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="stats-card">
                <div class="d-flex align-items-center">
                    <div class="stats-icon bg-warning bg-gradient text-white me-3">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div>
                        <h6 class="text-muted mb-0">Pending Review</h6>
                        <h2 class="mb-0">0</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Jobs -->
    <div class="card" style="border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.1);">
        <div class="card-header bg-white border-0 p-4">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-list text-primary"></i> Your Posted Jobs</h5>
                <a href="manageJobs.jsp" class="btn btn-sm btn-outline-primary">
                    View All <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </div>
        <div class="card-body p-4">
            <% if (jobs != null && !jobs.isEmpty()) { %>
                <% for (Job job : jobs) { %>
                    <div class="job-card">
                        <div class="d-flex justify-content-between align-items-start flex-wrap">
                            <div class="flex-grow-1">
                                <h5 class="mb-2"><%= job.getTitle() %></h5>
                                <p class="text-muted mb-2">
                                    <i class="fas fa-map-marker-alt text-danger"></i> <%= job.getLocation() %>
                                    <span class="mx-2">|</span>
                                    <i class="fas fa-briefcase text-info"></i> <%= job.getJobType() %>
                                    <span class="mx-2">|</span>
                                    <i class="fas fa-money-bill-wave text-success"></i> <%= job.getSalary() %>
                                </p>
                                <p class="mb-2">
                                    <span class="badge <%= "Active".equals(job.getStatus()) ? "bg-success" : "bg-secondary" %> badge-custom">
                                        <%= job.getStatus() %>
                                    </span>
                                    <span class="badge bg-info badge-custom">
                                        <i class="fas fa-calendar"></i> Posted: <%= job.getPostedDate() %>
                                    </span>
                                </p>
                            </div>
                            <div class="mt-2 mt-md-0">
                                <a href="viewJobApplications.jsp?jobId=<%= job.getId() %>" 
                                   class="btn btn-sm btn-primary me-2">
                                    <i class="fas fa-eye"></i> View Applications
                                </a>
                                <a href="editJob.jsp?id=<%= job.getId() %>" 
                                   class="btn btn-sm btn-warning">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                            </div>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <div class="text-center py-5">
                    <i class="fas fa-inbox fa-4x text-muted mb-3"></i>
                    <h5 class="text-muted">No jobs posted yet</h5>
                    <p class="text-muted">Start by posting your first job opening</p>
                    <a href="postJob.jsp" class="btn btn-primary mt-3">
                        <i class="fas fa-plus"></i> Post Your First Job
                    </a>
                </div>
            <% } %>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>