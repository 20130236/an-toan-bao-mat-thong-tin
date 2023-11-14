package model;

public class Image {
    private  int img_id;
    private int product_id;
    private String img_url;

    public Image(int img_id, int product_id, String img_url) {
        this.img_id = img_id;
        this.product_id = product_id;
        this.img_url = img_url;
    }

    public int getImg_id() {
        return img_id;
    }

    public void setImg_id(int img_id) {
        this.img_id = img_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getImg_url() {
        return img_url;
    }

    public void setImg_url(String img_url) {
        this.img_url = img_url;
    }

    @Override
    public String toString() {
        return "Image{" +
                "img_id=" + img_id +
                ", product_id=" + product_id +
                ", img_url='" + img_url + '\'' +
                '}';
    }


}
