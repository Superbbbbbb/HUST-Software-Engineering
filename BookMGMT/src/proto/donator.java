package proto;

public class donator {

    public donator(int num, String name) {
        this.name = name;
        this.num = num;
    }

    private String name;
    private int num;

    public String get_name(){
        return this.name;
    }

    public int get_num(){
        return this.num;
    }

}
