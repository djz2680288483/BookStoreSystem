package com.wyh.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.wyh.mapper.UserMapper;
import com.wyh.pojo.User;
import com.wyh.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author djz
 * @date 2021/3/19 -8:06
 */
@Service
public class UserServiceImpl implements IUserService {
    @Autowired
    UserMapper userMapper;

    @Override
    public int saveUser(User user) {
        return userMapper.insert(user);
    }

    @Override
    public int deleteUserById(int id) {
        return userMapper.deleteById(id);
    }

    @Override
    public int updateUser(User user) {
        return userMapper.updateById(user);
    }

    @Override
    public List<User> queryAllUser() {
        return userMapper.selectList(null);
    }

    @Override
    public int countUserByUsername(String username) {
        QueryWrapper<User> query = new QueryWrapper<>();
        if (!StringUtils.isEmpty(username)) {
            query.lambda().eq(User::getUsername, username);
        }
        return userMapper.selectCount(query);
    }

    @Override
    public User getUserPwdByUsername(String username) {

        QueryWrapper<User> query = new QueryWrapper<>();
        if (!StringUtils.isEmpty(username)) {
            query.lambda().eq(User::getUsername, username);
        }
        return userMapper.selectOne(query);
    }
}
