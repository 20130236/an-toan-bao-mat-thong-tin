package controller.admin.API;

import com.fasterxml.jackson.databind.ObjectMapper;
import controller.admin.IpAddress;
import dao.UserDAO;
import model.Log;
import model.UserModel;
import service.LogService;
import service.UserService;
import util.HttpUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/api-admin-user"})
public class UserAPI extends HttpServlet {
    String name="List-User";
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Log log = new Log(Log.INFO,currentUser.getId(),this.name,"",0, IpAddress.getClientIpAddr(request));
        ObjectMapper mapper = new ObjectMapper();
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        UserModel userModel =  HttpUtil.of(request.getReader()).toModel(UserModel.class);
        UserDAO.deletes(userModel);
        mapper.writeValue(response.getOutputStream(), "{}");
        log.setSrc(this.name + " DELETE ");
        log.setContent(UserService.getByIds(userModel).toString());
        log.setLevel(Log.WARNING);
        LogService.addLog(log);
    }
}
