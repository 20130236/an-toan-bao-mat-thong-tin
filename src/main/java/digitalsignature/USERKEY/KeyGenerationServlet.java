package digitalsignature.USERKEY;

import dao.UserDAO;
import model.UserModel;

import java.io.*;
import java.security.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/keyGenerationServlet")
public class KeyGenerationServlet extends HttpServlet {
    DSA dsa = new DSA();


    //Tạo key và lưu public key vào database,tải private key về máy người dùng
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/lab/login");
            return;
        }
        try {
            // Tạo cặp khóa
            KeyPair keyPair = dsa.generateKeyPair();

            // Gửi private key về cho người dùng
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=private_key.bin");
            try (OutputStream outputStream = response.getOutputStream()) {
                outputStream.write(keyPair.getPrivate().getEncoded());
            }
            // Lưu public key vào database
       //     userDAO.createKey();
            dsa.savePublicKeyToDatabase(keyPair.getPublic(), user.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}