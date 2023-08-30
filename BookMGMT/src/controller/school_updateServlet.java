package controller;

import proto.school;
import dao.schoolDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/school_updateServlet")
public class school_updateServlet extends HttpServlet{

    String path = "school_admin.jsp";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        int admin = Integer.parseInt(req.getParameter("adminId"));

        schoolDao sd = new schoolDao();
        try {
            sd.update_school(new school(id, name, admin));
        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher(path).forward(req,resp);
    }
}
