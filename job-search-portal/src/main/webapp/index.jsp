<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Portal - Find Your Dream Job</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f5576c 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            width: 100%;
        }
        .hero {
            text-align: center;
            color: white;
            margin-bottom: 50px;
        }
        .hero h1 {
            font-size: 48px;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        .hero p {
            font-size: 20px;
            margin-bottom: 30px;
            opacity: 0.95;
        }
        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }
        .card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            text-align: center;
            transition: transform 0.3s;
        }
        .card:hover {
            transform: translateY(-10px);
        }
        .card h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 28px;
        }
        .card p {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .btn-group {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .btn {
            padding: 14px 30px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s;
            display: inline-block;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        .btn-secondary {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }
        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(245, 87, 108, 0.4);
        }
        .icon {
            font-size: 60px;
            margin-bottom: 20px;
        }
        .footer {
            text-align: center;
            color: white;
            margin-top: 40px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="hero">
            <h1>🚀 Welcome to Job Portal</h1>
            <p>Connect talented professionals with great opportunities</p>
        </div>

        <div class="cards-container">
            <div class="card">
                <div class="icon">👨‍💼</div>
                <h2>For Candidates</h2>
                <p>Find your dream job from thousands of opportunities. Build your profile and apply easily.</p>
                <div class="btn-group">
                    <a href="candidate-login.jsp" class="btn btn-primary">Login</a>
                    <a href="candidate-register.jsp" class="btn btn-primary">Register</a>
                </div>
            </div>

            <div class="card">
                <div class="icon">🏢</div>
                <h2>For Employers</h2>
                <p>Post jobs and find the perfect candidates. Manage applications efficiently.</p>
                <div class="btn-group">
                    <a href="employer-login.jsp" class="btn btn-secondary">Login</a>
                    <a href="employer-register.jsp" class="btn btn-secondary">Register</a>
                </div>
            </div>
        </div>

        <div class="footer">
            <p>&copy; 2024 Job Portal. All rights reserved.</p>
        </div>
    </div>
</body>
</html>