package cn.graydove.pojo;

import java.util.Objects;

public class Url {
    private int urlId;
    private String url;

    public int getUrlId() {
        return urlId;
    }

    public void setUrlId(int urlId) {
        this.urlId = urlId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "Url{" +
                "urlId=" + urlId +
                ", url='" + url + '\'' +
                '}';
    }

}
