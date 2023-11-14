package model;

import controller.admin.datatable.Item;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

public class Log extends Item {
    int [] ids;
    String username;
    int id;
    int level;
    int userId;
    String src;
    String content;
    Date creatAt;
    int status;

    String ipAddress;

    static Map<Integer, String> levelMapping = new HashMap<>();

    static {
        levelMapping.put(0, "INFO"); // view
        levelMapping.put(1, "ALERT"); // update create
        levelMapping.put(2, "WARNING"); // delete
        levelMapping.put(3, "DANGER"); // login failed
    }

    public static int INFO = 0;
    public static int ALERT = 1;
    public static int WARNING = 2;
    public static int DANGER = 3;

    public Log() {

    }

    public Log( int level,int userId, String src,  String content, Date creatAt, int status , String ipAddress) {
        this.level = level;
        this.src = src;
        this.userId = userId;
        this.content = content;
        this.creatAt = creatAt;
        this.status = status;
        this.ipAddress = ipAddress;
    }
    public Log( int level,int userId, String src,  String content,int status,String ipAddress) {
        this.level = level;
        this.src = src;
        this.userId = userId;
        this.content = content;
        this.status = status;
        this.ipAddress = ipAddress;
    }

    public int[] getIds() {
        return ids;
    }

    public void setIds(int[] ids) {
        this.ids = ids;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getLevelWithName() {
        return levelMapping.get(levelMapping.containsKey(this.level) ? this.level : 0);
    }

    public String getSrc() {
        return src;
    }

    public void setSrc(String src) {
        this.src = src;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreatAt() {
        return creatAt;
    }

    public void setCreatAt(Date creatAt) {
        this.creatAt = creatAt;
    }

    public int getStatus() {
        return status;
    }


    public void setStatus(int status) {
        this.status = status;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String[] toArray() {
        return new String[]{
                String.valueOf(userId),
                String.valueOf(level),
                src,
                String.valueOf(creatAt),
                ipAddress
        };
    }
}
