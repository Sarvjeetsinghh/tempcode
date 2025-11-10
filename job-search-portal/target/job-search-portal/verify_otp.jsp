<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP</title>
</head>
<body>
    <h2>Enter the OTP sent to your email</h2>
    <form action="VerifyOtpServlet" method="post">
        <input type="text" name="otp" placeholder="Enter OTP" required />
        <button type="submit">Verify</button>
    </form>
</body>
</html>
