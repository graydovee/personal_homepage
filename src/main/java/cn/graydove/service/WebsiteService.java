package cn.graydove.service;

import cn.graydove.pojo.Website;

import java.util.List;

public interface WebsiteService {
    int insWebsite(Website website);

    int delWebsite(int wid);

    List<Website> selByUid(int uid);
}
