package com.wyh.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wyh.pojo.User;
import org.springframework.stereotype.Repository;

/**
 * @author djz
 * @date 2021/3/19 -8:05
 */
@Repository
public interface UserMapper extends BaseMapper<User> {
    /**
     * 通过用户名查询用户数量
     *
     * @param username
     * @return
     */

    int countUserByUsername(String username);

    /**
     * 通过用户名查询用户
     *
     * @param username
     * @return
     */
    User queryUserPwdByUsername(String username);
}
