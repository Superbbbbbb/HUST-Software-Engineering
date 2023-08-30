package proto;

import java.util.Date;

public class book{
    public book(String name,int type,int school,String donator) {
        this.name = name;
        this.type = type;
        this.school = school;
        this.donator = donator;
    }

    public book(int id,String name,int type,int school,String donator,int status,String borrow_name) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.school = school;
        this.donator = donator;
        this.status = status;
        this.borrow_name = borrow_name;
    }

    public book(int id,String name,int type,Date date,String donator,int status,String borrow_name,Date lend_date) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.date = date;
        this.donator = donator;
        this.status = status;
        this.borrow_name = borrow_name;
        this.lend_date = lend_date;
    }

    private int id;
    private String name;
    private int type;
    private int school;
    private Date date;
    private String donator;

    private int status;//用来判断是否被借走，借走0，未借走1
    private String borrow_name;//借阅者
    private Date lend_date;

    public int get_id(){
        return this.id;
    }

    public String get_name(){
        return this.name;
    }

    public Date get_date(){
        return this.date;
    }

    public int get_type(){
        return this.type;
    }

    public int get_school(){
        return this.school;
    }

    public String get_donator(){
        return this.donator;
    }

    public int get_status(){
        return this.status;
    }

    public String get_borrow_name(){
        return this.borrow_name;
    }

    public Date get_lend_date(){
        return this.lend_date;
    }

}
