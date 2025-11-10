<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("employerId") == null) {
        response.sendRedirect("employer_login.jsp?error=Please+login+first");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employer Dashboard - DreamJob</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f7fc;
            font-family: 'Poppins', sans-serif;
        }
        .profile-card {
            max-width: 600px;
            margin: 40px auto;
            border-radius: 15px;
            background: #fff;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .profile-header {
            background: linear-gradient(135deg, #003366, #007bff);
            color: white;
            padding: 25px;
            border-radius: 15px 15px 0 0;
            text-align: center;
        }
        .profile-body {
            padding: 25px;
        }
        .info-item {
            margin-bottom: 10px;
            font-size: 16px;
        }
        .info-item i {
            color: #007bff;
            margin-right: 10px;
        }
        .btn-logout {
            background-color: #dc3545;
            color: white;
            border-radius: 25px;
        }
        .btn-logout:hover {
            background-color: #b02a37;
        }
        .job-form {
            background: #fff;
            border-radius: 15px;
            padding: 25px;
            max-width: 700px;
            margin: 40px auto;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .job-form h4 {
            color: #003366;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

    <!-- Profile Card -->
    <div class="profile-card">
        <div class="profile-header">
            <i class="bi bi-person-circle display-5"></i>
            <h3 class="mt-2"><%= sessionObj.getAttribute("employerName") %></h3>
            <p class="mb-0">Employer Dashboard</p>
        </div>
        <div class="profile-body">
            <div class="info-item"><i class="bi bi-envelope"></i><b>Email:</b> <%= sessionObj.getAttribute("employerEmail") %></div>
            <div class="info-item"><i class="bi bi-briefcase"></i><b>Designation:</b> <%= sessionObj.getAttribute("designation") %></div>
            <div class="info-item"><i class="bi bi-person-badge"></i><b>Contact Person:</b> <%= sessionObj.getAttribute("person") %></div>

            <div class="text-center mt-4">
                <a href="LogoutServlet" class="btn btn-logout px-4"><i class="bi bi-box-arrow-right"></i> Logout</a>
            </div>
        </div>
    </div>

    <!-- Post Job Form -->
    <div class="job-form">
        <h4><i class="bi bi-file-earmark-plus"></i> Post a New Hiring</h4>
        <form action="AddJobServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Job Title</label>
                <input type="text" name="title" class="form-control" placeholder="e.g. Java Developer" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Job Category</label>
                <select name="category" class="form-select" required>
                    <option value="">-- Select Category --</option>
                    <option value="IT & Software">IT & Software</option>
                    <option value="Marketing">Marketing</option>
                    <option value="Finance">Finance</option>
                    <option value="Human Resources">Human Resources</option>
                    <option value="Design">Design</option>
                    <option value="Education">Education</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Job Description</label>
                <textarea name="description" class="form-control" rows="4" placeholder="Write about job responsibilities..." required></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Salary (per month)</label>
                <input type="text" name="salary" class="form-control" placeholder="e.g. ₹30000 - ₹50000">
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-primary px-4"><i class="bi bi-send"></i> Post Job</button>
            </div>
        </form>
    </div>

</body>
</html>
