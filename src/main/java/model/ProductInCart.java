package model;

public class ProductInCart {
    private Product product;
    private int quantity;

    public ProductInCart(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public String getKey(){
        String key = Integer.toString(product.product_id);
        return key;
        //
    }

}
