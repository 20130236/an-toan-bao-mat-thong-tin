package controller.admin;

import model.Permission;

import java.security.Permissions;
import java.util.ArrayList;

public class Access {
    public static boolean checkAccess(ArrayList<Permission> permissions, int access){
        for(Permission permiss : permissions){
            if(permiss.getId() == access){
                return true;
            }
        }
        return false;
    }
}
