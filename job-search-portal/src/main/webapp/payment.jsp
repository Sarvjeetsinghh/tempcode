<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PhonePe Payment</title>

<style>
/* Global Page Styling */
body {
    margin: 0;
    padding: 0;
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #87CEFA, #B0E0E6); /* Light Sky Blue */
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

/* Card Container */
.container {
    width: 450px; /* slightly bigger */
    padding: 40px; /* more padding for height */
    background: rgba(255,255,255,0.95);
    border-radius: 18px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    text-align: center;
    color: #111; /* Darker text for better visibility */
    animation: fadeIn 0.7s ease;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

h2 {
    margin-bottom: 12px;
    font-size: 30px;
    font-weight: 700;
    color: #000; /* ensure heading is dark */
}

p {
    font-size: 25px;
    margin-bottom: 25px;
    color: #222; /* slightly darker text */
}

/* Pay Button */
button {
    width: 100%;
    padding: 16px;
    border: none;
    border-radius: 10px;
    background: linear-gradient(90deg, #1E90FF, #00BFFF);
    font-size: 16px;
    font-weight: 600;
    color: white;
    cursor: pointer;
    letter-spacing: 0.4px;
    transition: transform 0.2s ease, opacity 0.2s;
}

button:hover {
    transform: translateY(-2px);
    opacity: 0.9;
}

/* Payment footer text */
.safe-text {
    margin-top: 16px;
    
    font-size: 13px;
    opacity: 0.85;
    color: #111;
}
</style>

</head>
<body>

<div class="container">

    <h2>Complete Your Payment</h2>
    <p>Pay Registration Fee to complete registration.<br>
       Fee: ₹10 + 18% GST </p>

    <!-- Fixed amount -->
    <form action="${pageContext.request.contextPath}/phonepePay" method="post">
        <input type="hidden" name="amount" value="11.8">
        <button type="submit">Pay Now</button>
    </form>

    <div class="safe-text">
        Secure Payment • Powered by PhonePe
    </div>

</div>

</body>
</html>
