package filter;

import controller.admin.Access;
import model.UserModel;
import service.UserService;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "PermissionFilter")
public class Permission implements Filter{
    public void init(FilterConfig config) throws ServletException {

    }

    public void destroy() {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest rq = (HttpServletRequest)request;
        HttpServletResponse rp = (HttpServletResponse)response;
        UserModel oldUser = (UserModel) rq.getSession().getAttribute("auth");
        String url = rq.getRequestURI();
        if(oldUser != null && url.startsWith("/admin")){
            if (UserService.hasChanged(oldUser)){
                rq.getSession().removeAttribute("auth");
                rp.sendRedirect("/admin-login?message=role_reset&alert=warning");
                return;
            }
        }
        chain.doFilter(rq, rp);
    }
}
