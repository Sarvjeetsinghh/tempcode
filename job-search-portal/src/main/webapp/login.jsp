<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Job Portal</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #C6F2FF, #A2E2FF);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .login-box {
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(10px);
            border-radius: 25px;
            padding: 40px 35px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.3);
            width: 380px;
            text-align: center;
        }

        .login-box h2 {
            color: #004E8F;
            font-weight: 600;
            margin-bottom: 25px;
        }

        .form-control {
            border-radius: 20px;
            border: none;
            padding: 12px 15px;
            background-color: rgba(255, 255, 255, 0.8);
        }

        .form-control:focus {
            box-shadow: 0 0 8px #7DD3FC;
        }

        .btn-login {
            width: 100%;
            background: linear-gradient(135deg, #007BFF, #00C6FF);
            color: white;
            font-weight: 500;
            border: none;
            border-radius: 25px;
            padding: 12px;
            transition: 0.3s;
        }

        .btn-login:hover {
            background: linear-gradient(135deg, #0099FF, #33D4FF);
            transform: scale(1.03);
        }

        .extra-links {
            margin-top: 20px;
            font-size: 14px;
        }

        .extra-links a {
            color: #004E8F;
            text-decoration: none;
            font-weight: 500;
        }

        .extra-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-box">
    <h2>Login</h2>

    <form action="LoginServlet" method="post">
        <div class="mb-3">
            <input type="text" name="email" class="form-control" placeholder="Enter Email" required>
        </div>
        <div class="mb-3">
            <input type="password" name="password" class="form-control" placeholder="Enter Password" required>
        </div>

        <button type="submit" class="btn-login">Login</button>

        <div class="extra-links mt-3">
            <p>Don't have an account? <a href="register.jsp">Register Here</a></p>
        </div>
    </form>
</div>

</body>
</html>
