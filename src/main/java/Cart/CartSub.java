package Cart;

import beans.Cart;
import model.Product;
import service.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "CartSub", value = "/cart/sub")
public class CartSub extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        int pid = Integer.parseInt(id);
        Product p = ProductService.getProductById(pid);
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        cart.sub(p);

        request.getSession().setAttribute("cart",cart);
        response.sendRedirect("/lab/cart_detail");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
