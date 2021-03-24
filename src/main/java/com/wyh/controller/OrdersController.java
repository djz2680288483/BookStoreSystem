package com.wyh.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wyh.pojo.Orders;
import com.wyh.service.IBooksService;
import com.wyh.service.IOrdersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @author djz
 * @date 2021/3/19 -9:02
 */
@Controller
public class OrdersController {

    @Autowired
    IOrdersService ordersService;

    @Autowired
    IBooksService booksService;

    @RequestMapping("/order/addOrder")
    public String addOrder(String username,String address,String phone,String bookName,int id){
        Orders order = new Orders();
        order.setOrderId(UUID.randomUUID().toString().replace("-","").toUpperCase().substring(0,20));
        order.setUsername(username);
        Date date = new Date();
        order.setOrderDate(date);
        order.setBookName(bookName);
        order.setReceverAddr(address);
        order.setReceverTel(phone);
        order.setId(id);
        booksService.saveSaleById(id);
        ordersService.saveOrder(order);
        return "redirect:../";
    }

    //查询用户订单，并跳转用户订单界面
    @RequestMapping("/order/toUserOrder")
    public String list(@RequestParam(defaultValue = "1")int currentPage, Model model, HttpSession session){
        String username = (String)session.getAttribute("userName");
        PageHelper.startPage(currentPage,6);
        List<Orders> orderList = ordersService.queryOrderByUn(username);
        PageInfo pageInfo = new PageInfo(orderList);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("orderList",orderList);
        return "userOrder";
    }

    @RequestMapping("/order/Pay")
    public String pay(int id){
        ordersService.updateIsPayById(id);
        return "redirect:/order/toUserOrder";
    }

    @RequestMapping("/order/Delivery")
    public String delivery(int id){
        ordersService.updateIsDeliveryById(id);
        return "redirect:/order/allOrder";
    }

    @RequestMapping("/order/Completion")
    public String completion(int id){
        ordersService.updateCompletionById(id);
        return "redirect:/order/toUserOrder";
    }


    @RequestMapping("/order/allOrder")
    public String allOrder(@RequestParam(defaultValue = "1")int currentPage,Model model){
        PageHelper.startPage(currentPage,6);
        List<Orders> orderList = ordersService.queryAllOrder();
        PageInfo pageInfo = new PageInfo(orderList);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("orderList",orderList);
        return "orderManagement";
    }

    @RequestMapping("/order/deleteOrder")
    public String deleteOrder(int id){
        ordersService.deleteOrderById(id);
        return "redirect:/order/allOrder";
    }



}
