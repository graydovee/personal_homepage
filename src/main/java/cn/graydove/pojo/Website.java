package cn.graydove.pojo;

public class Website {
    private int wid;
    private String name;
    private String url;
    private int uid;

    public int getWid() {
        return wid;
    }

    public void setWid(int wid) {
        this.wid = wid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    @Override
    public String toString() {
        return "Website{" +
                "wid=" + wid +
                ", name='" + name + '\'' +
                ", url='" + url + '\'' +
                ", uid=" + uid +
                '}';
    }
}
