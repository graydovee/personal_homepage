package cn.graydove.service;

import cn.graydove.pojo.Files;

import java.util.List;

public interface FilesService {
    int insFiles(Files files);

    List<Files> selByUid(int uid);

    int updCount(String uuid);

    int delFile(String uuid);
}
