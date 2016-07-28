package com.zzu.service.impl;

import com.zzu.dao.ClassifyDao;
import com.zzu.model.Classify;
import com.zzu.model.Position;
import com.zzu.service.ClassifyService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
@Service("classifyService")
public class ClassifyServiceImpl implements ClassifyService {
    @Resource
    private ClassifyDao classifyDao;

    public List<Classify> getAllClassifies() {
        return classifyDao.getAllClassifies();
    }

    public List<Position> searchPositions(int cId) {
        return classifyDao.searchPositions(cId);
    }
}
