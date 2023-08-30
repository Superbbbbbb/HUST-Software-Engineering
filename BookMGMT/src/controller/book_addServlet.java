package controller;

import proto.book;
import dao.bookDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/book_addServlet")
public class book_addServlet extends HttpServlet {

    String path = "book_admin.jsp";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int school = Integer.parseInt(req.getParameter("school"));

        bookDao bd = new bookDao();

        try {
            for(int i=1;;i++){
                String name = req.getParameter("name"+i);
                if(name==null) break;
                int type = Integer.parseInt(req.getParameter("type"+i));
                String donator = req.getParameter("donator"+i);
                bd.add_book(new book(name,type,school,donator));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher(path).forward(req,resp);
    }

}
