package com.zzu.service;

import com.zzu.dto.Result;
import com.zzu.model.Comment;

/**
 * Created by zhanglei53 on 2016/7/29.
 */
public interface CommentService {
    Result<Comment> getComments(int jId,int page,int pageSize);
}
