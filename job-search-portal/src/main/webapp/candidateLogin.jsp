<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Candidate Login - Job Portal</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f5f7fa;
        }
        .login-box {
            width: 420px;
            margin: 80px auto;
            padding: 30px;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.1);
        }
        .btn-primary {
            width: 100%;
            border-radius: 10px;
        }
        .form-control {
            border-radius: 10px;
        }
    </style>
</head>
<body>

<%
    String error = request.getParameter("error");
    String success = request.getParameter("success");
%>

<div class="login-box">
    <h3 class="text-center mb-3 fw-bold text-primary">Candidate Login</h3>

    <!-- Success Message -->
    <% if (success != null) { %>
        <div class="alert alert-success"><%= success %></div>
    <% } %>

    <!-- Error Message -->
    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <form action="login" method="post">
        <input type="hidden" name="userType" value="candidate">

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required/>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required/>
        </div>

        <button type="submit" class="btn btn-primary">Login</button>

        <p class="mt-3 text-center">
            <a href="candidateRegister.jsp">Create Account</a> |
            <a href="forgotPassword.jsp">Forgot Password?</a>
        </p>
    </form>
</div>

</body>
</html>
