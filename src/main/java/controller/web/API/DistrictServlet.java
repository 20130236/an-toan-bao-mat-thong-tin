package controller.web.API;

import beans.Cart;
import com.google.gson.Gson;
import service.API_LOGISTIC.District;
import service.API_LOGISTIC.District_API;
import service.API_LOGISTIC.Login_API;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DistrictServlet", urlPatterns = "/lab/DistrictServlet")
public class DistrictServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public DistrictServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String provinceId = request.getParameter("province");
        int value = Integer.parseInt(provinceId);
        Login_API login_api = new Login_API();
        String API_KEY = login_api.login();
        List<District> districts = District_API.convert(API_KEY, value);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        String json = gson.toJson(districts);
        out.print(json);
        out.flush();
    }


}
