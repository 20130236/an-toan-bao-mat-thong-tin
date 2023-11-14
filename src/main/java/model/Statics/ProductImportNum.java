package model.Statics;

import model.Image;
import model.Product;
import service.ProductService;

import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

public class ProductImportNum {
    public int id;
    public String name;
    public String price;
    public String image;
    public int amountImport;
    Date date;



    public ProductImportNum(int id, int amountImport, Date date) {
        this.id = id;
        this.amountImport = amountImport;
        this.date = date;
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

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getAmountImport() {
        return amountImport;
    }

    public void setAmountImport(int amountImport) {
        this.amountImport = amountImport;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
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
    public static String convertDate(String dateString) {
        LocalDate date = LocalDate.parse(dateString);
        return date.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

}
