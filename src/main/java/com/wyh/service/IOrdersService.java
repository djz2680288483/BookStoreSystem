package com.wyh.service;

import com.wyh.pojo.Orders;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author djz
 * @date 2021/3/19 -7:47
 */
public interface IOrdersService {
    /**
     * 添加订单
     *
     * @param order
     * @return
     */
    int saveOrder(Orders order);

    /**
     * 删除订单
     *
     * @param id
     * @return
     */
    int deleteOrderById(@Param("id") int id);

    /**
     * 更新订单
     *
     * @param order
     * @return
     */
    int updateOrder(Orders order);

    /**
     * 查询所有订单
     *
     * @return
     */

    List<Orders> queryAllOrder();

    /**
     * 通过用户名查询订单
     *
     * @param username
     * @return
     */
    List<Orders> queryOrderByUn(@Param("username") String username);

    /**
     * 改变支付状态
     *
     * @param id
     * @return
     */
    int updateIsPayById(@Param("id") int id);

    /**
     * 改变收货状态
     *
     * @param id
     * @return
     */

    int updateIsDeliveryById(@Param("id") int id);

    /**
     * 改变完成状态
     *
     * @param id
     * @return
     */

    int updateCompletionById(@Param("id") int id);

    /**
     * 通过bookId查询订单数量
     *
     * @param id
     * @return
     */
    int queryOrderCountById(@Param("id") int id);
}
