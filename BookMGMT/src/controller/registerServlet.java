package controller;

import dao.*;
import proto.register;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/registerServlet")
public class registerServlet extends HttpServlet {

    String path;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String name = req.getParameter("name");
        String mail = req.getParameter("mail");
        String pwd = req.getParameter("pwd");
        registerDao rd = new registerDao();
        adminDao ad = new adminDao();
        try {
            if(ad.Search(mail)!=null) {
                path = "register.jsp";
                req.setAttribute("message","邮箱已注册");
            }
            else {
                path = "index.jsp";
                rd.register(new register(mail,pwd,name));
                req.setAttribute("message","申请成功，请等待总管理员审核！");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher(path).forward(req,resp);
    }
}
