package model;

import service.PostService;

import java.util.ArrayList;

public class Post {
    public int post_id;
    public int post_category_id;
    public String date;
    public String title;
    public String content;

    public Post(int post_id, int post_category_id, String date, String title, String content) {
        this.post_id = post_id;
        this.post_category_id = post_category_id;
        this.date = date;
        this.title = title;
        this.content = content;
    }

    public int getPost_id() {
        return post_id;
    }

    public void setPost_id(int post_id) {
        this.post_id = post_id;
    }

    public int getPost_category_id() {
        return post_category_id;
    }

    public void setPost_category_id(int post_category_id) {
        this.post_category_id = post_category_id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "Post{" +
                "post_id=" + post_id +
                ", post_category_id=" + post_category_id +
                ", date='" + date + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                '}';
    }

    public String getImagePost(int index)
    {
        PostService manage = new PostService();
        ArrayList articleImages = manage.getImage(post_id);
        if (articleImages.size() > 0)
        {
            if (articleImages.size() > index)
            {
                Post_Image img = (Post_Image) articleImages.get(index);
                return img.url;
            }
        }
        return "";
    }
}
