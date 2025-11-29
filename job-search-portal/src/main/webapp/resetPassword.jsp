<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security check: Ensure OTP was verified
    if (session == null || session.getAttribute("otpVerified") == null 
        || !(Boolean) session.getAttribute("otpVerified")) {
        response.sendRedirect("forgotPassword.jsp?error=Invalid+access");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password - DreamJob</title>
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
        .reset-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0,0,0,0.3);
            animation: fadeIn 0.5s ease;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        .card-header-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px 20px 0 0;
            padding: 30px;
            text-align: center;
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
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        .password-strength {
            height: 5px;
            border-radius: 5px;
            margin-top: 5px;
            transition: all 0.3s ease;
        }
        .eye-icon {
            cursor: pointer;
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
        }
        .password-wrapper {
            position: relative;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card reset-card border-0">
                    <div class="card-header-custom">
                        <i class="bi bi-key" style="font-size: 3rem;"></i>
                        <h3 class="mt-3 mb-0">Reset Password</h3>
                        <p class="mb-0 mt-2" style="opacity: 0.9;">Create a strong new password</p>
                    </div>
                    
                    <div class="card-body p-5">
                        <form action="${pageContext.request.contextPath}/ResetPasswordServlet" method="post" id="resetForm">
                            
                            <div class="mb-4">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-lock text-primary"></i> New Password
                                </label>
                                <div class="password-wrapper">
                                    <input type="password" name="newPassword" id="newPassword" 
                                           class="form-control form-control-lg" 
                                           placeholder="Enter new password" 
                                           minlength="6" required
                                           oninput="checkPasswordStrength()">
                                    <i class="bi bi-eye eye-icon" id="togglePassword1" onclick="togglePassword('newPassword', 'togglePassword1')"></i>
                                </div>
                                <div class="password-strength" id="strengthBar"></div>
                                <small class="text-muted" id="strengthText">Password strength: </small>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-lock-fill text-success"></i> Confirm Password
                                </label>
                                <div class="password-wrapper">
                                    <input type="password" name="confirmPassword" id="confirmPassword" 
                                           class="form-control form-control-lg" 
                                           placeholder="Re-enter new password" 
                                           minlength="6" required
                                           oninput="checkPasswordMatch()">
                                    <i class="bi bi-eye eye-icon" id="togglePassword2" onclick="togglePassword('confirmPassword', 'togglePassword2')"></i>
                                </div>
                                <small class="text-muted" id="matchText"></small>
                            </div>

                            <div class="alert alert-info mb-4">
                                <strong><i class="bi bi-info-circle"></i> Password Requirements:</strong>
                                <ul class="mb-0 mt-2">
                                    <li>At least 6 characters long</li>
                                    <li>Use a mix of letters, numbers, and symbols</li>
                                    <li>Avoid common words or patterns</li>
                                </ul>
                            </div>

                            <div class="d-grid mb-4">
                                <button type="submit" class="btn btn-primary btn-lg" id="submitBtn">
                                    <i class="bi bi-check-circle"></i> Reset Password
                                </button>
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

                <!-- Security Tip -->
                <div class="card mt-4 border-0" style="background: rgba(255,255,255,0.95); border-radius: 15px;">
                    <div class="card-body text-center p-3">
                        <small class="text-muted">
                            <i class="bi bi-shield-check text-success"></i> 
                            Choose a password you haven't used before
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        function togglePassword(inputId, iconId) {
            const input = document.getElementById(inputId);
            const icon = document.getElementById(iconId);
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        }

        // Check password strength
        function checkPasswordStrength() {
            const password = document.getElementById('newPassword').value;
            const strengthBar = document.getElementById('strengthBar');
            const strengthText = document.getElementById('strengthText');
            
            let strength = 0;
            
            if (password.length >= 6) strength++;
            if (password.length >= 10) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/\d/.test(password)) strength++;
            if (/[^a-zA-Z0-9]/.test(password)) strength++;
            
            const colors = ['#dc3545', '#fd7e14', '#ffc107', '#28a745', '#20c997'];
            const labels = ['Very Weak', 'Weak', 'Fair', 'Good', 'Strong'];
            
            if (password.length === 0) {
                strengthBar.style.width = '0%';
                strengthBar.style.backgroundColor = 'transparent';
                strengthText.innerHTML = 'Password strength: ';
            } else {
                strengthBar.style.width = ((strength / 5) * 100) + '%';
                strengthBar.style.backgroundColor = colors[strength - 1];
                strengthText.innerHTML = 'Password strength: <strong>' + labels[strength - 1] + '</strong>';
            }
        }

        // Check if passwords match
        function checkPasswordMatch() {
            const password = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const matchText = document.getElementById('matchText');
            
            if (confirmPassword.length === 0) {
                matchText.innerHTML = '';
                return;
            }
            
            if (password === confirmPassword) {
                matchText.innerHTML = '<i class="bi bi-check-circle-fill text-success"></i> Passwords match';
                matchText.style.color = '#28a745';
            } else {
                matchText.innerHTML = '<i class="bi bi-x-circle-fill text-danger"></i> Passwords do not match';
                matchText.style.color = '#dc3545';
            }
        }

        // Form validation
        document.getElementById('resetForm').addEventListener('submit', function(e) {
            const password = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return false;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long!');
                return false;
            }
        });
    </script>
</body>
</html>