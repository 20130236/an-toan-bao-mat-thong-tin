package model;

public class RoleModel {
    private int [] ids;

    private int id;
    private String title;
    private int [] idPermissions;

    public int[] getIds() {
        return ids;
    }

    public void setIds(int[] ids) {
        this.ids = ids;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int[] getIdPermissions() {
        return idPermissions;
    }

    public void setIdPermissions(int[] idPermissions) {
        this.idPermissions = idPermissions;
    }

}
