package controller;

import dao.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import proto.school;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin_deleteServlet")
public class admin_deleteServlet extends HttpServlet {

    String path = "admin_super.jsp";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        adminDao ad = new adminDao();
        schoolDao sd = new schoolDao();
        List<school> schoolList;

        try {
            schoolList = sd.SearchList(id);
            if(schoolList.size()==0){
                ad.delete_admin(id);
            }
            else{
                req.setAttribute("message","删除失败！仍有学校在该管理员的管理权限内,请先将这些学校的管理权限校移交给其他管理员再进行删除操作！");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher(path).forward(req,resp);
    }
}
