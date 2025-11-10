<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employer Login - DreamJob</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background: #f0f8ff;">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-lg border-0">
                    <div class="card-body p-4">
                        <h3 class="text-center text-primary mb-4">Employer Login</h3>

                        <!-- ✅ Login Form -->
                        <form action="EmployerLoginServlet" method="post" class="login-form">
                            <div class="mb-3">
                                <label>Email</label>
                                <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                            </div>

                            <div class="mb-3">
                                <label>Password</label>
                                <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Login</button>
                            </div>

                            <div class="text-center mt-3">
                                <small>Don't have an account? <a href="register.jsp">Register here</a></small>
                            </div>
                        </form>

                        <!-- ✅ Error Message -->
                        <% if (request.getParameter("error") != null) { %>
                            <p class="text-danger text-center mt-3">
                                <%= request.getParameter("error") %>
                            </p>
                        <% } %>

                        <!-- ✅ Success Message After Register -->
                        <% if ("success".equals(request.getParameter("msg"))) { %>
                            <p class="text-success text-center mt-3">
                                Registration successful! Please login now.
                            </p>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
