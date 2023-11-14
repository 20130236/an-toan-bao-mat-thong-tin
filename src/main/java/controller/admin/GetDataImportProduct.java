package controller.admin;

import controller.admin.datatable.DataTable;
import mapper.ImportProductMapper;
import model.ImportProduct;
import model.Log;
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

@WebServlet(name = "GetDataImportProduct", value = "/GetDataImportProduct")
public class GetDataImportProduct extends HttpServlet {
    String name = "List-Import-Product";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Log log = new Log(Log.INFO,currentUser.getId(),this.name,"",0,IpAddress.getClientIpAddr(request));
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, String> parameterMap = getParameterMap(request);
        String products;
        try {
            long start = Long.parseLong(parameterMap.get("start"));
            int length = Integer.parseInt(parameterMap.get("length"));
            int draw = Integer.parseInt(parameterMap.get("draw"));
            products = new DataTable<ImportProduct>().table("import_products",draw ,start, length).build(ImportProduct.class, new ImportProductMapper(),"id");
            log.setContent(products);
            LogService.addLog(log);
            out.println(products);
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
