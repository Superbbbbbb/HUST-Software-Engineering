package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/returnServlet")
public class returnServlet extends HttpServlet {

    String path = "index.jsp";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String admin = req.getParameter("admin");
        if(admin!=null) {
            int a = Integer.parseInt(admin);
            req.setAttribute("admin", a);
        }

        req.getRequestDispatcher(path).forward(req,resp);
    }

}
