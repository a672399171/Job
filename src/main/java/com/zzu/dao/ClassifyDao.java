package com.zzu.dao;

import com.zzu.model.Classify;
import com.zzu.model.Position;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface ClassifyDao {
    List<Classify> getAllClassifies();

    void addClassify(Classify classify);

    void updateClassify(Classify classify);

    void deleteClassify(int id);

    List<Position> searchPositionsWithArr(@Param("arr") int[] arr);

    List<Position> searchPositions(@Param("cId") int cId);

    void addPosition(Position position);

    void updatePosition(Position position);

    void deletePosition(int id);

    Position getPositionById(int id);
}
