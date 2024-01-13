package Cart;

import beans.Cart;
import model.Product;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddWithNum", value = "/cart/addNum")
public class AddWithNum extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        int pid = Integer.parseInt(id);
        Product p = ProductService.getProductById(pid);
        String quantity = request.getParameter("quantity");
        int sl = Integer.parseInt(quantity);

       // p.setQuantity(1);
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart == null) {
            cart = new Cart();

        }
        cart.put(p, sl);
        request.getSession().setAttribute("cart",cart);
        response.sendRedirect(request.getContextPath() + "/lab/cart_detail");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
