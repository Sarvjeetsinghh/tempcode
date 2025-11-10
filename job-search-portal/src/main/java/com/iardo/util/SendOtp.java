package com.iardo.util;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

public class SendOtp {

    private static final String AUTH_KEY = "476969A9CpV1EZO690ef31aP1"; // MSG91 Auth Key
    private static final String TEMPLATE_ID = "690ef5821df2194272614f34"; // OTP Template ID
    private static final String SENDER_ID = "DREAMJ"; // e.g., DREAMJ

    public static boolean sendOTP(String mobile, String otp) {
        try {
            URL url = new URL("https://control.msg91.com/api/v5/otp");
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("authkey", AUTH_KEY);
            con.setRequestProperty("content-type", "application/json");
            con.setDoOutput(true);

            JSONObject json = new JSONObject();
            json.put("mobile", "91" + mobile);  // Add country code
            json.put("otp_expiry", 5);           // OTP valid for 5 minutes
            json.put("template_id", TEMPLATE_ID);
            json.put("sender_id", SENDER_ID);
            json.put("otp", otp);               // Dynamic OTP

            try (OutputStream os = con.getOutputStream()) {
                byte[] input = json.toString().getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            int responseCode = con.getResponseCode();
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line.trim());
            }

            JSONObject res = new JSONObject(response.toString());
            System.out.println("MSG91 Response: " + res.toString());

            return responseCode == 200 && res.optString("type").equals("success");

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

