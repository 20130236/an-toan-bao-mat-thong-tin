package controller.admin;

import dao.ProductSearchDAO;
import dao.RoleDAO;
import model.*;
import service.LogService;
import service.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "EditProduct", value = "/admin-edit_product")
public class EditProduct extends HttpServlet {
    public String id;
    String name = "Edit-Product";
    private String editAccess = "sửa sản phẩm";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel user = (UserModel) request.getSession().getAttribute("auth");
        Role roleUser = RoleDAO.findById(user.getRole());
        boolean access = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(editAccess));
        if(!access){
            request.getRequestDispatcher("views/admin/no-permission.jsp").forward(request, response);
            return;
        }
        //lay ra id tu request
        id = request.getParameter("pid");
        int aid = Integer.parseInt(id);
        //lay ra san pham tuong ung
        ProductService service = new ProductService();
        Product p = service.getProductById(aid);
        List<ImgProductSearchModel> imgs = ProductSearchDAO.findImg(aid);
        request.setAttribute("imgs",imgs);
        request.setAttribute("product", p);
        List<Product_type> listType = service.getAllProduct_type();
        request.setAttribute("listType", listType);
        request.getRequestDispatcher("/views/admin/edit-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //cai nay la lay du lieu tu form gui len
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Log log = new Log(Log.INFO,currentUser.getId(),this.name,"",0,IpAddress.getClientIpAddr(request));
        int pid = Integer.parseInt(request.getParameter("id"));
        String pcode = request.getParameter("code");
        String pname = request.getParameter("ten");
        String pprice = request.getParameter("gianhap");
        String pprice_sell = request.getParameter("giaban");
        String ptype = request.getParameter("famille");
        String pbrand = request.getParameter("hangsx");
        String pcolor = request.getParameter("mausac");
        String psize = request.getParameter("kichthuoc");
        String pinsurance = request.getParameter("baohanh");
        String pattribute = request.getParameter("thuoctinh");
        String pstatus = request.getParameter("trangthai");
        String pinfo = request.getParameter("mota");
        //su ly de add product
        Product p = new Product(pid, pname, Integer.parseInt(pprice), Integer.parseInt(pprice_sell), pinfo, pcode, pbrand, pcolor, psize, pattribute, Integer.parseInt(pstatus), Integer.parseInt(ptype), pinsurance);
        log.setContent(p.toString());
        LogService.addLog(log);
        ProductService ser = new ProductService();
        ser.edit(p , Integer.parseInt(id));
        response.sendRedirect("/product_manager");
    }
}
