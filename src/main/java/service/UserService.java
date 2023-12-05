package service;

import dao.RoleDAO;
import dao.UserDAO;
import digitalsignature.API.KeyModel;
import digitalsignature.SignatureImageCreator;
import model.UserModel;

import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.X509EncodedKeySpec;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Base64;
import java.util.Calendar;
import java.util.List;

public class UserService {

    public static UserModel checkLogin(String username, String password){
        return UserDAO.findLogin(username,hashPassword(password));
    }

    public static void lockUser(String username){
        if(UserDAO.checkNumLogin(username)) UserDAO.updateStatus(2,username);
    }

    public static void updateNumLogin(String username){
        UserDAO.updateNumLogin(username);
    }

    public static UserModel findById(int id){
        return UserDAO.findById(id);
    }
    public static UserModel findByUserAndEmail(String username, String email){
        return UserDAO.findByUserAndEmail(username,email);
    }

    public static void changePassword(int id ,String newPassword){
        UserDAO.changePassword(id,hashPassword(newPassword));
    }

    public static void updateUserWeb(int id, String full_name, String phone_num, String email, String address, String gender, String signature_text){
        UserDAO.updateUserWeb(id,full_name,phone_num,email,address,gender,signature_text);
    }

    public static void register(String username, String password,String email, String full_name, String gender) {
        UserDAO.addUser(username,hashPassword(password),full_name,email,gender);
    }

    public static boolean checkUserName(String username){
        return UserDAO.checkUserName(username);
    }

    public static boolean checkEmail(String email){
        return UserDAO.checkUserName(email);
    }

    public static String randomPassword(){
        int min = 100;
        int max = 1000;
        int password = (int)(Math.random() * (max - min + 1) + min);
        return String.valueOf(password);
    }

    public static List<UserModel> findAll() {
        return UserDAO.findAll();
    }

    public static UserModel findByUserName(String username) {
        return UserDAO.findByUser(username);
    }

    public static void save(UserModel user) {
        user.setPassWord(hashPassword(user.getPassWord()));
        UserDAO.save(user);
    }

    public static void updateAdmin(UserModel user,String enable) {
        if(enable.equals("on")){
            user.setEnable(1);
        } else {
            user.setEnable(2);
        }
        UserDAO.updateUserAdmin(user);
    }

    public static void delete(int id) {
        UserDAO.detele(id);
    }

    public static String hashPassword(String password) {
        try {
            MessageDigest sha256 = null;
            sha256 = MessageDigest.getInstance("SHA-256");
            byte[] hash = sha256.digest(password.getBytes());
            BigInteger number = new BigInteger(1, hash);
            return number.toString(16);
        } catch (NoSuchAlgorithmException e) {
            return null;
        }
    }

    public static String createToken() {
        SecureRandom secureRandom = new SecureRandom();
        Base64.Encoder base64Encoder = Base64.getUrlEncoder();
        byte[] randomBytes = new byte[24];
        secureRandom.nextBytes(randomBytes);
        return base64Encoder.encodeToString(randomBytes);
    }

    public static void addToken(int id, String token){
        Long currentTime = getTimeNowInMillis();
        Timestamp token_expiry = getTokenExpiry(currentTime);
        Timestamp create_date = new Timestamp(currentTime);
        UserDAO.addToken(id,token, create_date,token_expiry);
    }

    private static long getTimeNowInMillis(){
        return Calendar.getInstance().getTimeInMillis();
    }

    private static Timestamp getTokenExpiry(Long timeNow){
        return new Timestamp(timeNow + 600000);
    }

    public static boolean checkTokenExpiry(int id, String token){
        return UserDAO.checkTokenExpiry(id,token);
    }

    public static UserModel findByToken(String token) {
        return UserDAO.findByToken(token);
    }

    public static boolean checkToken(String token){
        return UserDAO.checkToken(token);
    }

    public static void deleteToken(int id, String token) {
        UserDAO.deleteToken(id,token);
    }

    // 86400000 milliseconds  = 24 hours
    private static Timestamp getVerifyExpiry(Long timeNow){
        return new Timestamp(timeNow + 86400000);
    }

    public static UserModel findByRdData(String rdData) {
        return UserDAO.findByRdData(rdData);
    }

    public static void deleteVerify(String rdData) {
        UserDAO.deleteVerify(rdData);
    }

    public static void addVerify(int user_id,String rdData) {
        Long currentTime = getTimeNowInMillis();
        Timestamp verify_expiry = getVerifyExpiry(currentTime);
        Timestamp create_date = new Timestamp(currentTime);
        UserDAO.addVerify(user_id,rdData,create_date,verify_expiry);
    }

    public static UserModel checkVerify(String rdData) {
        return UserDAO.checkVerify(rdData);
    }

    public static void setVerified(String rdData) {
        UserDAO.setVerified(rdData);    }

    public static boolean hasChanged(UserModel oldUser){
        UserModel newUser = UserDAO.findById(oldUser.getId());
        //assert newUser != null;
        int [] oldPm = oldUser.getIdPms();
        int [] newPm = RoleDAO.findById(newUser.getRole()).getIdPermissions();
        return !(Arrays.equals(oldPm,newPm));
    }

    public static List<UserModel> getByIds(UserModel user){
        return UserDAO.getByIds(user);
    }


    public static  String getPublicKey(int id) {
        return UserDAO.getPublicKey(id);
    }


    public static String createSignature(String path, String username){
        UserDAO.saveSignature(path,username);
        return path;
    }

    public static void main(String[] args) {
        UserModel user = UserService.checkLogin("Dung4","Dung112!");
        int [] oldPm = user.getIdPms();
        int [] newPm = {1,3,15};
        System.out.println(!(Arrays.equals(oldPm,newPm)));
    }

    public static String getSignature(int uid) {
        return UserDAO.getSignature(uid);
    }

    public static void createKey(KeyModel keyModel, int id) {

        UserDAO.createKey(keyModel,id);
    }
    public static int getIdByUserName(String username){
        return UserDAO.findIDByUser(username);
    }

}

