package dao;

import proto.register;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import static Util.DBUtil.*;

public class registerDao {

    public void register(register r)throws SQLException {
        conn = getConnectDb();
        String sql="insert into register" + "(mail,pwd,name) " + "values(?,?,?)";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, r.get_mail());
        psmt.setString(2, r.get_password());
        psmt.setString(3, r.get_name());
        psmt.execute();
        CloseDB(null, psmt, conn);
    }

    public void delete_register(String mail) throws SQLException{
        conn = getConnectDb();
        String sql = "delete from register where mail = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, mail);
        psmt.execute();
        CloseDB(null, psmt, conn);
    }

    public register Search(String mail) throws SQLException{
        conn = getConnectDb();
        String sql = "select * from register where mail = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1,mail);
        ResultSet rs = psmt.executeQuery();
        register r = null;
        if(rs.next())
            r = new register(rs.getString("mail"),rs.getString("pwd"),rs.getString("name"));
        CloseDB(rs, psmt, conn);
        return r;
    }

    public List<register> SearchList() throws SQLException{
        conn = getConnectDb();
        Statement stmt = conn.createStatement();
        ResultSet rs =  stmt.executeQuery("select * from register");
        List<register> registerList = new ArrayList<>();
        register r;
        while(rs.next()){
            r = new register(rs.getString("mail"),rs.getString("pwd"),rs.getString("name"));
            registerList.add(r);
        }
        CloseDB(rs, stmt, conn);
        return registerList;
    }

}
