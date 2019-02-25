package cn.graydove.mapper;

import cn.graydove.pojo.Files;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface FilesMapper {

    @Select("select * from files where uid=#{0}")
    List<Files> selByUid(int uid);

    @Insert("insert into files values(default,#{uid},#{uuid},#{name},#{count},now())")
    int insFiles(Files files);

    @Update("update files set count=count+1 where uuid=#{0}")
    int updCount(String uuid);

    @Delete("delete from files where uuid=#{0}")
    int delFile(String uuid);
}
