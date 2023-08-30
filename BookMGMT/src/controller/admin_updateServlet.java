package controller;

import dao.adminDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin_updateServlet")
public class admin_updateServlet extends HttpServlet {

    String path = "admin_super.jsp";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String checkbox = req.getParameter("status");
        int status = 0;
        if(checkbox!=null)
            status = 1;

        adminDao ad = new adminDao();
        try {
            ad.update_admin(id,status);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher(path).forward(req,resp);
    }
}
