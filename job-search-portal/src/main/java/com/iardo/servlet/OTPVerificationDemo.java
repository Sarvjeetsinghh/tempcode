package com.iardo.servlet;

import java.util.Scanner;
import com.iardo.util.OTPGenerator;
import com.iardo.util.MSG91Sender;

public class OTPVerificationDemo {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter your mobile number: ");
        String mobile = sc.nextLine();

        String otp = OTPGenerator.generateOTP();
        MSG91Sender.sendOTP(mobile, otp);

        System.out.print("Enter OTP received: ");
        String inputOTP = sc.nextLine();

        if (otp.equals(inputOTP)) {
            System.out.println("✅ OTP verified! Registration successful.");
        } else {
            System.out.println("❌ Invalid OTP. Try again.");
        }

        sc.close();
    }
}
