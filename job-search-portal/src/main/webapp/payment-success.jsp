<!DOCTYPE html>
<html>
<head>
<title>Payment Successful</title>
<style>
body { 
    font-family: Arial; 
    background: #f2f2f2;
    padding: 40px; 
    text-align: center;
}
.box {
    background: white;
    padding: 30px;
    border-radius: 12px;
    display: inline-block;
    box-shadow: 0 0 10px #ccc;
}
</style>
</head>
<body>

<div class="box">
    <h2>Payment Successful 🎉</h2>

    <p><b>Amount Paid:</b> ₹${amount}</p>
    <p><b>Transaction ID:</b> ${txnId}</p>

    <br>
    <a href="phonepepay.jsp">Make Another Payment</a>
</div>

</body>
</html>
