package model;

public class Favorite {
    private int favorite_id;
    private String user_name;
    private int product_id;

    public Favorite(int favorite_id, String user_name, int product_id) {
        this.favorite_id = favorite_id;
        this.user_name = user_name;
        this.product_id = product_id;
    }

    public int getFavorite_id() {
        return favorite_id;
    }

    public void setFavorite_id(int favorite_id) {
        this.favorite_id = favorite_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    @Override
    public String toString() {
        return "Favorite{" +
                "favorite_id=" + favorite_id +
                ", user_name='" + user_name + '\'' +
                ", product_id=" + product_id +
                '}';
    }
}
