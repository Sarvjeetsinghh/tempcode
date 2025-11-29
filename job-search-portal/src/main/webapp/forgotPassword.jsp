<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password - DreamJob</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container" style="margin-top:50px;">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card p-4">
                <h3 class="text-center mb-4 text-primary">Forgot Password</h3>
                
                <form action="${pageContext.request.contextPath}/ForgotPasswordServlet" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-bold">I am a</label>
                        <select name="userType" class="form-select" required>
                            <option value="">-- Select User Type --</option>
                            <option value="candidate">Job Seeker / Candidate</option>
                            <option value="employer">Employer / Recruiter</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Email Address</label>
                        <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-warning btn-lg">Send OTP</button>
                    </div>
                </form>
                
                <% if(request.getParameter("msg") != null) { %>
                    <div class="alert alert-info mt-3 text-center">
                        <%= request.getParameter("msg").replace("+"," ") %>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>
</body>
</html>
