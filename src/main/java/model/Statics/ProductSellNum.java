package model.Statics;

import model.Image;
import model.Product;
import service.ProductService;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Locale;

public class ProductSellNum {
    public int id;
    public String name;
    public String price;
    public String image;
    public int amountSell;



    public ProductSellNum(int id, int amountSell) {
        this.id = id;
        this.amountSell = amountSell;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {

        return getNamee(id);
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrice() {
        return formatCurrency(getPriceSell(id));
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getImage() {
        return getImagee(0);
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getAmountSell() {
        return amountSell;
    }

    public void setAmountSell(int amountSell) {
        this.amountSell = amountSell;
    }

    public String getNamee(int id){
        ProductService service = new ProductService();
        Product p = service.getProductById(id);
        String rs = p.getName();
        return rs;
    }
    public int getPriceSell(int id){
        ProductService service = new ProductService();
        Product p = service.getProductById(id);
        int rs = p.getPrice_sell();
        return rs;
    }
    public String getImagee(int index){
        ProductService manage = new ProductService();
        ArrayList image = manage.getImage(id);
        if (image.size()>0){
            if (image.size()>index){
                Image img = (Image) image.get(index);
                return img.getImg_url();
            }
        }
        return "";
    }
    public String formatCurrency(double amount) {
        Locale localeVN = new Locale("vi", "VN");
        NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);
        return currencyVN.format(amount);
    }

}
