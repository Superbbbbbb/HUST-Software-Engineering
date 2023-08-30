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

@WebServlet("/book_updateServlet")
public class book_updateServlet extends HttpServlet {

    String path = "book_admin.jsp?";;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        int type = Integer.parseInt(req.getParameter("type"));
        int school = Integer.parseInt(req.getParameter("school"));
        String donator = req.getParameter("donator");
        String checkbox = req.getParameter("status");
        String borrow_name = req.getParameter("borrow_name");
        int status = 0;
        if(checkbox!=null)
            status = 1;

        bookDao bd = new bookDao();

        try {
            bd.update_book(new book(id, name, type, school, donator, status, borrow_name));
        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher(path).forward(req,resp);
    }
}
