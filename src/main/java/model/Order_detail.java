package model;

import service.ProductService;

import java.text.NumberFormat;
import java.util.Locale;

public class Order_detail {
    public int id;
    public Order order;
    public int id_product;
    public long price;
    public int amount;
    public int fee;
    public long total;

    public Order_detail(int id, Order order, int id_product, long price, int amount, int fee, long total) {
        this.id = id;
        this.order = order;
        this.id_product = id_product;
        this.price = price;
        this.amount = amount;
        this.fee = fee;
        this.total = total;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public int getId_product() {
        return id_product;
    }

    public void setId_product(int id_product) {
        this.id_product = id_product;
    }

    public long getPrice() {
        return price;
    }

    public void setPrice(long price) {
        this.price = price;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public int getFee() {
        return fee;
    }

    public void setFee(int fee) {
        this.fee = fee;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }
    public String getName(int id){
        ProductService service = new ProductService();
        Product p = service.getProductById(id);
        String rs = p.getName();
        return rs;
    }
    public String formatCurrency(double amount) {
        Locale localeVN = new Locale("vi", "VN");
        NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);
        return currencyVN.format(amount);
    }

    @Override
    public String toString() {
        return "Order_detail{" +
                "id=" + id +
                ", order=" + order +
                ", id_product=" + id_product +
                ", price=" + price +
                ", amount=" + amount +
                ", fee=" + fee +
                ", total=" + total +
                '}';
    }
}