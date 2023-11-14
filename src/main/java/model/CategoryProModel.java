package model;

import controller.admin.datatable.Item;

public class CategoryProModel extends Item {
    private int [] ids;
    private int id;
    private String name;
    private int numbOfPro;

    public CategoryProModel(int id, String name, int numbOfPro) {
        this.id = id;
        this.name = name;
        this.numbOfPro = numbOfPro;
    }

    public CategoryProModel() {

    }

    public int getId() {
        return id;
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

    public int getNumbOfPro() {
        return numbOfPro;
    }

    public void setNumbOfPro(int numbOfPro) {
        this.numbOfPro = numbOfPro;
    }

    @Override
    public String[] toArray() {
        return new String[]{
                String.valueOf(id),
                name,
                String.valueOf(numbOfPro)
        };
    }

    public int [] getIds() {
        return  ids;
    }

}
