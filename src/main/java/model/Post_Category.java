package model;

public class Post_Category {
    public int post_category_id;
    public String post_category_name;

    public Post_Category(int post_category_id, String post_category_name) {
        this.post_category_id = post_category_id;
        this.post_category_name = post_category_name;
    }

    public int getPost_category_id() {
        return post_category_id;
    }

    public void setPost_category_id(int post_category_id) {
        this.post_category_id = post_category_id;
    }

    public String getPost_category_name() {
        return post_category_name;
    }

    public void setPost_category_name(String post_category_name) {
        this.post_category_name = post_category_name;
    }

    @Override
    public String toString() {
        return "Post_Category{" +
                "post_category_id=" + post_category_id +
                ", post_category_name='" + post_category_name + '\'' +
                '}';
    }
}