package service;

import dao.DBConnection;
import model.Introduce;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class IntroService {
    public Introduce getIntro(){
        Introduce intro = null;
        String sql = "Select  * FROM introduce";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            ps = DBConnection.getConnection().prepareStatement(sql);

            rs = ps.executeQuery(sql);
            while (rs.next()){
                intro = new Introduce(rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),rs.getString(8),rs.getString(9));
            }
            rs.close();
        } catch (Exception e){
            e.printStackTrace();
        }
        return intro;



    }
    public void editIntro(String name,String introduce, String address, String showroom, String timework, String email, String phone, String caption){
        String sql = "UPDATE introduce SET  name = ?, introduce = ?, address = ?, showroom = ?, timework = ?, email = ?,phone = ?, caption = ? WHERE id = 1";
        PreparedStatement ps = null;

        int rs = 0;
        try{
            ps = DBConnection.getConnection().prepareStatement(sql);
            ps.setString(1,name);
            ps.setString(2,introduce);
            ps.setString(3,address);
            ps.setString(4,showroom);
            ps.setString(5,timework);
            ps.setString(6,email);
            ps.setString(7,phone);
            ps.setString(8,caption);
            rs = ps.executeUpdate();


        } catch (Exception e){
            e.printStackTrace();
        }


    }

    public static void main(String[] args) {

    }
}
