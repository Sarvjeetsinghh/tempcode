<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verify OTP - DreamJob</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .verify-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0,0,0,0.3);
            animation: slideUp 0.5s ease;
        }
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .card-header-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px 20px 0 0;
            padding: 30px;
            text-align: center;
        }
        .otp-display {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border: 2px dashed #667eea;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            margin: 20px 0;
        }
        .otp-code {
            font-size: 2.5rem;
            font-weight: bold;
            color: #667eea;
            letter-spacing: 8px;
            font-family: 'Courier New', monospace;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 12px;
            font-weight: 600;
        }
        .password-strength {
            height: 5px;
            border-radius: 5px;
            margin-top: 5px;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card verify-card border-0">
                    <div class="card-header-custom">
                        <i class="bi bi-key" style="font-size: 3rem;"></i>
                        <h3 class="mt-3 mb-0">Verify OTP</h3>
                        <p class="mb-0 mt-2" style="opacity: 0.9;">Enter OTP and set new password</p>
                    </div>
                    
                    <div class="card-body p-5">
                        
                        <!-- Display OTP (For Demo - Remove in Production) -->
                        <% if (request.getParameter("otp") != null) { %>
                            <div class="otp-display">
                                <i class="bi bi-shield-check text-success" style="font-size: 2rem;"></i>
                                <p class="mb-2 mt-2 fw-bold">Your OTP Code:</p>
                                <div class="otp-code"><%= request.getParameter("otp") %></div>
                                <small class="text-muted">
                                    <i class="bi bi-clock"></i> Valid for 5 minutes
                                </small>
                            </div>
                            
                            <div class="alert alert-info text-center mb-4">
                                <i class="bi bi-info-circle"></i> 
                                In production, this OTP will be sent to your email/phone
                            </div>
                        <% } %>

                        <form action="${pageContext.request.contextPath}/ResetPasswordServlet" method="post" 
                              onsubmit="return validateForm()">
                            
                            <div class="mb-4">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-123 text-primary"></i> Enter OTP
                                </label>
                                <input type="text" name="otp" id="otpInput" 
                                       class="form-control form-control-lg text-center" 
                                       placeholder="Enter 6-digit OTP" 
                                       maxlength="6" 
                                       pattern="[0-9]{6}" 
                                       required
                                       style="letter-spacing: 10px; font-size: 1.5rem; font-weight: bold;">
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-lock text-success"></i> New Password
                                </label>
                                <input type="password" name="newPassword" id="newPassword" 
                                       class="form-control form-control-lg" 
                                       placeholder="Enter new password" 
                                       minlength="6"
                                       required
                                       onkeyup="checkPasswordStrength()">
                                <div id="passwordStrength" class="password-strength"></div>
                                <small class="text-muted">Minimum 6 characters</small>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-lock-fill text-info"></i> Confirm Password
                                </label>
                                <input type="password" name="confirmPassword" id="confirmPassword" 
                                       class="form-control form-control-lg" 
                                       placeholder="Confirm new password" 
                                       required>
                                <small id="passwordMatch" class="text-danger" style="display: none;">
                                    Passwords do not match!
                                </small>
                            </div>

                            <div class="d-grid mb-4">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="bi bi-check-circle"></i> Reset Password
                                </button>
                            </div>

                            <div class="text-center">
                                <small class="text-muted">
                                    <a href="${pageContext.request.contextPath}/forgotPassword.jsp" 
                                       class="text-decoration-none fw-bold text-primary">
                                        <i class="bi bi-arrow-left"></i> Back to Forgot Password
                                    </a>
                                </small>
                            </div>
                        </form>

                        <!-- Error Message -->
                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger mt-4 text-center" role="alert">
                                <i class="bi bi-exclamation-triangle-fill"></i>
                                <%= request.getParameter("error").replace("+", " ") %>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function checkPasswordStrength() {
            const password = document.getElementById('newPassword').value;
            const strengthBar = document.getElementById('passwordStrength');
            
            let strength = 0;
            if (password.length >= 6) strength++;
            if (password.length >= 10) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            if (/[^a-zA-Z0-9]/.test(password)) strength++;
            
            if (strength === 0) {
                strengthBar.style.width = '0%';
            } else if (strength <= 2) {
                strengthBar.style.width = '33%';
                strengthBar.style.backgroundColor = '#dc3545';
            } else if (strength <= 3) {
                strengthBar.style.width = '66%';
                strengthBar.style.backgroundColor = '#ffc107';
            } else {
                strengthBar.style.width = '100%';
                strengthBar.style.backgroundColor = '#28a745';
            }
        }

        function validateForm() {
            const password = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const matchMsg = document.getElementById('passwordMatch');
            
            if (password !== confirmPassword) {
                matchMsg.style.display = 'block';
                return false;
            }
            
            matchMsg.style.display = 'none';
            return true;
        }

        // Real-time password match check
        document.getElementById('confirmPassword').addEventListener('keyup', function() {
            const password = document.getElementById('newPassword').value;
            const confirmPassword = this.value;
            const matchMsg = document.getElementById('passwordMatch');
            
            if (confirmPassword.length > 0) {
                if (password !== confirmPassword) {
                    matchMsg.style.display = 'block';
                    this.style.borderColor = '#dc3545';
                } else {
                    matchMsg.style.display = 'none';
                    this.style.borderColor = '#28a745';
                }
            }
        });
    </script>
</body>
</html>