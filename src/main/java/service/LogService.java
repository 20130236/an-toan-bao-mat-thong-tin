package service;

import dao.LogDAO;
import model.Log;

public class LogService {

    public static void addLog(Log log){
        LogDAO.addLog(log);
    }
}
