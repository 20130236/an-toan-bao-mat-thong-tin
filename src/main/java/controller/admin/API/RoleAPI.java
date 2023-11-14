package controller.admin.API;

import com.fasterxml.jackson.databind.ObjectMapper;
import controller.admin.IpAddress;
import dao.RoleDAO;
import dao.UserDAO;
import model.Log;
import model.RoleModel;
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

@WebServlet(urlPatterns = {"/api-admin-role"})
public class RoleAPI extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Log log = new Log(Log.ALERT,currentUser.getId(),  " ADD ROLE","",0, IpAddress.getClientIpAddr(request));
        ObjectMapper mapper = new ObjectMapper();
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        RoleModel roleModel =  HttpUtil.of(request.getReader()).toModel(RoleModel.class);
        log.setContent(roleModel.toString());
        RoleDAO.addRole(roleModel);
        LogService.addLog(log);
        mapper.writeValue(response.getOutputStream(), roleModel);
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Log log = new Log(Log.ALERT,currentUser.getId(),  " UPDATE ROLE","",0, IpAddress.getClientIpAddr(request));
        ObjectMapper mapper = new ObjectMapper();
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        RoleModel roleModel =  HttpUtil.of(request.getReader()).toModel(RoleModel.class);
        log.setContent(roleModel.toString());
        RoleDAO.updateRole(roleModel);
        LogService.addLog(log);
        mapper.writeValue(response.getOutputStream(), roleModel);
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Log log = new Log(Log.INFO,currentUser.getId(),"DELETE","",0, IpAddress.getClientIpAddr(request));
        ObjectMapper mapper = new ObjectMapper();
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        RoleModel roleModel =  HttpUtil.of(request.getReader()).toModel(RoleModel.class);
        RoleDAO.deletes(roleModel);
        mapper.writeValue(response.getOutputStream(), "{}");
        log.setSrc(" DELETE ");
        log.setContent(RoleDAO.getByIds(roleModel).toString());
        log.setLevel(Log.WARNING);
        LogService.addLog(log);
    }
}
