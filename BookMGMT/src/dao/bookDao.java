package dao;

import proto.*;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static Util.DBUtil.*;

public class bookDao {

    public void add_book(book b) throws SQLException {
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(d);

        conn = getConnectDb();
        String sql = "insert into book" + "(name,type,school,date,donator)" + "values(?,?,?,?,?)";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, b.get_name());
        psmt.setInt(2, b.get_type());
        psmt.setInt(3, b.get_school());
        psmt.setDate(4, java.sql.Date.valueOf(date));
        psmt.setString(5, b.get_donator());
        psmt.execute();

        CloseDB(null, psmt, conn);
    }

    public void update_book(book b) throws SQLException {
        Date dt = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(dt);

        conn = getConnectDb();
        String sql = "update book set name = ?, type = ? ,donator = ?, status = ?, borrow_name = ? ,lend_date = ? where Id = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, b.get_name());
        psmt.setInt(2, b.get_type());
        psmt.setString(3, b.get_donator());
        psmt.setInt(4,b.get_status());
        if(b.get_status()==1) {
            psmt.setString(5, b.get_borrow_name());
            psmt.setDate(6, java.sql.Date.valueOf(date));
        }
        else{
            psmt.setString(5, null);
            psmt.setDate(6, null);
        }
        psmt.setInt(7, b.get_id());
        psmt.execute();

        CloseDB(null, psmt, conn);
    }

    public void delete_book(int id) throws SQLException {
        conn = getConnectDb();
        String sql = "delete from book where Id = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setInt(1, id);
        psmt.execute();

        CloseDB(null, psmt, conn);
    }

    public book Search(int id) throws SQLException {
        conn = getConnectDb();
        String sql = "select * from book where Id = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setInt(1, id);
        ResultSet rs = psmt.executeQuery();
        book b = null;
        while (rs.next()) {
            b = new book(rs.getInt("Id"), rs.getString("name"), rs.getInt("type")
                    , rs.getDate("date"), rs.getString("donator")
                    , rs.getInt("status"), rs.getString("borrow_name"), rs.getDate("lend_date"));
        }
        CloseDB(rs, psmt, conn);
        return b;
    }

    public List<book> SearchName(String name,int school) throws SQLException {
        conn = getConnectDb();
        String sql = "select * from book where name like ? and school = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, "%"+name+"%");
        psmt.setInt(2, school);
        ResultSet rs = psmt.executeQuery();
        List<book> bookList = new ArrayList<>();
        book b;
        while (rs.next()) {
            b = new book(rs.getInt("Id"), rs.getString("name"), rs.getInt("type")
                    , rs.getDate("date"), rs.getString("donator")
                    , rs.getInt("status"), rs.getString("borrow_name"), rs.getDate("lend_date"));
            bookList.add(b);
        }
        CloseDB(rs, psmt, conn);
        return bookList;
    }

    public List<book> SearchList(int type,int school) throws SQLException {
        conn = getConnectDb();
        String sql = "select * from book where type = ? and school = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setInt(1, type);
        psmt.setInt(2, school);
        ResultSet rs = psmt.executeQuery();
        List<book> bookList = new ArrayList<>();
        book b;
        while (rs.next()) {
            b = new book(rs.getInt("Id"), rs.getString("name"), rs.getInt("type")
                    , rs.getDate("date"), rs.getString("donator")
                    , rs.getInt("status"), rs.getString("borrow_name"), rs.getDate("lend_date"));
            bookList.add(b);
        }
        CloseDB(rs, psmt, conn);
        return bookList;
    }
}
