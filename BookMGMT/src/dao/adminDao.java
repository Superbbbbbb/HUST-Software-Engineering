package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import proto.admin;
import proto.register;

import static Util.DBUtil.*;

public class adminDao {

    public boolean Login(String mail, String password) throws SQLException {
        conn = getConnectDb();
        String sql = "select * from admin where mail = ? and pwd = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, mail);
        psmt.setString(2, password);
        ResultSet rs = psmt.executeQuery();
        boolean x = rs.next();
        CloseDB(rs, psmt, conn);
        return x;
    }

    public void add_admin(register r)throws SQLException{
        conn = getConnectDb();
        String sql="insert into admin" + "(mail,pwd,name) " + "values(?,?,?)";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, r.get_mail());
        psmt.setString(2, r.get_password());
        psmt.setString(3, r.get_name());
        psmt.execute();
        CloseDB(null, psmt, conn);
    }

    public void update_admin(int id,int status)throws SQLException{
        conn = getConnectDb();
        String sql = "update admin set status = ? where Id = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setInt(1, status);
        psmt.setInt(2, id);
        psmt.execute();
        CloseDB(null, psmt, conn);
    }

    public void update_admin(admin a)throws SQLException{
        conn = getConnectDb();
        String sql = "update admin set mail = ?, pwd = ?, name = ? where Id = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, a.get_mail());
        psmt.setString(2, a.get_password());
        psmt.setString(3, a.get_name());
        psmt.setInt(4, a.get_id());
        psmt.execute();
        CloseDB(null, psmt, conn);
    }

    public void delete_admin(int id) throws SQLException{
        conn = getConnectDb();
        String sql = "delete from admin where Id = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setInt(1, id);
        psmt.execute();
        CloseDB(null, psmt, conn);
    }

    public admin Search(int id) throws SQLException{
        conn = getConnectDb();
        String sql = "select * from admin where Id = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setInt(1, id);
        ResultSet rs = psmt.executeQuery();
        admin a = null;
        while(rs.next()){
            a = new admin(rs.getInt("Id"),rs.getString("mail"),rs.getString("pwd"),rs.getInt("status"),rs.getString("name"));
        }
        CloseDB(rs, psmt, conn);
        return a;
    }

    public admin Search(String mail) throws SQLException{
        conn = getConnectDb();
        String sql = "select * from admin where mail = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, mail);
        ResultSet rs = psmt.executeQuery();
        admin a = null;
        while(rs.next()){
            a = new admin(rs.getInt("Id"),rs.getString("mail"),rs.getString("pwd"),rs.getInt("status"),rs.getString("name"));
        }
        CloseDB(rs, psmt, conn);
        return a;
    }

    public List<admin> SearchList() throws SQLException{
        conn = getConnectDb();
        Statement stmt = conn.createStatement();
        ResultSet rs =  stmt.executeQuery("select Id,mail,status,name from admin");
        List<admin> adminList = new ArrayList<>();
        admin a;
        while(rs.next()){
            a = new admin(rs.getInt("Id"), rs.getString("mail"),null,rs.getInt("status"),rs.getString("name"));
            adminList.add(a);
        }
        CloseDB(rs, stmt, conn);
        return adminList;
    }
}

