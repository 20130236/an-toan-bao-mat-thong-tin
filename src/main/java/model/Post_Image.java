package model;

public class Post_Image {
    public int img_article_id;
    public int article_id;
    public String url;

    public Post_Image(int img_article_id, int article_id, String url) {
        this.img_article_id = img_article_id;
        this.article_id = article_id;
        this.url = url;
    }

    public int getImg_article_id() {
        return img_article_id;
    }

    public void setImg_article_id(int img_article_id) {
        this.img_article_id = img_article_id;
    }

    public int getArticle_id() {
        return article_id;
    }

    public void setArticle_id(int article_id) {
        this.article_id = article_id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
