<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - DreamJob</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 0;
        }
        .register-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }
        .form-section {
            display: none;
        }
        .form-section.active {
            display: block;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card register-card">
                    <div class="card-body p-5">
                        <h3 class="text-center text-primary mb-4">
                            <i class="bi bi-person-plus"></i> Register for DreamJob
                        </h3>

                        <!-- Registration Form -->
                        <form action="${pageContext.request.contextPath}/RegistrationServlet" method="post">
                            
                            <!-- User Type Selection -->
                            <div class="mb-3">
                                <label class="form-label fw-bold">I am registering as</label>
                                <select name="userType" id="userType" class="form-select" required onchange="toggleFields()">
                                    <option value="">-- Select User Type --</option>
                                    <option value="candidate">Job Seeker / Candidate</option>
                                    <option value="employer">Employer / Recruiter</option>
                                </select>
                            </div>

                            <!-- CANDIDATE FIELDS -->
                            <div id="candidateFields" class="form-section">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Full Name</label>
                                    <input type="text" name="name" class="form-control" placeholder="Enter your full name">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Email Address</label>
                                    <input type="email" name="email" class="form-control" placeholder="Enter your email">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Phone Number</label>
                                    <input type="tel" name="phone" class="form-control" placeholder="Enter phone number">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Gender</label>
                                    <select name="gender" class="form-select">
                                        <option value="">-- Select Gender --</option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Category</label>
                                    <select name="category" class="form-select">
                                        <option value="">-- Select Category --</option>
                                        <option value="Fresher">Fresher</option>
                                        <option value="Experienced">Experienced</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Password</label>
                                    <input type="password" name="password" class="form-control" placeholder="Create password (min 6 characters)">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Confirm Password</label>
                                    <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm your password">
                                </div>
                            </div>

                            <!-- EMPLOYER FIELDS -->
                            <div id="employerFields" class="form-section">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Company Name</label>
                                    <input type="text" name="companyName" class="form-control" placeholder="Enter company name">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Email Address</label>
                                    <input type="email" name="email" class="form-control" placeholder="Company email">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Phone Number</label>
                                    <input type="tel" name="phone" class="form-control" placeholder="Company phone">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Industry</label>
                                    <select name="industry" class="form-select">
                                        <option value="">-- Select Industry --</option>
                                        <option value="IT">IT / Software</option>
                                        <option value="Finance">Finance / Banking</option>
                                        <option value="Healthcare">Healthcare</option>
                                        <option value="Education">Education</option>
                                        <option value="Manufacturing">Manufacturing</option>
                                        <option value="Retail">Retail</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Website (Optional)</label>
                                    <input type="url" name="website" class="form-control" placeholder="https://www.example.com">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Address</label>
                                    <textarea name="address" class="form-control" rows="2" placeholder="Company address"></textarea>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Company Description</label>
                                    <textarea name="description" class="form-control" rows="3" placeholder="Brief description about your company"></textarea>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Password</label>
                                    <input type="password" name="password" class="form-control" placeholder="Create password (min 6 characters)">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Confirm Password</label>
                                    <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm your password">
                                </div>
                            </div>

                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="bi bi-check-circle"></i> Register
                                </button>
                            </div>

                            <div class="text-center">
                                <small class="text-muted">
                                    Already have an account? 
                                    <a href="${pageContext.request.contextPath}/login.jsp" class="text-decoration-none fw-bold">
                                        Login here
                                    </a>
                                </small>
                            </div>
                        </form>

                        <!-- Error Message -->
                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger mt-3 text-center" role="alert">
                                <i class="bi bi-exclamation-triangle-fill"></i>
                                <%= request.getParameter("error").replace("+", " ") %>
                            </div>
                        <% } %>

                        <!-- Success Message -->
                        <% if (request.getParameter("success") != null) { %>
                            <div class="alert alert-success mt-3 text-center" role="alert">
                                <i class="bi bi-check-circle-fill"></i>
                                <%= request.getParameter("success").replace("+", " ") %>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleFields() {
            const userType = document.getElementById('userType').value;
            const candidateFields = document.getElementById('candidateFields');
            const employerFields = document.getElementById('employerFields');

            if (userType === 'candidate') {
                candidateFields.classList.add('active');
                employerFields.classList.remove('active');
                
                // Make candidate fields required
                candidateFields.querySelectorAll('input, select').forEach(input => {
                    if (input.name !== 'gender' && input.name !== 'category') {
                        input.setAttribute('required', 'required');
                    }
                });
                
                // Remove employer field requirements
                employerFields.querySelectorAll('input, select, textarea').forEach(input => {
                    input.removeAttribute('required');
                });
                
            } else if (userType === 'employer') {
                employerFields.classList.add('active');
                candidateFields.classList.remove('active');
                
                // Make employer fields required
                employerFields.querySelectorAll('input, select').forEach(input => {
                    if (input.name !== 'website') {
                        input.setAttribute('required', 'required');
                    }
                });
                
                // Remove candidate field requirements
                candidateFields.querySelectorAll('input, select').forEach(input => {
                    input.removeAttribute('required');
                });
                
            } else {
                candidateFields.classList.remove('active');
                employerFields.classList.remove('active');
            }
        }
    </script>
</body>
</html>