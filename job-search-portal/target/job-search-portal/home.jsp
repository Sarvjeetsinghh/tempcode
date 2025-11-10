<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>DreamJob - Find Jobs & Career Opportunities</title>
<link rel="icon" type="image/png"
	href="https://www.iardo.in/wp-content/uploads/2024/11/cropped-cropped-logo-scaled-2-75x25.jpg" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap"
	rel="stylesheet">

<style>

/* Global */
body {
	font-family: 'Poppins', sans-serif;
	margin: 0;
	background: linear-gradient(135deg, #b3e5fc, #e0f7fa);
	color: #002b5c;
	overflow-x: hidden;
}


/* Hero Section */
.hero {
	text-align: center;
	margin: 80px auto 40px;
	max-width: 900px;
}

.hero h1 {
	font-size: 2.5rem;
	font-weight: 700;
	color: #003366;
}

.hero p {
	color: #002b5c;
	font-size: 1.1rem;
	margin-top: 10px;
	line-height: 1.6;
}

/* Search Bar */
.search-section {
	background: #fff;
	border-radius: 50px;
	padding: 10px 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	max-width: 900px;
	margin: 40px auto;
}

.search-section input {
	border: none;
	outline: none;
	width: 100%;
	font-size: 16px;
}

.search-section button {
	border: none;
	background: blue;
	color: #fff;
	font-weight: 600;
	border-radius: 30px;
	padding: 10px 30px;
	transition: 0.3s;
}



/* Post Job */
.post-btn {
	background-color: blue;
	color: #fff;
	border: none;
	border-radius: 50px;
	padding: 10px 25px;
	font-weight: 600;
	margin-top: 15px;
	transition: 0.3s;
}



/* ===== FOOTER STYLES ===== */
.footer {
	background: linear-gradient(135deg, #002b3a, #004d66);
	color: #f0f0f0;
	padding: 60px 0 20px;
	font-family: 'Poppins', sans-serif;
}

.footer-container {
	max-width: 1200px;
	margin: auto;
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	gap: 40px;
	padding: 0 30px;
}

.footer-col {
	flex: 1 1 250px;
	min-width: 230px;
}

.footer-logo {
	width: 150px;
	margin-bottom: 15px;
}

.footer-col h4 {
	font-size: 18px;
	color: #ffffff;
	margin-bottom: 20px;
	position: relative;
}

.footer-col h4::after {
	content: '';
	width: 50px;
	height: 2px;
	background: #00bcd4;
	position: absolute;
	left: 0;
	bottom: -8px;
	border-radius: 2px;
}

.footer-col ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.footer-col ul li {
	margin: 10px 0;
}

.footer-col ul li a {
	color: #d4e6ec;
	text-decoration: none;
	font-size: 15px;
	transition: 0.3s;
}

.footer-col ul li a:hover {
	color: #00bcd4;
	padding-left: 5px;
}

.footer p {
	font-size: 14px;
	line-height: 1.7;
	color: #d6e6ea;
}

/* Social icons */
.social-links a {
	display: inline-block;
	margin-right: 10px;
	background: #00bcd4;
	color: #fff;
	width: 36px;
	height: 36px;
	line-height: 36px;
	border-radius: 50%;
	text-align: center;
	transition: 0.3s;
}

.social-links a:hover {
	background: #0097a7;
	transform: scale(1.1);
}

/* Footer Bottom */
.footer-bottom {
	text-align: center;
	border-top: 1px solid rgba(255, 255, 255, 0.2);
	margin-top: 40px;
	padding-top: 20px;
	font-size: 14px;
	color: #a8c5ca;
}

@media ( max-width : 768px) {
	.footer-container {
		flex-direction: column;
		text-align: center;
	}
	.footer-col h4::after {
		left: 50%;
		transform: translateX(-50%);
	}
}

.heading-link {
	text-decoration: none;
	color: #0078ff;
	font-weight: bold;
	font-size: 2.2rem;
	font-family: "Poppins", sans-serif;
	transition: color 0.3s ease;
}

.heading-link:hover {
	color: #0056b3;
	
}




<%--three textimg css --%>

.text-gradient {
  background: linear-gradient(90deg, #004d73, #007bff);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.section-title {
  color: #004d73;
  position: relative;
}
.section-title::after {
  content: "";
  display: block;
  width: 80px;
  height: 3px;
  background: linear-gradient(90deg, #ff4b2b, #ff416c);
  margin-top: 8px;
  border-radius: 5px;
}

/* ===== CATEGORY CARD ===== */
.category-card {
  background: white;
  border-radius: 10px;
  padding: 15px;
  width: 180px;
  text-align: center;
  transition: all 0.3s ease-in-out;
  cursor: pointer;
  border: 2px solid transparent;
  box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}
.category-card i {
  font-size: 2.5rem;
  color: #007bff;
  transition: all 0.3s ease-in-out;
}
.category-card h5 {
  font-weight: 600;
  color: #003366;
  margin-top: 10px;
}
.category-card p {
  color: #777;
  font-size: 0.9rem;
}
.category-card:hover {
  transform: translateY(-8px);
  border-color: #007bff;
  box-shadow: 0 8px 25px rgba(0, 123, 255, 0.25);
}
.category-card:hover i {
  color: #0056b3;
  text-shadow: 0 0 8px rgba(0, 123, 255, 0.6);
}

/* ===== Transparent Image Style ===== */
.img-transparent {
  max-width: 100%;
  border: none;
  border-radius: 0;
  background: transparent;
  box-shadow: none;
  transition: transform 0.3s ease-in-out;
}
.img-transparent:hover {
  transform: scale(1.03);
}


<%-- featured-jobs --%>

</style>
</head>

<body>

<%@ include file="header.jsp" %>

	<!-- Hero Section -->
	<div class="hero container">
		<h1>Join Dream Naukri Where Career Aspirations Meet Opportunity</h1>
		<p>Unlock your potential, achieve your dreams with Dream Naukri
			connecting talent with tomorrow's leaders. Elevate your career
			journey with Dream Naukri - The Gateway to Professional Success.</p>
	</div>

	<!-- Search Section -->
	<div class="search-section">
		<input type="text" placeholder="Job title, keywords...">
		<button class="clr">Find Jobs</button>
	</div>

	<!-- Post Job -->
	<div class="text-center">
		<button class="post-btn">Post a Job</button>
	</div>

	
	
	
<%--------------add more --------------- --%>

<!-- ====== POPULAR JOB CATEGORIES ====== -->
<section class="container my-5">
  <h3 class="text-center fw-bold mb-5 display-6 text-gradient">🔥 Popular Job Categories</h3>
  <div class="d-flex flex-wrap justify-content-center gap-4">
    <div class="category-card">
      <i class="bi bi-briefcase-fill"></i>
      <h5>Sales / Marketing</h5>
      <p>(152 open positions)</p>
    </div>
    <div class="category-card">
      <i class="bi bi-laptop-fill"></i>
      <h5>Developer / Technology / IT</h5>
      <p>(120 open positions)</p>
    </div>
    <div class="category-card">
      <i class="bi bi-bank"></i>
      <h5>Finance / Banking</h5>
      <p>(80 open positions)</p>
    </div>
    <div class="category-card">
      <i class="bi bi-headset"></i>
      <h5>Customer Service / Support</h5>
      <p>(70 open positions)</p>
    </div>
    <div class="category-card">
      <i class="bi bi-person-workspace"></i>
      <h5>Healthcare / Medical</h5>
      <p>(45 open positions)</p>
    </div>
    <div class="category-card">
      <i class="bi bi-cup-hot-fill"></i>
      <h5>Hospitality / Tourism / Culinary Arts</h5>
      <p>(35 open positions)</p>
    </div>
  </div>
</section>

<!-- ====== SEARCH JOBS ====== -->
<section class="container my-5 d-flex flex-wrap align-items-center justify-content-between gap-5">
  <div class="col-md-6">
    <h2 class="fw-bold section-title">Search Hundreds of Jobs Near You 🔍</h2>
    <p>Explore a world of career opportunities with top companies hiring daily. Gain insights into job roles, salary trends, and tailor-made openings that match your goals.</p>
    <ul>
      <li>Instantly matched job openings based on your skills.</li>
      <li>Verified employers offering top opportunities.</li>
      <li>Let <b>Dream Naukri</b> guide you to your next big step.</li>
    </ul>
<a href="register.jsp" class="btn btn-lg rounded-pill shadow" 
   style="background-color: #007bff; color: white;">
    🚀 Register Now as a Candidate
</a>
  </div>
  <div class="col-md-5 text-center">
    <img src="search-removebg-preview.png" alt="Search Jobs" class="img-fluid img-transparent">
  </div>
</section>

<!-- ====== MAXIMIZE PROFILE ====== -->
<section class="container my-5 d-flex flex-wrap align-items-center justify-content-between gap-5">
  <div class="col-md-5 text-center order-md-2">
    <img src="maximize-removebg-preview.png" alt="Profile Optimize" class="img-fluid img-transparent">
  </div>
  <div class="col-md-6 order-md-1">
    <h2 class="fw-bold section-title">Enhance the attractiveness of your profile and draw the attention of employers by meticulously completing it </h2>
    <p>Enhance your profile by achieving a minimum completion rate of 80%! Develop a concise resume that emphasizes your skills and pertinent achievements. Compose an engaging cover letter that demonstrates how your expertise aligns with the organization. Differentiate yourself from competitors with a striking profile that makes a memorable impact.</p>
    <div class="d-flex gap-3 mt-3">
      <a href="#" class="btn btn-primary rounded-pill px-4 shadow">Optimize Profile</a>
      <a href="#" class="btn btn-outline-primary rounded-pill px-4">Add Resume</a>
      <a herf="#" class="btn btn-outline-primary rounded-pill px-4">Resume Builder</a>
    </div>
  </div>
</section>

<!-- ====== APPLY DIRECTLY ====== -->
<section class="container my-5 d-flex flex-wrap align-items-center justify-content-between gap-5">
  <div class="col-md-6">
    <h2 class="fw-bold section-title">Submit Your Application Directly</h2>
    <p>A well-crafted resume ought to highlight your skills and feature concrete achievements pertinent to the position for which you are applying. Additionally, it is advisable to prepare a cover letter that is succinct and expands on how you can apply your abilities within the organization.</p>
<a href="#" class="btn btn-lg rounded-pill shadow mt-3" 
   style="background-color: #007bff; color: white;">
    ✨ Discover Dream Jobs
</a>  </div>
  <div class="col-md-5 text-center">
    <img src="applyjobs-removebg-preview.png" alt="Apply Jobs" class="img-fluid img-transparent">
  </div>
</section>


<%@ include file="featured-jobs.jsp" %>


	<!-- Footer -->
	<footer class="footer">
		<div class="footer-container">

			<!-- Company Info -->
			<div class="footer-col">
				<p>IARDO delivers eCommerce Product Listing Services, Graphic
					Design, Website Design, SEO, and Digital Marketing. Since 2016, we
					have served over 15,000+ satisfied clients in India.</p>
			</div>

			<!-- Services -->
			<div class="footer-col">
				<h4>Our Services</h4>
				<ul>
					<li><a href="#">Digital Marketing</a></li>
					<li><a href="#">Social Media Marketing (SMM)</a></li>
					<li><a href="#">Web Development</a></li>
					<li><a href="#">SEO Services</a></li>
				</ul>
			</div>

			<!-- Forms & Company -->
			<div class="footer-col">
				<h4>Forms & Company</h4>
				<ul>
					<li><a href="#">Seller Acquisition Form</a></li>
					<li><a href="#">Registration</a></li>
					<li><a href="#">Certifications</a></li>
				</ul>
			</div>

			<!-- Quick Commerce -->
			<div class="footer-col">
				<h4>Quick Commerce</h4>
				<ul>
					<li><a href="#">Blinkit</a></li>
					<li><a href="#">Zepto</a></li>
					<li><a href="#">Swiggy InstaMart</a></li>
					<li><a href="#">BigBasket</a></li>
					<li><a href="#">Swiggy Mini</a></li>
				</ul>
			</div>

			<!-- Social Links -->
			<div class="footer-col">
				<h4>Connect With Us</h4>
				<div class="social-links">
					<a href="#"><i class="bi bi-facebook"></i></a> <a href="#"><i
						class="bi bi-twitter"></i></a> <a href="#"><i
						class="bi bi-instagram"></i></a> <a href="#"><i
						class="bi bi-linkedin"></i></a>
				</div>
			</div>
		</div>

		<!-- Footer Bottom -->
		<div class="footer-bottom">
			Copyright © 2025 IARDO | Powered by <strong>IARDO E-commerce
				Enabler</strong>
		</div>
	</footer>

	<!-- Bootstrap Icons CDN -->

</body>
</html>
