package service.API_LOGISTIC;

public class District {
    int ProvinceID;
    int DistrictID;
    String DistrictName;

    public District(int provinceID, int districtID, String districtName) {
        ProvinceID = provinceID;
        DistrictID = districtID;
        DistrictName = districtName;
    }

    public int getProvinceID() {
        return ProvinceID;
    }

    public void setProvinceID(int provinceID) {
        ProvinceID = provinceID;
    }

    public int getDistrictID() {
        return DistrictID;
    }

    public void setDistrictID(int districtID) {
        DistrictID = districtID;
    }

    public String getDistrictName() {
        return DistrictName;
    }

    public void setDistrictName(String districtName) {
        DistrictName = districtName;
    }
}
