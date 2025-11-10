<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Candidate Registration - DreamJob</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #D9F8FF, #C8F7D9);
            min-height: 100vh;
            margin: 0;
        }
        .register-section {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px 15px;
        }
        .register-form {
            background: rgba(255, 255, 255, 0.9);
            width: 100%;
            max-width: 800px;
            padding: 45px 55px;
            border-radius: 25px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            font-weight: 600;
            color: #004e64;
            margin-bottom: 10px;
        }
        h5 {
            text-align: center;
            color: #666;
            font-weight: 400;
            margin-bottom: 35px;
        }
        .form-label {
            font-weight: 500;
            color: #004e64;
        }
        .form-control {
            height: 50px;
            border-radius: 10px;
            border: 1px solid #c5e3e8;
        }
        .form-control:focus {
            border-color: #66d2ff;
            box-shadow: 0 0 8px #99e6ff;
        }
        .btn-register {
            background-color: #d36ea8;
            border: none;
            color: #fff;
            font-weight: 500;
            width: 100%;
            border-radius: 30px;
            padding: 12px 0;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        .btn-register:hover {
            background-color: #b45c90;
            transform: scale(1.02);
        }
        .bottom-text {
            text-align: center;
            margin-top: 25px;
            color: #555;
            font-size: 15px;
        }
        .bottom-text a {
            color: #d36ea8;
            text-decoration: none;
            font-weight: 500;
        }
        .bottom-text a:hover {
            text-decoration: underline;
        }
        .alert {
            text-align: center;
            border-radius: 10px;
        }
        .otp-section {
            margin-top: 10px;
        }
        @media (max-width: 768px) {
            .register-form {
                padding: 35px 25px;
            }
        }
    </style>
</head>
<body>

<section class="register-section">
    <div class="register-form">
        <h2>Candidate Registration</h2>
        <h5>Join thousands of professionals and find your dream job!</h5>

        <!-- Display success/error message -->
        <%
            String msg = request.getParameter("msg");
            if ("success".equals(msg)) {
        %>
            <div class="alert alert-success">Registration Successful! Please login now.</div>
        <% } else if ("error".equals(msg)) { %>
            <div class="alert alert-danger">Something went wrong. Try again.</div>
        <% } %>

        <form action="register" method="post" enctype="multipart/form-data">
            <div class="row g-3">
                <!-- Full Name -->
                <div class="col-md-6">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="fullname" class="form-control" placeholder="Enter your full name" required>
                </div>

                <!-- Email -->
                <div class="col-md-6">
                    <label class="form-label">Email Address</label>
                    <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                </div>

                <!-- Password -->
                <div class="col-md-6">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Create password" required>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Confirm Password</label>
                    <input type="password" name="confirmPassword" class="form-control" placeholder="Re-enter password" required>
                </div>

                <!-- Profile Picture -->
                <div class="col-md-6">
                    <label class="form-label">Profile Picture</label>
                    <input type="file" name="profilePic" class="form-control" accept="image/*">
                </div>

                <!-- Gender -->
                <div class="col-md-6">
                    <label class="form-label">Gender</label>
                    <select name="gender" class="form-control" required>
                        <option value="">-- Select Gender --</option>
                        <option>Male</option>
                        <option>Female</option>
                        <option>Other</option>
                    </select>
                </div>

                <!-- Date of Birth -->
                <div class="col-md-6">
                    <label class="form-label">Date of Birth</label>
                    <input type="date" name="dob" class="form-control" required>
                </div>

                <!-- Phone Number + Send OTP -->
                <div class="col-md-6 otp-section">
                    <label class="form-label">Phone Number</label>
                    <div class="input-group">
                        <input type="text" name="phone" id="phone" class="form-control" placeholder="Enter your phone number" required>
                        <button type="button" class="btn btn-outline-primary" onclick="sendOtp()">Send OTP</button>
                    </div>
                </div>

                <!-- OTP Input -->
                <div class="col-md-6 otp-section">
                    <label class="form-label">Enter OTP</label>
                    <input type="text" name="otp" id="otp" class="form-control" placeholder="Enter OTP received on phone" required>
                </div>

                <!-- Experience -->
                <div class="col-md-6">
                    <label class="form-label">Current Experience</label>
                    <input type="text" name="experience" class="form-control" placeholder="e.g. 2 years, Fresher">
                </div>

                <!-- Categories -->
                <div class="col-md-6">
                    <label class="form-label">Categories</label>
                    <select name="category" class="form-control" required>
                        <option value="">-- Select Category --</option>
                        <option>Software Developer</option>
                        <option>Web Designer</option>
                        <option>Data Analyst</option>
                        <option>Marketing</option>
                        <option>HR & Management</option>
                        <option>Others</option>
                    </select>
                </div>
            </div>

            <button type="submit" class="btn btn-register mt-4">Register</button>

            <div class="bottom-text">
                Already have an account? <a href="login.jsp">Login here</a>
            </div>
        </form>
    </div>
</section>

<!-- JS to send OTP -->
<script>
function sendOtp() {
    var mobile = document.getElementById("phone").value;
    if (!mobile) {
        alert("Please enter your mobile number!");
        return;
    }

    fetch('send-otp', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'mobile=' + encodeURIComponent(mobile)
    })
    .then(response => response.text())
    .then(data => alert("OTP sent! Check your phone."))
    .catch(error => console.error('Error:', error));
}
</script>

</body>
</html>
