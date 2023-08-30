package proto;

public class type {

    public type(int id,String name,int num) {
        this.id = id;
        this.name = name;
        this.num = num;
    }

    public type(String name) {
        this.name = name;
    }

    /**
     * 用户的数据表的bean
     */
    private int id;
    private String name;
    private int num;

    public int get_id(){
        return this.id;
    }

    public String get_name(){
        return this.name;
    }

    public int get_num(){
        return this.num;
    }
}
