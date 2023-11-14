package controller.web.API;

import com.google.gson.Gson;
import service.API_LOGISTIC.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "WardServlet", urlPatterns = "/WardServlet")
public class WardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public WardServlet() {
        super();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String districtId = request.getParameter("districtId");
        int value = Integer.parseInt(districtId);
        Login_API login_api = new Login_API();
        String API_KEY = login_api.login();
        List<Ward> wards = Ward_API.convert(API_KEY, value);
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        String json = gson.toJson(wards);
        out.print(json);
        out.flush();
    }
}
