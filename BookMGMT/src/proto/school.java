package proto;

import java.util.Date;

public class school {

    public school(String name, int adminId) {
        this.name = name;
        this.adminId = adminId;
    }

    public school(int id, String name, int adminId) {
        this.id = id;
        this.name = name;
        this.adminId = adminId;
    }

    public school(int id, String name, Date date, int adminId) {
        this.id = id;
        this.name = name;
        this.date = date;
        this.adminId = adminId;
    }

    /**
     * 用户的数据表的bean
     */
    private int id;
    private String name;
    private Date date;
    private int adminId;

    public int get_id(){
        return this.id;
    }

    public String get_name(){
        return this.name;
    }

    public Date get_date(){
        return this.date;
    }

    public int get_admin(){
        return this.adminId;
    }

}
