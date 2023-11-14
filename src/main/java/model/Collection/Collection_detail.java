package model.Collection;

public class Collection_detail {
    int id_detail;
    int id_collection;
    int id_product;

    public Collection_detail(int id_detail, int id_collection, int id_product) {
        this.id_detail = id_detail;
        this.id_collection = id_collection;
        this.id_product = id_product;
    }

    public int getId_detail() {
        return id_detail;
    }

    public void setId_detail(int id_detail) {
        this.id_detail = id_detail;
    }

    public int getId_collection() {
        return id_collection;
    }

    public void setId_collection(int id_collection) {
        this.id_collection = id_collection;
    }

    public int getId_product() {
        return id_product;
    }

    public void setId_product(int id_product) {
        this.id_product = id_product;
    }

    @Override
    public String toString() {
        return "Collection_detail{" +
                "id_detail=" + id_detail +
                ", id_collection=" + id_collection +
                ", id_product=" + id_product +
                '}';
    }
}
