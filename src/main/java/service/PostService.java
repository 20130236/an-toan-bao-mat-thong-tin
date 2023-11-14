package service;

import dao.DBConnection;
import model.Post;
import model.Post_Category;
import model.Post_Image;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PostService {
    public static List<Post> getAllPost(){
        List<Post> list = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql;
        try{
            sql = "select * from posts";
            ps = DBConnection.getConnection().prepareStatement(sql);
            list = new ArrayList<>();

            rs = ps.executeQuery(sql);
            while (rs.next()){
                Post ar = new Post(rs.getInt(1), rs.getInt(2),rs.getString(3), rs.getString(4), rs.getString(5));
                list.add(ar);
            }

        }catch (Exception e){
            e.printStackTrace();
        }


        return list;
    }
    public static Post getPostById(int id){
        Post ar = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql;
        try{
            sql = "select * from posts where post_id = " + id;
            ps = DBConnection.getConnection().prepareStatement(sql);

            rs = ps.executeQuery(sql);
            while (rs.next()){
                ar = new Post(rs.getInt(1), rs.getInt(2),rs.getString(3), rs.getString(4), rs.getString(5));

            }

        }catch (Exception e){
            e.printStackTrace();
        }


        return ar;
    }
    public ArrayList<Post_Image> getImage(int id){
        ArrayList<Post_Image> imgUrl = new ArrayList<>();
        Post_Image img = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql;
        try{
            sql = "select * from posts_image where post_id = " + id;
            ps = DBConnection.getConnection().prepareStatement(sql);

            rs = ps.executeQuery(sql);
            while (rs.next()){
                img = new Post_Image(rs.getInt(1), rs.getInt(2),rs.getString(3));
                imgUrl.add(img);
            }

        }catch (Exception e){
            e.printStackTrace();
        }


        return imgUrl;

    }
    public static int getTotalPost(){
        String sql = "Select  count(*) from posts";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            ps = DBConnection.getConnection().prepareStatement(sql);

            rs = ps.executeQuery(sql);
            while (rs.next()){
               return rs.getInt(1);
            }

        } catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }
    public List<Post> pagingPost(int index){
        List<Post> list = new ArrayList<>();
        String sql = "SELECT * FROM posts\n" +
                "ORDER BY post_id LIMIT "+((index -1) * 10)+",10";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            ps = DBConnection.getConnection().prepareStatement(sql);

            rs = ps.executeQuery(sql);
            while (rs.next()){
                Post ar = new Post(rs.getInt(1), rs.getInt(2),rs.getString(3), rs.getString(4), rs.getString(5));
                list.add(ar);
            }

        }catch (Exception e){

        }
        return list;
    }
    public static List<Post_Category> getListPostCategory() {
        List<Post_Category> list = new ArrayList();
        String sql = "Select post_category_id, post_category_name  from posts_category";
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = DBConnection.getConnection().prepareStatement(sql);
            rs = ps.executeQuery(sql);

            while(rs.next()) {
                Post_Category ac = new Post_Category(rs.getInt(1), rs.getString(2));
                list.add(ac);
            }
        } catch (Exception var6) {
            var6.printStackTrace();
        }

        return list;
    }
    public static List<Post> getAllPostByCID(int id){
        List<Post> list = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql;
        try{
            sql = "SELECT * FROM posts WHERE post_category_id = "+ id;
            ps = DBConnection.getConnection().prepareStatement(sql);
            list = new ArrayList<>();

            rs = ps.executeQuery(sql);
            while (rs.next()){
                Post ar = new Post(rs.getInt(1), rs.getInt(2),rs.getString(3), rs.getString(4), rs.getString(5));
                list.add(ar);
            }

        }catch (Exception e){
            e.printStackTrace();
        }


        return list;
    }
    public int getNumPostCID(int id){
        String sql = "Select  count(*) FROM posts WHERE post_category_id = "+ id;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            ps = DBConnection.getConnection().prepareStatement(sql);

            rs = ps.executeQuery(sql);
            while (rs.next()){
                return rs.getInt(1);
            }

        } catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }
    //tin tuc moi nhat
    public static List<Post> getNewPost(){
        List<Post> list = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql;
        try{
            sql = "(SELECT * FROM posts ORDER BY date DESC) LIMIT 3";
            ps = DBConnection.getConnection().prepareStatement(sql);
            list = new ArrayList<>();

            rs = ps.executeQuery(sql);
            while (rs.next()){
                Post ar = new Post(rs.getInt(1), rs.getInt(2),rs.getString(3), rs.getString(4),rs.getString(5));
                list.add(ar);
            }

        }catch (Exception e){
            e.printStackTrace();
        }


        return list;
    }
    public static void main(String[] args) {
        PostService p = new PostService();
        System.out.println(p.pagingPost(2));

    }
}
