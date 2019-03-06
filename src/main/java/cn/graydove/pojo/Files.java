package cn.graydove.pojo;

import java.sql.Date;
import java.util.Objects;

public class Files {
    private int id;
    private int uid;
    private String uuid;
    private String name;
    private int count;
    private java.sql.Date create_time;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Files files = (Files) o;
        return id == files.id &&
                uid == files.uid &&
                count == files.count &&
                Objects.equals(uuid, files.uuid) &&
                Objects.equals(name, files.name) &&
                Objects.equals(create_time, files.create_time);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, uid, uuid, name, count, create_time);
    }

    @Override
    public String toString() {
        return "Files{" +
                "id=" + id +
                ", uid=" + uid +
                ", uuid='" + uuid + '\'' +
                ", name='" + name + '\'' +
                ", count=" + count +
                ", create_time=" + create_time +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public Date getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }
}
