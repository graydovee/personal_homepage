package cn.graydove.mapper;

import cn.graydove.pojo.Website;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface WebsiteMapper {

    @Select("select * from website where wid=#{0}")
    Website selByWid(int wid);

    @Select("select * from website where uid=#{0}")
    List<Website> selByUid(int uid);

    @Insert("insert into website values(default,#{name},#{url},#{uid})")
    int insWebsite(Website website);

    @Delete("delete from website where wid=#{0}")
    int delWebsite(int wid);
}
