package controller;

import proto.school;
import proto.type;
import dao.typeDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/type_addServlet")
public class type_addServlet extends HttpServlet {

    String path = "book_admin.jsp";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int a = Integer.parseInt(req.getParameter("admin"));
        req.setAttribute("admin", a);

        typeDao td = new typeDao();
        try {
            for(int i=1;;i++){
                String type = req.getParameter("type"+i);
                if(type==null) break;
                td.add_type(new type(type));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher(path).forward(req,resp);
    }
}
