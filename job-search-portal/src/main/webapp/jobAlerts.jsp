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
    <title>Job Alerts</title>
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

        .alert-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border-left: 4px solid #0d6efd;
            transition: all 0.3s;
        }

        .alert-card:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.12);
            transform: translateX(5px);
        }

        .alert-card.active {
            border-left-color: #198754;
            background: #f8fff8;
        }

        .alert-card.inactive {
            border-left-color: #6c757d;
            opacity: 0.7;
        }

        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: 0.4s;
            border-radius: 24px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 16px;
            width: 16px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: 0.4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: #198754;
        }

        input:checked + .slider:before {
            transform: translateX(26px);
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
    <a href="savedJobs.jsp"><i class="bi bi-bookmark-fill me-2"></i>Saved Jobs</a>
    <a href="jobAlerts.jsp" class="active"><i class="bi bi-bell-fill me-2"></i>Job Alerts</a>
    <a href="editProfile.jsp"><i class="bi bi-person-circle me-2"></i>My Profile</a>
    <a href="myResume.jsp"><i class="bi bi-file-earmark-pdf-fill me-2"></i>My Resume</a>
    <a href="logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="content">

    <h2 class="mb-4"><i class="bi bi-bell-fill me-2"></i>Job Alerts</h2>

    <div class="row mb-4">
        <div class="col-md-8">
            <div class="alert alert-info">
                <i class="bi bi-info-circle-fill me-2"></i>
                Set up job alerts to get notified when new jobs matching your preferences are posted!
            </div>
        </div>
        <div class="col-md-4 text-end">
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createAlertModal">
                <i class="bi bi-plus-circle me-2"></i>Create New Alert
            </button>
        </div>
    </div>

    <!-- Active Alerts -->
    <h5 class="mb-3">Active Alerts (3)</h5>

    <!-- Alert 1 -->
    <div class="alert-card active">
        <div class="d-flex justify-content-between align-items-start">
            <div class="flex-grow-1">
                <div class="d-flex align-items-center mb-2">
                    <span class="badge bg-success me-2">ACTIVE</span>
                    <h5 class="mb-0">Java Developer Jobs</h5>
                </div>
                <p class="text-muted mb-2">
                    <i class="bi bi-search me-2"></i><strong>Keywords:</strong> Java, Spring Boot, Microservices
                </p>
                <p class="text-muted mb-2">
                    <i class="bi bi-geo-alt-fill me-2"></i><strong>Location:</strong> Bangalore, Pune
                </p>
                <p class="text-muted mb-2">
                    <i class="bi bi-currency-rupee me-2"></i><strong>Salary:</strong> 8-15 LPA
                </p>
                <p class="text-muted mb-0">
                    <i class="bi bi-envelope me-2"></i><strong>Frequency:</strong> Daily • Last sent 2 hours ago
                </p>
            </div>
            <div class="d-flex flex-column align-items-end">
                <label class="toggle-switch mb-3">
                    <input type="checkbox" checked>
                    <span class="slider"></span>
                </label>
                <button class="btn btn-outline-primary btn-sm mb-2"><i class="bi bi-pencil"></i> Edit</button>
                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> Delete</button>
            </div>
        </div>
    </div>

    <!-- Alert 2 -->
    <div class="alert-card active">
        <div class="d-flex justify-content-between align-items-start">
            <div class="flex-grow-1">
                <div class="d-flex align-items-center mb-2">
                    <span class="badge bg-success me-2">ACTIVE</span>
                    <h5 class="mb-0">Full Stack Developer</h5>
                </div>
                <p class="text-muted mb-2">
                    <i class="bi bi-search me-2"></i><strong>Keywords:</strong> React, Node.js, MERN Stack
                </p>
                <p class="text-muted mb-2">
                    <i class="bi bi-geo-alt-fill me-2"></i><strong>Location:</strong> Remote, Hybrid
                </p>
                <p class="text-muted mb-2">
                    <i class="bi bi-currency-rupee me-2"></i><strong>Salary:</strong> 6-12 LPA
                </p>
                <p class="text-muted mb-0">
                    <i class="bi bi-envelope me-2"></i><strong>Frequency:</strong> Weekly • Last sent 3 days ago
                </p>
            </div>
            <div class="d-flex flex-column align-items-end">
                <label class="toggle-switch mb-3">
                    <input type="checkbox" checked>
                    <span class="slider"></span>
                </label>
                <button class="btn btn-outline-primary btn-sm mb-2"><i class="bi bi-pencil"></i> Edit</button>
                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> Delete</button>
            </div>
        </div>
    </div>

    <!-- Alert 3 -->
    <div class="alert-card active">
        <div class="d-flex justify-content-between align-items-start">
            <div class="flex-grow-1">
                <div class="d-flex align-items-center mb-2">
                    <span class="badge bg-success me-2">ACTIVE</span>
                    <h5 class="mb-0">Python Developer</h5>
                </div>
                <p class="text-muted mb-2">
                    <i class="bi bi-search me-2"></i><strong>Keywords:</strong> Python, Django, FastAPI
                </p>
                <p class="text-muted mb-2">
                    <i class="bi bi-geo-alt-fill me-2"></i><strong>Location:</strong> Any Location
                </p>
                <p class="text-muted mb-2">
                    <i class="bi bi-currency-rupee me-2"></i><strong>Salary:</strong> 5-10 LPA
                </p>
                <p class="text-muted mb-0">
                    <i class="bi bi-envelope me-2"></i><strong>Frequency:</strong> Instant • Last sent 5 hours ago
                </p>
            </div>
            <div class="d-flex flex-column align-items-end">
                <label class="toggle-switch mb-3">
                    <input type="checkbox" checked>
                    <span class="slider"></span>
                </label>
                <button class="btn btn-outline-primary btn-sm mb-2"><i class="bi bi-pencil"></i> Edit</button>
                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> Delete</button>
            </div>
        </div>
    </div>

    <!-- Inactive Alerts -->
    <h5 class="mb-3 mt-4">Inactive Alerts (1)</h5>

    <!-- Alert 4 -->
    <div class="alert-card inactive">
        <div class="d-flex justify-content-between align-items-start">
            <div class="flex-grow-1">
                <div class="d-flex align-items-center mb-2">
                    <span class="badge bg-secondary me-2">INACTIVE</span>
                    <h5 class="mb-0">DevOps Engineer</h5>
                </div>
                <p class="text-muted mb-2">
                    <i class="bi bi-search me-2"></i><strong>Keywords:</strong> AWS, Docker, Kubernetes
                </p>
                <p class="text-muted mb-2">
                    <i class="bi bi-geo-alt-fill me-2"></i><strong>Location:</strong> Bangalore, Hyderabad
                </p>
                <p class="text-muted mb-2">
                    <i class="bi bi-currency-rupee me-2"></i><strong>Salary:</strong> 10-18 LPA
                </p>
                <p class="text-muted mb-0">
                    <i class="bi bi-envelope me-2"></i><strong>Frequency:</strong> Daily • Paused
                </p>
            </div>
            <div class="d-flex flex-column align-items-end">
                <label class="toggle-switch mb-3">
                    <input type="checkbox">
                    <span class="slider"></span>
                </label>
                <button class="btn btn-outline-primary btn-sm mb-2"><i class="bi bi-pencil"></i> Edit</button>
                <button class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> Delete</button>
            </div>
        </div>
    </div>

</div>

<!-- Create Alert Modal -->
<div class="modal fade" id="createAlertModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="bi bi-plus-circle me-2"></i>Create New Job Alert</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label class="form-label">Alert Name</label>
                        <input type="text" class="form-control" placeholder="e.g., Java Developer Jobs">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Keywords</label>
                        <input type="text" class="form-control" placeholder="e.g., Java, Spring Boot">
                        <small class="text-muted">Separate multiple keywords with commas</small>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Location</label>
                            <input type="text" class="form-control" placeholder="e.g., Bangalore">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Experience</label>
                            <select class="form-select">
                                <option>Any Experience</option>
                                <option>0-1 Years</option>
                                <option>1-3 Years</option>
                                <option>3-5 Years</option>
                                <option>5+ Years</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Minimum Salary (LPA)</label>
                            <input type="number" class="form-control" placeholder="e.g., 5">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Maximum Salary (LPA)</label>
                            <input type="number" class="form-control" placeholder="e.g., 10">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Alert Frequency</label>
                        <select class="form-select">
                            <option>Instant (as soon as posted)</option>
                            <option>Daily Digest</option>
                            <option>Weekly Digest</option>
                        </select>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="emailNotif" checked>
                        <label class="form-check-label" for="emailNotif">
                            Send email notifications
                        </label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary">Create Alert</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>