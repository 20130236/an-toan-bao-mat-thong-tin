package model;

import service.ProductService;

public class RemainingProducts {

    int product_id;
    int total_import_quantity;
    int total_sold_quantity;
    int total_remaining_quantity;

    public RemainingProducts(int product_id, int total_import_quantity, int total_sold_quantity, int total_remaining_quantity) {
        this.product_id = product_id;
        this.total_import_quantity = total_import_quantity;
        this.total_sold_quantity = total_sold_quantity;
        this.total_remaining_quantity = total_remaining_quantity;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getTotal_import_quantity() {
        return total_import_quantity;
    }

    public void setTotal_import_quantity(int total_import_quantity) {
        this.total_import_quantity = total_import_quantity;
    }

    public int getTotal_sold_quantity() {
        return total_sold_quantity;
    }

    public void setTotal_sold_quantity(int total_sold_quantity) {
        this.total_sold_quantity = total_sold_quantity;
    }

    public int getTotal_remaining_quantity() {
        return total_remaining_quantity;
    }

    public void setTotal_remaining_quantity(int total_remaining_quantity) {
        this.total_remaining_quantity = total_remaining_quantity;
    }

    @Override
    public String toString() {
        return "RemainingProducts{" +
                "product_id=" + product_id +
                ", total_import_quantity=" + total_import_quantity +
                ", total_sold_quantity=" + total_sold_quantity +
                ", total_remaining_quantity=" + total_remaining_quantity +
                '}';
    }
    public String getName(){
        ProductService service = new ProductService();
        Product p = ProductService.getProductById(product_id);
        String rs = p.getName();
        return rs;
    }
}
