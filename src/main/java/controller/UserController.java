/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DAO.UserDAO;
import Models.User;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

/**
 *
 * @author Ahmad
 */
@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("[UserController] action = " + action);

        UserDAO userDAO = new UserDAO(getServletContext());

        if ("register".equalsIgnoreCase(action)) {
            System.out.println("[UserController] Registering user…");
            System.out.printf("[UserController] params: username=%s, email=%s, status=%s%n",
                    request.getParameter("username"),
                    request.getParameter("email"),
                    request.getParameter("status"));

            String username        = request.getParameter("username");
            String email           = request.getParameter("email");
            String password        = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String status          = request.getParameter("status");
            String role            = request.getParameter("role");

            if (!password.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Passwords do not match.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            User newUser = new User();
            newUser.setUsername(username);
            newUser.setEmail(email);
            newUser.setPassword(password);
            newUser.setStatus(status);
            newUser.setRole(role);

            boolean registrationSuccess = false;
            try {
                System.out.println("[UserController] Calling userDAO.registerUser(...)");
                registrationSuccess = userDAO.registerUser(newUser);
                System.out.println("[UserController] registrationSuccess = " + registrationSuccess);
            } catch (Exception e) {
                System.out.println("[UserController] Exception during registerUser:");
                e.printStackTrace(System.out);
            }

            if (registrationSuccess) {
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("errorMessage", "Registration failed. Try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        }  else if ("login".equalsIgnoreCase(action)) {
        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.getUserByEmail(email);

        if (user != null && user.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

        if ("admin@gmail.com".equalsIgnoreCase(email) 
            && "123456".equals(password)) {
            session.setAttribute("isAdmin", true);
            response.sendRedirect("AdminController");
        } else {
            session.setAttribute("isAdmin", false);
            response.sendRedirect("TripController");
        }

    } else {
        request.setAttribute("errorMessage", "Invalid email or password.");
        request.getRequestDispatcher("login.jsp")
               .forward(request, response);
    }
}

    }

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    if ("logout".equalsIgnoreCase(action)) {
        request.getSession().invalidate();
        response.sendRedirect("login.jsp");
    } else {
        request.getRequestDispatcher("login.jsp")
               .forward(request, response);
    }
}

    @Override
    public String getServletInfo() {
        return "UserController handling registration and login";
    }
}