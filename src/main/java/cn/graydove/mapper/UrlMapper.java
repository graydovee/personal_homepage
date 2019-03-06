package cn.graydove.mapper;

import cn.graydove.pojo.Url;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface UrlMapper {
    @Select("select * from url where url_id in(select url_id from role_url where rid=#{0})")
    List<Url> selByRid(int rid);
}
