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
    <title>Browse Jobs</title>
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
        }

        .job-card:hover {
            border-color: #0d6efd;
            box-shadow: 0 4px 12px rgba(13, 110, 253, 0.15);
            transform: translateY(-2px);
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

        .filter-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            position: sticky;
            top: 20px;
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
    <a href="browseJobs.jsp" class="active"><i class="bi bi-search me-2"></i>Browse Jobs</a>
    <a href="myApplications.jsp"><i class="bi bi-file-text-fill me-2"></i>Applications</a>
    <a href="savedJobs.jsp"><i class="bi bi-bookmark-fill me-2"></i>Saved Jobs</a>
    <a href="jobAlerts.jsp"><i class="bi bi-bell-fill me-2"></i>Job Alerts</a>
    <a href="editProfile.jsp"><i class="bi bi-person-circle me-2"></i>My Profile</a>
    <a href="myResume.jsp"><i class="bi bi-file-earmark-pdf-fill me-2"></i>My Resume</a>
    <a href="logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="content">

    <h2 class="mb-4"><i class="bi bi-search me-2"></i>Browse Jobs</h2>

    <div class="row">
        <!-- FILTERS SIDEBAR -->
        <div class="col-lg-3">
            <div class="filter-card">
                <h5 class="mb-3">Filters</h5>
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Search</label>
                    <input type="text" class="form-control" placeholder="Job title, keyword...">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Location</label>
                    <select class="form-select">
                        <option>All Locations</option>
                        <option>Bangalore</option>
                        <option>Mumbai</option>
                        <option>Pune</option>
                        <option>Hyderabad</option>
                        <option>Delhi</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Experience</label>
                    <select class="form-select">
                        <option>Any Experience</option>
                        <option>0-1 Years</option>
                        <option>1-3 Years</option>
                        <option>3-5 Years</option>
                        <option>5+ Years</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Job Type</label>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="fulltime">
                        <label class="form-check-label" for="fulltime">Full Time</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="parttime">
                        <label class="form-check-label" for="parttime">Part Time</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="contract">
                        <label class="form-check-label" for="contract">Contract</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="internship">
                        <label class="form-check-label" for="internship">Internship</label>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Salary Range</label>
                    <select class="form-select">
                        <option>Any Salary</option>
                        <option>0-3 LPA</option>
                        <option>3-6 LPA</option>
                        <option>6-10 LPA</option>
                        <option>10-15 LPA</option>
                        <option>15+ LPA</option>
                    </select>
                </div>

                <button class="btn btn-primary w-100">Apply Filters</button>
                <button class="btn btn-outline-secondary w-100 mt-2">Clear All</button>
            </div>
        </div>

        <!-- JOB LISTINGS -->
        <div class="col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <p class="text-muted mb-0">Showing <strong>245</strong> jobs</p>
                <select class="form-select w-auto">
                    <option>Most Recent</option>
                    <option>Salary: High to Low</option>
                    <option>Salary: Low to High</option>
                    <option>Most Relevant</option>
                </select>
            </div>

            <!-- Job Card 1 -->
            <div class="job-card p-4">
                <div class="d-flex">
                    <div class="company-logo me-3">TCS</div>
                    <div class="flex-grow-1">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <div>
                                <h5 class="mb-1">Senior Java Developer</h5>
                                <p class="text-muted mb-0">Tata Consultancy Services</p>
                            </div>
                            <button class="btn btn-outline-primary btn-sm"><i class="bi bi-bookmark"></i> Save</button>
                        </div>
                        <div class="mb-3">
                            <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-geo-alt-fill"></i> Bangalore</span>
                            <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-currency-rupee"></i> 8-12 LPA</span>
                            <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-briefcase"></i> 3-5 Years</span>
                            <span class="badge-custom bg-success text-white">Full Time</span>
                        </div>
                        <p class="mb-2"><strong>Required Skills:</strong> Java, Spring Boot, Microservices, MySQL, AWS</p>
                        <p class="text-muted small mb-3">We are looking for an experienced Java developer to join our team. The ideal candidate should have strong knowledge of Spring framework and microservices architecture.</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <small class="text-muted"><i class="bi bi-clock"></i> Posted 2 days ago</small>
                            <button class="btn btn-primary">Apply Now</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Job Card 2 -->
            <div class="job-card p-4">
                <div class="d-flex">
                    <div class="company-logo me-3">INF</div>
                    <div class="flex-grow-1">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <div>
                                <h5 class="mb-1">Full Stack Developer</h5>
                                <p class="text-muted mb-0">Infosys Limited</p>
                            </div>
                            <button class="btn btn-outline-primary btn-sm"><i class="bi bi-bookmark"></i> Save</button>
                        </div>
                        <div class="mb-3">
                            <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-geo-alt-fill"></i> Pune</span>
                            <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-currency-rupee"></i> 6-10 LPA</span>
                            <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-briefcase"></i> 2-4 Years</span>
                            <span class="badge-custom bg-success text-white">Full Time</span>
                        </div>
                        <p class="mb-2"><strong>Required Skills:</strong> React, Node.js, MongoDB, Express, TypeScript</p>
                        <p class="text-muted small mb-3">Join our dynamic team as a Full Stack Developer. Work on cutting-edge technologies and build scalable web applications.</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <small class="text-muted"><i class="bi bi-clock"></i> Posted 5 days ago</small>
                            <button class="btn btn-primary">Apply Now</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Job Card 3 -->
            <div class="job-card p-4">
                <div class="d-flex">
                    <div class="company-logo me-3">WIP</div>
                    <div class="flex-grow-1">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <div>
                                <h5 class="mb-1">Python Developer</h5>
                                <p class="text-muted mb-0">Wipro Technologies</p>
                            </div>
                            <button class="btn btn-outline-primary btn-sm"><i class="bi bi-bookmark"></i> Save</button>
                        </div>
                        <div class="mb-3">
                            <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-geo-alt-fill"></i> Hyderabad</span>
                            <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-currency-rupee"></i> 5-8 LPA</span>
                            <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-briefcase"></i> 1-3 Years</span>
                            <span class="badge-custom bg-info text-white">Hybrid</span>
                        </div>
                        <p class="mb-2"><strong>Required Skills:</strong> Python, Django, REST API, PostgreSQL, Docker</p>
                        <p class="text-muted small mb-3">Seeking a talented Python developer to work on enterprise-level applications. Experience with Django and REST APIs is essential.</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <small class="text-muted"><i class="bi bi-clock"></i> Posted 1 week ago</small>
                            <button class="btn btn-primary">Apply Now</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Job Card 4 -->
            <div class="job-card p-4">
                <div class="d-flex">
                    <div class="company-logo me-3">ACC</div>
                    <div class="flex-grow-1">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <div>
                                <h5 class="mb-1">Frontend Developer</h5>
                                <p class="text-muted mb-0">Accenture</p>
                            </div>
                            <button class="btn btn-outline-primary btn-sm"><i class="bi bi-bookmark"></i> Save</button>
                        </div>
                        <div class="mb-3">
                            <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-geo-alt-fill"></i> Mumbai</span>
                            <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-currency-rupee"></i> 4-7 LPA</span>
                            <span class="badge-custom bg-light text-dark me-2"><i class="bi bi-briefcase"></i> 1-3 Years</span>
                            <span class="badge-custom bg-success text-white">Full Time</span>
                        </div>
                        <p class="mb-2"><strong>Required Skills:</strong> React, JavaScript, HTML5, CSS3, Redux</p>
                        <p class="text-muted small mb-3">Looking for a creative Frontend Developer to build responsive and user-friendly web interfaces using modern frameworks.</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <small class="text-muted"><i class="bi bi-clock"></i> Posted 3 days ago</small>
                            <button class="btn btn-primary">Apply Now</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pagination -->
            <nav>
                <ul class="pagination justify-content-center">
                    <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">4</a></li>
                    <li class="page-item"><a class="page-link" href="#">Next</a></li>
                </ul>
            </nav>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>