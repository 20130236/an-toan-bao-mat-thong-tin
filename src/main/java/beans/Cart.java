package beans;

import model.Product;
import model.ProductInCart;
import model.UserModel;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;

public class Cart implements Serializable {
    HashMap<String, ProductInCart> data;
    UserModel customer;
    long total;
    int quantity;

    public Cart() {
        data = new HashMap<>();
        customer = new UserModel();
        total = 0;
        quantity = 0;
    }

    public Cart(UserModel customer, long total, int quantity) {
        data = new HashMap<>();
        this.customer = customer;
        this.total = total;
        this.quantity = quantity;
    }

//    public void put(Product p) {
//        if (data.containsKey(p.getKey())) {
//            ProductInCart p1 = data.get(p.getKey());
//         //   p1.setQuantity(p1.getQuantity() + 1);
//            data.put(p.getKey(), p1);
//        } else {
//            data.put(p.getKey(), p);
//        }
//        updateTotalAndQ();
//    }

    public void put(Product p) {
        if (data.containsKey(p.getKey())) {
            ProductInCart p1 = data.get(p.getKey());
            p1.setQuantity(p1.getQuantity() + 1);
            data.put(p.getKey(), p1);
        } else {
            ProductInCart pInCart = new ProductInCart(p, 1);
            data.put(p.getKey(), pInCart);
        }
        updateTotalAndQ();
    }
    public void put(Product p, int quantity) {
        if (data.containsKey(p.getKey())) {
            ProductInCart p1 = data.get(p.getKey());
            p1.setQuantity(p1.getQuantity() + quantity);
            data.put(p.getKey(), p1);
        } else {
            ProductInCart pInCart = new ProductInCart(p, quantity);
            data.put(p.getKey(), pInCart);
        }
        updateTotalAndQ();
    }

    public void put(String key, int quantity) {
        if (data.containsKey(key)) {
            ProductInCart pInCart = data.get(key);
            pInCart.setQuantity(quantity);
            data.put(key, pInCart);
        }
        updateTotalAndQ();
    }


    private void updateTotalAndQ() {
        total = 0;
        quantity = 0;
        for (ProductInCart productInCart : data.values()) {
            total += productInCart.getQuantity() * productInCart.getProduct().getPrice_sell();
            quantity += productInCart.getQuantity();
        }
    }

    public void update(Product product) {
        if (data.containsKey(product.getKey())) {
            ProductInCart productInCart = data.get(product.getKey());
            productInCart.setProduct(product);
            data.put(product.getKey(), productInCart);
        }
        updateTotalAndQ();
    }

    public void remove(String key) {
        data.remove(key);
        updateTotalAndQ();
    }

    public Collection<ProductInCart> getListProductInCart() {
        return data.values();
    }

    public int getQuantity() {
        return quantity;
    }

    public long getTotal() {
        return total;
    }

    public UserModel getCustomer() {
        return customer;
    }

    public void sub(Product p) {
        if (data.containsKey(p.getKey()) && data.get(p.getKey()).getQuantity() > 0) {
            ProductInCart pInCart = data.get(p.getKey());
            int num = pInCart.getQuantity();
            pInCart.setQuantity(num - 1);
            data.put(p.getKey(), pInCart);
        } else if (data.containsKey(p.getKey()) && data.get(p.getKey()).getQuantity() < 1) {
            data.remove(p.getKey());
        }
        updateTotalAndQ();
    }


}
