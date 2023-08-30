package controller;

import proto.admin;
import dao.adminDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/adminServlet")
public class adminServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("admin"));
        String name = req.getParameter("name");
        String phone = req.getParameter("mail");
        String pwd = req.getParameter("pwd");

        adminDao ad = new adminDao();
        try {
            ad.update_admin(new admin(id, phone, pwd, name));
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
