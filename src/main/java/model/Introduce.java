package model;

public class Introduce {
    public  String name;
    public String introduce;
    public String address;
    public String showroom;
    public String timework;
    public String email;
    public String phone;
    public String caption;

    public Introduce(String name,String introduce, String address, String showroom, String timework, String email, String phone, String caption) {
        this.name = name;
        this.introduce = introduce;
        this.address = address;
        this.showroom = showroom;
        this.timework = timework;
        this.email = email;
        this.phone = phone;
        this.caption = caption;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIntroduce() {
        return introduce;
    }

    public void setIntroduce(String introduce) {
        this.introduce = introduce;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getShowroom() {
        return showroom;
    }

    public void setShowroom(String showroom) {
        this.showroom = showroom;
    }

    public String getTimework() {
        return timework;
    }

    public void setTimework(String timework) {
        this.timework = timework;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCaption() {
        return caption;
    }

    public void setCaption(String caption) {
        this.caption = caption;
    }

    @Override
    public String toString() {
        return "Introduce{" +
                "introduce='" + introduce + '\'' +
                ", address='" + address + '\'' +
                ", showroom='" + showroom + '\'' +
                ", timework='" + timework + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", caption='" + caption + '\'' +
                '}';
    }
}
