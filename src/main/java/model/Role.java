package model;

import controller.admin.datatable.Item;

import java.util.ArrayList;
import java.util.Arrays;

public class Role extends Item {
    private int id;
    private String name;

    private ArrayList<Permission> permission;

    private int numUser;

    private int [] idPermissions;
    public Role(){

    }

    public Role(int id, String name,int numUser) {
        this.id = id;
        this.name = name;
        this.numUser = numUser;
    }

    public Role(ArrayList<Permission> permission) {
        this.permission = permission;
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

    public ArrayList<Permission> getPermission() {
        return permission;
    }

    public void setPermission(ArrayList<Permission> permission) {
        this.permission = permission;
    }

    public int getNumUser() {
        return numUser;
    }

    public void setNumUser(int numUser) {
        this.numUser = numUser;
    }

    public int[] getIdPermissions() {
        return idPermissions;
    }

    public void setIdPermissions(int[] idPermissions) {
        this.idPermissions = idPermissions;
    }

    @Override
    public String toString() {
        return "Role{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", permission=" + permission +
                ", numUser=" + numUser +
                ", idPermissions=" + Arrays.toString(idPermissions) +
                '}';
    }

    @Override
    public String[] toArray() {
        return new String[]{
                String.valueOf(id),
                name,
                String.valueOf(numUser)
        };
    }
}
