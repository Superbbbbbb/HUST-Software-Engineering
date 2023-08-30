package controller;

import proto.book;
import proto.school;
import dao.schoolDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/school_addServlet")
public class school_addServlet extends HttpServlet {

    String path = "school_admin.jsp";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        schoolDao sd = new schoolDao();
        try {
            for(int i=1;;i++){
                String name = req.getParameter("name"+i);
                if(name==null) break;
                int admin = Integer.parseInt(req.getParameter("adminId"+i));
                sd.add_school(new school(name, admin));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher(path).forward(req,resp);
    }
}
