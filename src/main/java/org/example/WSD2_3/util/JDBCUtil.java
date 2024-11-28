package org.example.WSD2_3.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import static java.lang.Class.forName;

public class JDBCUtil {
    public static Connection getConnection() {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            return DriverManager.getConnection(
                    "jdbc:mariadb://walab.handong.edu:3306/OSS24_22200356",
                    "OSS24_22200356",
                    "iiSh0ahh"
            );
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException("Database connection error: " + e.getMessage(), e);
        }
    }

    /*
    public static void main(String a[]){
        Connection conn = org.example.hw4.util.JDBCUtil.getConnection();
        if(conn != null) {
            System.out.println("DB연결 완료");
        }
    }
    */
}