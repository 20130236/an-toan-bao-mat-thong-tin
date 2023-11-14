package controller.admin;

import controller.admin.datatable.DataTable;
import mapper.ProductMapper;
import mapper.RoleMapper;
import model.Log;
import model.Role;
import model.UserModel;
import service.LogService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "GetDataRole", value = "/GetDataRole")
public class GetDataRole extends HttpServlet {
    String name = "List-Role";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Log log = new Log(Log.INFO,currentUser.getId(),this.name,"",0,IpAddress.getClientIpAddr(request));
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, String> parameterMap = getParameterMap(request);
        String roles;
        try {
            long start = Long.parseLong(parameterMap.get("start"));
            int length = Integer.parseInt(parameterMap.get("length"));
            int draw = Integer.parseInt(parameterMap.get("draw"));
            roles = new DataTable<Role>().table("roles",draw ,start, length).build(Role.class, new RoleMapper(),"id");
            log.setContent(roles);
            LogService.addLog(log);
            out.println(roles);
            out.flush();
        } catch (NumberFormatException e){
            out.println("Error");
            out.flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private Map<String, String> getParameterMap(HttpServletRequest request) {
        Map<String, String> map = new HashMap<String, String>();
        Enumeration<String> names = request.getParameterNames();
        while (names.hasMoreElements()) {
            String name = names.nextElement();
            String value = request.getParameter(name);
            map.put(name, value);
        }
        return map;
    }
}