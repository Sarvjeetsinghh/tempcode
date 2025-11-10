<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employer Registration - DreamJob</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #e0f7fa, #e1bee7);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .register-box {
            background: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 600px;
        }
        .btn-custom {
            background: #6a1b9a;
            color: white;
            border: none;
            border-radius: 30px;
            width: 100%;
            padding: 10px;
            font-size: 16px;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background: #4a148c;
            transform: scale(1.02);
        }
        h3 {
            color: #4a148c;
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
        }
        .bottom-text {
            text-align: center;
            margin-top: 20px;
        }
        .bottom-text a {
            color: #6a1b9a;
            text-decoration: none;
            font-weight: 500;
        }
        .bottom-text a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="register-box">
    <h3>Employer Registration</h3>

    <form action="EmployerRegisterServlet" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">Company Name</label>
            <input type="text" class="form-control" name="name" placeholder="Enter company name" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <input type="email" class="form-control" name="email" placeholder="Enter email" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" class="form-control" name="password" placeholder="Enter password" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Contact Person</label>
            <input type="text" class="form-control" name="person" placeholder="Enter contact person name" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Designation</label>
            <input type="text" class="form-control" name="designation" placeholder="Enter designation" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Company Logo</label>
            <input type="file" class="form-control" name="logo" accept="image/*">
        </div>

        <button type="submit" class="btn btn-custom">Register</button>

        <div class="bottom-text">
            Already have an account? <a href="employer_login.jsp">Login here</a>
        </div>
    </form>
</div>

</body>
</html>
