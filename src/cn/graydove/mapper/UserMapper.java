package cn.graydove.mapper;

import cn.graydove.pojo.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface UserMapper {

    @Select("select * from user where username=#{username} and password=#{password}")
    User selByUsernameAndPwd(User user);

    @Insert("insert into user values(default,#{username},#{nickname},#{password},#{rid},null,null,now(),null)")
    int insUser(User user);

    @Update("update user set last_ip=#{lastIp} where uid=#{uid}")
    int updLastIp(User user);

    @Select("select count(*) from user where username=#{0}")
    int selUsernameCount(String username);

    @Update("update user set password=#{password},nickname=#{nickname},sex=#{sex},birth=#{birth} where uid=#{uid}")
    int updUser(User user);
}
