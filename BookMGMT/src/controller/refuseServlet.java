package controller;

import dao.registerDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/refuseServlet")
public class refuseServlet extends HttpServlet {

    String path = "admin_super.jsp";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String phone = req.getParameter("mail");

        registerDao cd = new registerDao();
        try {
            cd.delete_register(phone);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher(path).forward(req,resp);
    }
}
