package service.API_LOGISTIC;

public class Ward {
    int WardCode;
    int DistrictID;
    String WardName;

    public Ward(int wardCode, int districtID, String wardName) {
        WardCode = wardCode;
        DistrictID = districtID;
        WardName = wardName;
    }

    public int getWardCode() {
        return WardCode;
    }

    public void setWardCode(int wardCode) {
        WardCode = wardCode;
    }

    public int getDistrictID() {
        return DistrictID;
    }

    public void setDistrictID(int districtID) {
        DistrictID = districtID;
    }

    public String getWardName() {
        return WardName;
    }

    public void setWardName(String wardName) {
        WardName = wardName;
    }
}
