package service;

import dao.CategoryProDAO;
import model.CategoryProModel;

import java.util.List;

public class CategoryProService {
    public static void addCate(String name){
        CategoryProDAO.addCate(name);
    }

    public static void deleteCate(int id){
        CategoryProDAO.deleteCate(id);
    }

    public static void updateCate(int id, String name){
        CategoryProDAO.updateCate(id,name);
    }

    public static List<CategoryProModel> findAll(){
        return CategoryProDAO.findAll();
    }

    public static CategoryProModel findById(int id){
        return CategoryProDAO.findById(id);
    }
}
