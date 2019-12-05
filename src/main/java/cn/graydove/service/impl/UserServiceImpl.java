package cn.graydove.service.impl;

import cn.graydove.mapper.*;
import cn.graydove.pojo.Files;
import cn.graydove.pojo.User;
import cn.graydove.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private WebsiteMapper websiteMapper;

    @Autowired
    private UrlMapper urlMapper;

    @Autowired
    private ElementMapper elementMapper;

    @Override
    public User login(User user) {
        User u = userMapper.selByUsernameAndPwd(user);
        if(u!=null){
            u.setWebsites(websiteMapper.selByUid(u.getUid()));
            u.setUrl(urlMapper.selByRid(u.getRid()));
            u.setElements(elementMapper.selByRid(u.getRid()));

            String ip=user.getLastIp();

            if(ip!=null){
                u.setLastIp(ip);
                updLastIp(u);
            }
        }
        return u;
    }

    @Override
    public int insUser(User user) {
        int count = userMapper.insUser(user);
        return count;
    }

    @Override
    public int updLastIp(User user) {
        int count = 0;
        if(user.getRid()!=0){
            count = userMapper.updLastIp(user);
        }
        return count;
    }

    @Override
    public int selUsernameCount(String username) {
        int count = 0;
        count = userMapper.selUsernameCount(username);
        return count;
    }

    @Override
    public int updUser(User user) {
        return userMapper.updUser(user);
    }


}
