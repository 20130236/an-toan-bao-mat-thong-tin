package model;

public class Slider {
    public   int slider_id;
    public String slider_url;
    public int slider_active;

    public Slider(int slider_id, String slider_url, int slider_active) {
        this.slider_id = slider_id;
        this.slider_url = slider_url;
        this.slider_active = slider_active;
    }

    public int getSlider_id() {
        return slider_id;
    }

    public void setSlider_id(int slider_id) {
        this.slider_id = slider_id;
    }

    public String getSlider_url() {
        return slider_url;
    }

    public void setSlider_url(String slider_url) {
        this.slider_url = slider_url;
    }

    public int getSlider_active() {
        return slider_active;
    }

    public void setSlider_active(int slider_active) {
        this.slider_active = slider_active;
    }

    @Override
    public String toString() {
        return "Slider{" +
                "slider_id=" + slider_id +
                ", slider_url='" + slider_url + '\'' +
                ", slider_active=" + slider_active +
                '}';
    }
}
