package com.zzu.service.impl;

import com.zzu.dao.CommentDao;
import com.zzu.dto.Result;
import com.zzu.model.Comment;
import com.zzu.service.CommentService;
import com.zzu.util.StringUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by zhanglei53 on 2016/7/29.
 */
@Service("commentService")
public class CommentServiceImpl implements CommentService {
    @Resource
    private CommentDao commentDao;

    public Result<Comment> getComments(int jId, int page, int pageSize) {
        Result<Comment> result = new Result<Comment>(page, pageSize);
        if (page < 1) {
            result.setSuccess(false);
            result.setError("页数错误");
            return result;
        }

        result.setList(commentDao.getComments(jId, (page - 1) * pageSize, pageSize));
        result.setTotalItem(commentDao.getCommentCount(jId));
        return result;
    }

    public Result addComment(Comment comment) {
        Result result = new Result();
        if (comment == null || StringUtil.isEmpty(comment.getContent())) {
            result.setSuccess(false);
            result.setError("内容不为空");
        } else if (commentDao.addComment(comment) < 1) {
            result.setSuccess(false);
            result.setError("发表失败");
        }
        return result;
    }
}
