package model;

public class LogStatistics {

    String ipAddress;
    String username;
    int userId;
    int num0fId;

    public LogStatistics(String username,int userId, int num0fId) {
        this.username = username;
        this.userId = userId;
        this.num0fId = num0fId;
    }

    public LogStatistics(String ipAddress, int num0fId) {
        this.ipAddress = ipAddress;
        this.num0fId = num0fId;
    }

    public String getUsername() {
        return username;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getNum0fId() {
        return num0fId;
    }

    public void setNum0fId(int num0fId) {
        this.num0fId = num0fId;
    }
}
