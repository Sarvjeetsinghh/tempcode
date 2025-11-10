package com.iardo.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static Connection connection = null;

    public static Connection getConnection() {
        if (connection == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Environment variables se read karo
                String dbUrl = System.getenv("DB_URL");
                String dbUser = System.getenv("DB_USER");
                String dbPass = System.getenv("DB_PASS");

                connection = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                System.out.println("✅ Database Connected Successfully!");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return connection;
    }
}
