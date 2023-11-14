package model;

public class Permission {
    private int id;
    private String name;

    public int getId() {
        return id;
    }

    public Permission(String permiss){
        this.name = permiss;
    }

    public Permission(int id,String name){
        this.id = id;
        this.name = name;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Permission{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}