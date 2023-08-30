package proto;

public class register {

    public register(String mail, String password, String name) {
        this.mail = mail;
        this.password = password;
        this.name = name;
    }

    private String mail;//手机号
    private String password;//密码
    private String name;

    public String get_mail(){
        return this.mail;
    }

    public String get_password(){
        return this.password;
    }

    public String get_name(){
        return this.name;
    }
}
