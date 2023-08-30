package controller;

import dao.adminDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import proto.admin;

import java.io.IOException;

import static email.mail.send_mail;

@WebServlet("/emailServlet")
public class emailServlet extends HttpServlet {

    String path;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        path = "login.jsp";
        String mail = req.getParameter("mail");
        adminDao ad = new adminDao();

        try {
            admin a = ad.Search(mail);
            if(a!=null){
                send_mail(mail, a.get_password());
            }
            else{
                req.setAttribute("message", "邮箱未注册");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher(path).forward(req,resp);
    }
}