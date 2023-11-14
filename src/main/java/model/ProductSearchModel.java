package model;

import java.util.List;

public class ProductSearchModel {
    private int id;
    private String name;
    private int price;
    private int price_sell;
    private String info;
    private int status;

    List<ImgProductSearchModel> listImg;

    public ProductSearchModel(int id, String name, int price, int price_sell, String info, int status, List<ImgProductSearchModel> listImg) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.price_sell = price_sell;
        this.info = info;
        this.status = status;
        this.listImg = listImg;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getPrice_sell() {
        return price_sell;
    }

    public void setPrice_sell(int price_sell) {
        this.price_sell = price_sell;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public List<ImgProductSearchModel> getListImg() {
        return listImg;
    }

    public void setListImg(List<ImgProductSearchModel> listImg) {
        this.listImg = listImg;
    }

    @Override
    public String toString() {
        return "ProductSearchModel{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", price_sell=" + price_sell +
                ", info='" + info + '\'' +
                ", status=" + status +
                ", listImg=" + listImg +
                '}';
    }
}
