package model;

import controller.admin.datatable.Item;

import java.sql.Date;

public class ImportProduct extends Item {

    private String name;
    private int [] ids;
    private int [] quantities;
    int pro_id;
    String username;
    int quantity;
    Date date;

    public ImportProduct() {

    }

    public ImportProduct(int pro_id, String username, int quantity, Date date) {
        this.pro_id = pro_id;
        this.username = username;
        this.quantity = quantity;
        this.date = date;
    }

    public int getPro_id() {
        return pro_id;
    }

    public void setPro_id(int pro_id) {
        this.pro_id = pro_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int[] getIds() {
        return ids;
    }

    public void setIds(int[] ids) {
        this.ids = ids;
    }

    public int[] getQuantities() {
        return quantities;
    }

    public void setQuantities(int[] quantities) {
        this.quantities = quantities;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String[] toArray() {
        return new String[]{
                String.valueOf(pro_id),
                username,
                String.valueOf(quantity),
                String.valueOf(date),
        };
    }
}
