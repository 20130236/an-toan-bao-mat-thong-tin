package dao;

import model.Permission;
import model.Role;
import model.RoleModel;
import model.UserModel;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoleDAO {

    public static List<Role> findAll() {
        List<Role> roles ;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            roles = new ArrayList<>();
            sql = "select id,title from roles";
            pst = DBConnection.getConnection().prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                roles.add(new Role(rs.getInt("id"),rs.getString("title"),countUser(rs.getInt("id"))));
            }
            return roles;
        }
            catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static int findId(String name) {
        int id = -1;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "select id from roles where title = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,name);
            rs = pst.executeQuery();
            while (rs.next()) {
                id = rs.getInt("id");
            }
            return id;
        }
        catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public static String findName(int id) {
        String name = null;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "select title from roles where id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            rs = pst.executeQuery();
            while (rs.next()) {
                name = rs.getString("title");
            }
            return name;
        }
        catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static int countUser(int id) {
        int count = 0;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "select count(role) as number from users where role = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            rs = pst.executeQuery();
            while (rs.next()) {
                count = rs.getInt("number");
            }
            return count;
        }
        catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public static void addRole(RoleModel role){
        PreparedStatement pst;
        String sql;
        try {
            sql = "insert into roles(`title`) VALUES(?)";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,role.getTitle());
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        addPermissions(findId(role.getTitle()),role.getIdPermissions());
    }

    private static void addPermissions(int role_id,int [] ids){
        for(int i = 0; i < ids.length ; i++){
            addPermission(role_id,ids[i]);
        }
    }

    private static void addPermission(int role_id,int id_permiss) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "insert into role_permission (id_role,id_permiss) values (?,?)";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,role_id);
            pst.setInt(2,id_permiss);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static void updateRole(RoleModel role){
            int id = role.getId();
            String name = role.getTitle();
            updateName(id,name);
            deleteRolePermiss(id);
            for (int i : role.getIdPermissions()){
                addPermission(id,i);
            }
    }

    private static void updateName(int id,String name){
        PreparedStatement pst;
        String sql;
        try {
            sql = "update roles set title = ? where id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,name);
            pst.setInt(2,id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static Role findById(int id) {
        ArrayList<Permission> permissions;
        Role role ;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        int index = 0;
        int count = 1;
        int [] ids = new int[1];
        try {
            role = new Role();
            permissions = new ArrayList<>();
            sql = "select r.title as role,id_role,id_permiss,p.title as permiss from  roles r INNER JOIN role_permission r_p on r.id = r_p.id_role INNER JOIN permission p on p.id = r_p.id_permiss where id_role = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            rs = pst.executeQuery();
            while (rs.next()) {
                ids = reSize(ids,count);
                ids[index] = rs.getInt("id_permiss");
                permissions.add(new Permission(rs.getInt("id_permiss"),rs.getString("permiss")));
                count++;
                index++;
            }
            role.setId(id);
            role.setName(findName(id));
            role.setPermission(permissions);
            role.setIdPermissions(ids);
            return role;
        }
        catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static int findIdPermissionByName(String name){
        int id = -1;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "select id from permission where title = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,name);
            rs = pst.executeQuery();
            while (rs.next()) {
              id = rs.getInt("id");
            }
            return id;
        }
        catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public static ArrayList<Permission> getAllpermiss(){
        ArrayList<Permission> permissions;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            permissions = new ArrayList<>();
            sql = "select * from permission";
            pst = DBConnection.getConnection().prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                permissions.add(new Permission(rs.getInt("id"),rs.getString("title")));
            }
            return permissions;
        }
        catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    private static void deleteRole(int id) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "delete from roles where id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static void delete(int id){
        deleteRolePermiss(id);
        deleteRole(id);
    }

    private static void deleteRolePermiss(int id){
        PreparedStatement pst;
        String sql;
        try {
            sql = "delete from role_permission where id_role = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
    private  static int[] reSize(int[] a, int size){
        int[] temp = new int [size];
        System.arraycopy(a, 0, temp, 0, (a.length < size) ? a.length : size);
        return temp;
    }

    public static void main(String[] args) {
        System.out.println( findById(1));
    }

    public static void deletes(RoleModel roleModel) {
        for (int i: roleModel.getIds()) {
            delete(i);
        }
    }

    public static List<RoleModel> getByIds(RoleModel roleModel) {
        List<RoleModel> roles = new ArrayList<>();
        for (int i: roleModel.getIds()) {
            findById(i);
        }
        return roles;
    }
}
