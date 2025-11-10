package com.iardo.util;


import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class SendOTPExample {
    public static void main(String[] args) {
        try {
            String url = "https://control.msg91.com/api/v5/otp";
            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();

            // Request type
            con.setRequestMethod("POST");

            // Headers
            con.setRequestProperty("authkey", "476969A9CpV1EZO690ef31aP1");
            con.setRequestProperty("content-type", "application/json");

            // Enable sending data
            con.setDoOutput(true);

            // JSON body
            con.setRequestMethod("POST");
            con.setRequestProperty("accept", "application/json");
            con.setRequestProperty("Content-Type", "application/json");

            // ✅ Add these 2 important headers:
            con.setRequestProperty("authkey", "476969A9CpV1EZO690ef31aP1"); // 🔑 your MSG91 Auth Key
            con.setRequestProperty("Sender", "DREAMJ");      // 🏷️ your 6-character Sender ID (approved in MSG91)

            con.setDoOutput(true);

            String jsonInputString = "{"
                    + "\"mobile\":\"919876543210\","
                    + "\"otp_expiry\":5,"
                    + "\"template_id\":\"690ef5821df2194272614f34\""
                    + "}";

            try (OutputStream os = con.getOutputStream()) {
                byte[] input = jsonInputString.getBytes("utf-8");
                os.write(input, 0, input.length);
            }


            // Response check
            int responseCode = con.getResponseCode();
            System.out.println("Response Code : " + responseCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
