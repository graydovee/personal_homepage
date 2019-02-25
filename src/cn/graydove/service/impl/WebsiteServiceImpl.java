package cn.graydove.service.impl;

import cn.graydove.mapper.WebsiteMapper;
import cn.graydove.pojo.Website;
import cn.graydove.service.WebsiteService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class WebsiteServiceImpl implements WebsiteService {

    @Resource
    private WebsiteMapper websiteMapper;

    @Override
    public int insWebsite(Website website) {
        int count = 0;
        count = websiteMapper.insWebsite(website);
        return count;
    }

    @Override
    public int delWebsite(int wid) {
        int count;
        count = websiteMapper.delWebsite(wid);
        return count;
    }

    @Override
    public List<Website> selByUid(int uid) {
        List<Website> list;
        list = websiteMapper.selByUid(uid);
        return list;
    }
}
