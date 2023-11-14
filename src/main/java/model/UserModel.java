package model;

import controller.admin.datatable.Item;

public class UserModel extends Item {
    int id;
    int [] ids;

    int [] idPms;
    String userName;
    String passWord;
    int role;
    String fullName;
    String phoneNum;
    String email;
    String address;

    String gender;
    int enable;

    int num_log_in;

    String access_token;

    String roleTitle;

    public UserModel(int id, String userName, String passWord, int role, String fullName, String phoneNum, String email, String address, int enable,String gender ) {
        this.id = id;
        this.userName = userName;
        this.passWord = passWord;
        this.role = role;
        this.fullName = fullName;
        this.phoneNum = phoneNum;
        this.email = email;
        this.address = address;
        this.gender = gender;
        this.enable = enable;
    }

    public UserModel(int id, String userName, String passWord, int role, int enable) {
        this.id = id;
        this.userName = userName;
        this.passWord = passWord;
        this.role = role;
        this.enable = enable;
    }

    public UserModel() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getEnable() {
        return enable;
    }

    public void setEnable(int enable) {
        this.enable = enable;
    }
    public boolean checkRole(int role) {
        return this.role >= role;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getNum_log_in() {
        return num_log_in;
    }

    public void setNum_log_in(int num_log_in) {
        this.num_log_in = num_log_in;
    }

    public  int [] getIds() {
        return ids;
    }

    public void setIds(int [] ids) {
        this.ids = ids;
    }

    public int[] getIdPms() {
        return idPms;
    }

    public void setIdPms(int[] idPms) {
        this.idPms = idPms;
    }

    public String getAccess_token() {
        return access_token;
    }

    public void setAccess_token(String access_token) {
        this.access_token = access_token;
    }

    public String getRoleTitle() {
        return roleTitle;
    }

    public void setRoleTitle(String roleTitle) {
        this.roleTitle = roleTitle;
    }

    @Override
    public String toString() {
        return "UserModel{" +
                "id=" + id +
                ", userName='" + userName + '\'' +
                ", passWord='" + passWord + '\'' +
                ", role=" + role +
                ", fullName='" + fullName + '\'' +
                ", phoneNum='" + phoneNum + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                ", gender='" + gender + '\'' +
                ", enable=" + enable +
                ", num_log_in=" + num_log_in +
                '}' + '\n';
    }

    @Override
    public String[] toArray() {
        return new String[]{
                String.valueOf(id),
                userName,
                passWord,
                String.valueOf(role),
                fullName,
                phoneNum,
                email,
                address,
                gender,
                String.valueOf(enable),
                String.valueOf(num_log_in),
                roleTitle,
        };
    }
}
