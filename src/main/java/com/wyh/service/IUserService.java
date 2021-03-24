package com.wyh.service;

import com.wyh.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author djz
 * @date 2021/3/19 -8:06
 */
public interface IUserService {
    /**
     * 添加用户
     *
     * @param user
     * @return
     */
    int saveUser(User user);

    /**
     * 删除用户
     *
     * @param id
     * @return
     */
    int deleteUserById(@Param("id") int id);

    /**
     * 更新用户
     *
     * @param user
     * @return
     */
    int updateUser(User user);

    /**
     * 查询全部用户
     *
     * @return
     */
    List<User> queryAllUser();

    /**
     * 通过用户名查询用户
     *
     * @param username
     * @return
     */

    int countUserByUsername(String username);

    /**
     * 通过用户名查询用户密码
     *
     * @param username
     * @return
     */
    User getUserPwdByUsername(String username);
}
