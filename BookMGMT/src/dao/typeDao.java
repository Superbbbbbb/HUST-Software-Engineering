package dao;

import proto.type;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static Util.DBUtil.*;

public class typeDao {

    public void add_type(type t)throws SQLException {
        conn = getConnectDb();
        String sql="insert into type" + "(name)" + "values(?)";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, t.get_name());
        psmt.execute();
        CloseDB(null, psmt, conn);
    }

    public type Search(String name) throws SQLException{
        String sql = "select * from type where name = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, name);
        ResultSet rs = psmt.executeQuery();
        type t = null;
        while(rs.next()){
            t = new type(rs.getInt("id"),rs.getString("name"),0);
        }
        return t;
    }

    public type Search(int id) throws SQLException{
        conn = getConnectDb();
        String sql = "select * from type where Id = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setInt(1, id);
        ResultSet rs = psmt.executeQuery();
        type t = null;
        while(rs.next()){
            t = new type(rs.getInt("id"),rs.getString("name"),0);
        }
        CloseDB(rs, psmt, conn);
        return t;
    }

    public List<type> SearchList() throws SQLException{
        conn = getConnectDb();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select id,name from type");
        List<type> typeList = new ArrayList<>();
        type t;
        while(rs.next()){
            t = new type(rs.getInt("id"),rs.getString("name"),0);
            typeList.add(t);
        }
        CloseDB(rs, stmt, conn);
        return typeList;
    }

    public List<type> SearchList(int school) throws SQLException{
        conn = getConnectDb();
        String sql = "select distinct id,name,t.num from type,(select type,count(type) as num from book where school = ? group by type) as t where id=t.type ";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setInt(1, school);
        ResultSet rs = psmt.executeQuery();
        List<type> typeList = new ArrayList<>();
        type t;
        while(rs.next()){
            t = new type(rs.getInt("id"),rs.getString("name"),rs.getInt("num"));
            typeList.add(t);
        }
        CloseDB(rs, psmt, conn);
        return typeList;
    }
}
