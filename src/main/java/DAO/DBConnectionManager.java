/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author Ahmad
 */

import jakarta.servlet.ServletContext;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectionManager {
    private final String dbUrl;
    private final String dbUser;
    private final String dbPassword;

    public DBConnectionManager(ServletContext context) {
        this.dbUrl      = context.getInitParameter("DB_URL");
        this.dbUser     = context.getInitParameter("DB_USER");
        this.dbPassword = context.getInitParameter("DB_PASSWORD");
    }

    public Connection getConnection() throws SQLException {
        System.out.println(">>> DB URL:  " + dbUrl);
        System.out.println(">>> DB USER: " + dbUser);

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL JDBC Driver not found on classpath", e);
        }

        return DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    }
}