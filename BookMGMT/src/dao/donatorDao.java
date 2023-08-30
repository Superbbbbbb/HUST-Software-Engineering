package dao;

import proto.donator;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static Util.DBUtil.*;

public class donatorDao {

    public List<donator> Search(int school) throws SQLException{
        conn = getConnectDb();
        String sql = "select distinct donator,count(donator) as num from book where school = ? group by donator order by num desc";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setInt(1, school);
        ResultSet rs = psmt.executeQuery();
        List<donator> donatorList = new ArrayList<>();
        donator d;
        while(rs.next()){
            d = new donator(rs.getInt("num"), rs.getString("donator"));
            donatorList.add(d);
        }
        CloseDB(rs, psmt, conn);
        return donatorList;
    }
}
