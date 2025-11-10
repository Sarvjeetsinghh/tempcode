<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidates - Dream Naukri</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: #f7faff;
            font-family: 'Poppins', sans-serif;
        }

        .page-title {
            color: #003366;
            font-weight: 700;
            margin-top: 30px;
        }

        .search-bar {
            max-width: 500px;
            margin: 0 auto 40px;
        }

        .candidate-card {
            background: #fff;
            border: none;
            border-radius: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
        }

        .candidate-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .candidate-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin: 0 auto 15px;
            border: 3px solid #007bff;
        }

        .candidate-name {
            color: #003366;
            font-weight: 600;
        }

        .candidate-role {
            color: #007bff;
            font-size: 0.95rem;
        }

        .candidate-location {
            color: #555;
            font-size: 0.9rem;
        }

        .btn-profile {
            border-radius: 30px;
            padding: 6px 20px;
            background: linear-gradient(90deg, #003366, #0066cc);
            color: white;
            text-decoration: none;
        }

        .btn-profile:hover {
            background: linear-gradient(90deg, #0056b3, #0099ff);
        }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="container my-5 text-center">
        <h2 class="page-title">🌟 Featured Candidates</h2>
        <p class="text-muted mb-4">Explore talented individuals ready to make an impact in your organization.</p>

        <!-- Search Bar -->
        <div class="search-bar">
            <input type="text" id="searchInput" class="form-control rounded-pill shadow-sm" placeholder="Search candidates by name or skill...">
        </div>

        <!-- Candidate Cards -->
        <div class="row justify-content-center" id="candidateContainer">
            
            <!-- Candidate 1 -->
            <div class="col-md-4 mb-4 candidate-card-wrapper">
                <div class="card candidate-card p-4 text-center">
                    <img src="https://randomuser.me/api/portraits/men/32.jpg" class="candidate-img" alt="Candidate">
                    <h5 class="candidate-name">Rohit Sharma</h5>
                    <p class="candidate-role">Full Stack Developer</p>
                    <p class="candidate-location"><i class="bi bi-geo-alt"></i> Noida, India</p>
                    <a href="#" class="btn btn-profile mt-2">View Profile</a>
                </div>
            </div>

            <!-- Candidate 2 -->
            <div class="col-md-4 mb-4 candidate-card-wrapper">
                <div class="card candidate-card p-4 text-center">
                    <img src="https://randomuser.me/api/portraits/women/45.jpg" class="candidate-img" alt="Candidate">
                    <h5 class="candidate-name">Neha Verma</h5>
                    <p class="candidate-role">UI/UX Designer</p>
                    <p class="candidate-location"><i class="bi bi-geo-alt"></i> Mumbai, India</p>
                    <a href="#" class="btn btn-profile mt-2">View Profile</a>
                </div>
            </div>

            <!-- Candidate 3 -->
            <div class="col-md-4 mb-4 candidate-card-wrapper">
                <div class="card candidate-card p-4 text-center">
                    <img src="https://randomuser.me/api/portraits/men/65.jpg" class="candidate-img" alt="Candidate">
                    <h5 class="candidate-name">Aman Gupta</h5>
                    <p class="candidate-role">Java Backend Engineer</p>
                    <p class="candidate-location"><i class="bi bi-geo-alt"></i> Bengaluru, India</p>
                    <a href="#" class="btn btn-profile mt-2">View Profile</a>
                </div>
            </div>

        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Simple search filter
        document.getElementById("searchInput").addEventListener("keyup", function() {
            let filter = this.value.toLowerCase();
            let cards = document.getElementsByClassName("candidate-card-wrapper");

            Array.from(cards).forEach(function(card) {
                let name = card.querySelector(".candidate-name").textContent.toLowerCase();
                let role = card.querySelector(".candidate-role").textContent.toLowerCase();
                if (name.includes(filter) || role.includes(filter)) {
                    card.style.display = "";
                } else {
                    card.style.display = "none";
                }
            });
        });
    </script>

</body>
</html>
