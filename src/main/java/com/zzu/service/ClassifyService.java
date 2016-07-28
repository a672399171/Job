package com.zzu.service;

import com.zzu.model.Classify;
import com.zzu.model.Position;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface ClassifyService {
    List<Classify> getAllClassifies();
    List<Position> searchPositions(int cId);
}
