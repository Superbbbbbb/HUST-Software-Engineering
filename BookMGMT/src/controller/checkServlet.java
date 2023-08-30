package controller;

import dao.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/checkServlet")
public class checkServlet extends HttpServlet {

    String path = "admin_super.jsp";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String phone = req.getParameter("mail");

        adminDao ad = new adminDao();
        registerDao rd = new registerDao();

        try {
            ad.add_admin(rd.Search(phone));
            rd.delete_register(phone);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher(path).forward(req,resp);
    }
}
