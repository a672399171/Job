package com.zzu.dao;

import com.zzu.model.Comment;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface CommentDao {
    List<Comment> getComments(int id);

    int getCommentCount(int id);

    List<Comment> getComments(int id, int page);

    void addComment(Comment comment);


}
