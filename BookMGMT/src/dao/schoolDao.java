package dao;

import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import proto.school;

import static Util.DBUtil.*;

/**
 * 有关读者账号的连接数据库操作，登录验证，注册，修改账号，修改密码
 */
public class schoolDao {

    public void add_school(school s) throws SQLException {
        conn = getConnectDb();
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(d);

        String sql = "insert into school" + "(name,date,adminId) " + "values(?,?,?)";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, s.get_name());
        psmt.setDate(2, java.sql.Date.valueOf(date));
        psmt.setInt(3, s.get_admin());
        psmt.execute();
        CloseDB(null, psmt, conn);
    }

    public void update_school(school s) throws SQLException {
        conn = getConnectDb();
        String sql = "update school set name = ?, adminId = ? where Id = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, s.get_name());
        psmt.setInt(2, s.get_admin());
        psmt.setInt(3, s.get_id());
        psmt.execute();
        CloseDB(null, psmt, conn);
    }

    public void delete_school(int id) throws SQLException {
        conn = getConnectDb();
        String sql = "delete from school where Id = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setInt(1, id);
        psmt.execute();

        sql = "delete from book where school = ?";
        psmt = conn.prepareStatement(sql);
        psmt.setInt(1, id);
        psmt.execute();
    }

    public String Search(int id) throws SQLException {
        conn = getConnectDb();
        String sql = "select name from school where Id = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setInt(1, id);
        ResultSet rs = psmt.executeQuery();
        String s = null;
        while (rs.next()) {
            s = rs.getString("name");
        }
        CloseDB(rs, psmt, conn);
        return s;
    }

    public List<school> SearchList(int admin) throws SQLException {
        conn = getConnectDb();
        String sql = "select * from school where adminId = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setInt(1, admin);
        ResultSet rs = psmt.executeQuery();
        List<school> schoolList = new ArrayList<>();
        school s;
        while (rs.next()) {
            s = new school(rs.getInt("Id"), rs.getString("name"), rs.getInt("adminId"));
            schoolList.add(s);
        }
        CloseDB(rs, psmt, conn);
        return schoolList;
    }


    public List<school> SearchList() throws SQLException {
        conn = getConnectDb();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select Id,name,date,adminId from school");
        List<school> schoolList = new ArrayList<>();
        school s;
        while (rs.next()) {
            s = new school(rs.getInt("Id"), rs.getString("name"), rs.getDate("date")
                    , rs.getInt("adminId"));
            schoolList.add(s);
        }
        CloseDB(rs, stmt, conn);
        return schoolList;
    }
}

