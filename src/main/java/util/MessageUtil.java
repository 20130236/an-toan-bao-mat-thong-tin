package util;

import javax.servlet.http.HttpServletRequest;

public class MessageUtil {

    public static void showMessage(HttpServletRequest request) {
        if (request.getParameter("message") != null) {
            String messageResponse = "";
            String alert = "";
            String message = request.getParameter("message");
            if (message.equals("insert_success")) {
                messageResponse = "Insert success";
                alert = "success";
            } else if (message.equals("update_success")) {
                messageResponse = "Update success";
                alert = "success";
            } else if (message.equals("delete_success")) {
                messageResponse = "Delete success";
                alert = "success";
            } else if (message.equals("error_system")) {
                messageResponse = "Error system";
                alert = "danger";
            } else if (message.equals("role_reset")){
                messageResponse = "Something had changed pls re-login";
                alert = "warning";
            }  else if (message.equals("not_permission")){
                messageResponse = "You don't have permission";
                alert = "danger";
            }  else if (message.equals("not_login")){
                messageResponse = "You need login";
                alert = "danger";
            }
            request.setAttribute("messageResponse", messageResponse);
            request.setAttribute("alert", alert);
        }
    }
}

