package model;

public class ImgProductSearchModel {
    String url;

    public ImgProductSearchModel(String url) {
        this.url = url;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "ImgProductSearchModel{" +
                "url='" + url + '\'' +
                '}';
    }
}
