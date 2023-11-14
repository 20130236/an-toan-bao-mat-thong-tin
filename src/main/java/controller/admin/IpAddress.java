package controller.admin;

import javax.servlet.http.HttpServletRequest;

public class IpAddress {
    public static String getClientIpAddr(HttpServletRequest request) {
        // Get the actual client IP address
        String ipAddress = request.getHeader("X-Forwarded-For");
        if (ipAddress == null) {
            // X-Forwarded-For header is not present, use the remote address
            ipAddress = request.getRemoteAddr();
        } else {
            // X-Forwarded-For header is present, extract the client IP address
            int index = ipAddress.indexOf(",");
            if (index != -1) {
                ipAddress = ipAddress.substring(0, index).trim();
            }
        }
        return ipAddress;
    }
}
