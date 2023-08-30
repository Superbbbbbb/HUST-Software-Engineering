package proto;

public class admin {

    public admin(int id, int status) {
        this.id = id;
        this.status = status;
    }

    public admin(int id, String mail,String password,String name) {
        this.id = id;
        this.mail = mail;
        this.password = password;
        this.name = name;
    }

    public admin(int id, String mail,String password,int status, String name) {
        this.id = id;
        this.mail = mail;
        this.password = password;
        this.status = status;
        this.name = name;
    }

    private int id;
    private String mail;//手机号
    private String password;//密码
    private int status;
    private String name;

    public int get_id(){
        return this.id;
    }

    public String get_mail(){
        return this.mail;
    }

    public String get_password(){
        return this.password;
    }

    public int get_status(){
        return this.status;
    }

    public String get_name(){
        return this.name;
    }
}
