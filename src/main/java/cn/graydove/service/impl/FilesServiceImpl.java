package cn.graydove.service.impl;

import cn.graydove.mapper.FilesMapper;
import cn.graydove.pojo.Files;
import cn.graydove.service.FilesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FilesServiceImpl implements FilesService {

    @Autowired
    private FilesMapper filesMapper;

    @Override
    public int insFiles(Files files) {
        int count;
        count = filesMapper.insFiles(files);
        return count;
    }

    @Override
    public List<Files> selByUid(int uid) {
        return filesMapper.selByUid(uid);
    }

    @Override
    public int updCount(String uuid) {
        int count;
        count = filesMapper.updCount(uuid);
        return count;
    }

    @Override
    public int delFile(String uuid) {
        int count;
        count = filesMapper.delFile(uuid);
        return count;
    }


}
