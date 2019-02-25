package cn.graydove.pojo;

public class Element {
    private int eid;
    private String name;

    public int getEid() {
        return eid;
    }

    public void setEid(int eid) {
        this.eid = eid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Element{" +
                "eid=" + eid +
                ", name='" + name + '\'' +
                '}';
    }
}
