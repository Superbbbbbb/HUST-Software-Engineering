package controller;

import dao.adminDao;
import proto.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {

    String path;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String mail = req.getParameter("mail");
        String pwd = req.getParameter("pwd");

        adminDao ad = new adminDao();
        try {
            if(ad.Login(mail,pwd)) {
                admin a = ad.Search(mail);
                path = "index.jsp";
                req.setAttribute("admin",a.get_id());
            }
            else{
                path = "login.jsp";
                req.setAttribute("message","邮箱地址或密码错误");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher(path).forward(req,resp);
    }
}
