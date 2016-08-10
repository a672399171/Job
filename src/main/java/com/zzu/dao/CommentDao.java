package com.zzu.dao;

import com.zzu.model.Comment;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface CommentDao {
    List<Comment> getComments(int id);

    int getCommentCount(int id);

    List<Comment> getComments(@Param("id") int id,
                                @Param("start") int start,
                                @Param("count") int count);

    int addComment(Comment comment);
}
