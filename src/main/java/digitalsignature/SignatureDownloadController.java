package digitalsignature;

import dao.UserDAO;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/signature")
public class SignatureDownloadController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("uid") == null){
            request.getRequestDispatcher("/views/web/error404.jsp").forward(request, response);
            return;
        }
        int uid = Integer.parseInt(request.getParameter("uid"));
        String path = UserService.getSignature(uid);
        request.setAttribute("uid",uid);
        request.setAttribute("path",path);
        request.getRequestDispatcher("/views/web/download-signature.jsp").forward(request, response);
    }
}
