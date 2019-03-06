package cn.graydove.service;

import cn.graydove.pojo.User;

public interface UserService {
    /**
     * 用户登录
     * @param user 包含账号密码
     * @return 通过数据库查询到的用户完整信息
     */
    User login(User user);

    /**
     * 用户注册
     * @param user 注册用户信息
     * @return 新增数据数量
     */
    int insUser(User user);

    /**
     * 更新最后登录的ip
     * @param user 包含用户的ip
     * @return
     */
    int updLastIp(User user);

    /**
     * 查询用户名是否重复
     * @return 相同用户名数量
     */
    int selUsernameCount(String username);

    /**
     * 更新用户信息
     * @return
     */
    int updUser(User user);
}
