package com.wyh.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.wyh.mapper.OrdersMapper;
import com.wyh.pojo.Orders;
import com.wyh.pojo.User;
import com.wyh.service.IOrdersService;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author djz
 * @date 2021/3/19 -7:47
 */
@Service
public class OrdersServiceImpl implements IOrdersService {
    @Autowired
    OrdersMapper ordersMapper;

    @Override
    public int saveOrder(Orders order) {
        return ordersMapper.insert(order);
    }

    @Override
    public int deleteOrderById(int id) {
        return ordersMapper.deleteById(id);
    }

    @Override
    public int updateOrder(Orders order) {
        return ordersMapper.updateById(order);
    }

    @Override
    public List<Orders> queryAllOrder() {
        return ordersMapper.selectList(null);
    }

    @Override
    public List<Orders> queryOrderByUn(String username) {

        QueryWrapper<Orders> query = new QueryWrapper<>();
        if (!StringUtils.isEmpty(username)) {
            query.lambda().eq(Orders::getUsername, username);
        }
        return ordersMapper.selectList(query);
    }

    @Override
    public int updateIsPayById(int id) {
        Orders orders = new Orders();
        orders.setIsPay(1);
        orders.setId(id);
        return ordersMapper.updateById(orders);
    }

    @Override
    public int updateIsDeliveryById(int id) {
        Orders orders = new Orders();
        orders.setIsDelivery(1);
        orders.setId(id);
        return ordersMapper.updateById(orders);
    }

    @Override
    public int updateCompletionById(int id) {
        Orders orders = new Orders();
        orders.setCompletion(1);
        orders.setId(id);
        return ordersMapper.updateById(orders);
    }

    @Override
    public int queryOrderCountById(int id) {
        QueryWrapper<Orders> query = new QueryWrapper<>();
        if (id > 0) {
            query.lambda().eq(Orders::getId, id);
        }
        return ordersMapper.selectCount(query);
    }
}
