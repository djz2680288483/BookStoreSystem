package com.wyh.utils;

import com.github.pagehelper.PageHelper;

import com.wyh.pojo.Books;
import com.wyh.pojo.Orders;
import com.wyh.pojo.User;
import com.wyh.service.IBooksService;
import com.wyh.service.IOrdersService;
import com.wyh.service.IUserService;
import com.wyh.service.impl.BooksServiceImpl;
import com.wyh.service.impl.OrdersServiceImpl;
import com.wyh.service.impl.UserServiceImpl;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.TreeSet;

public class Items_based {
    public static void main(String[] args) {
        //测试小Demo
        String username = "user01";
        List<Books> v = recommend(username);

        System.out.println("正在生成针对用户" + username + "的推荐...");
        for (int i = 0; i < v.size(); i++) {
            System.out.println("第" + (i + 1) + "个推荐: 题目:" + v.get(i).getBookName() + "");
        }
    }

    public static List<Books> recommend(String username) {
        IBooksService booksService = new BooksServiceImpl();
        IOrdersService ordersService = new OrdersServiceImpl();
        IUserService userService = new UserServiceImpl();

        List<Orders> orderList;
        //所有用户列表
        List<User> users = userService.queryAllUser();
//所有书籍列表
        List<Books> books = booksService.queryAllBook();
//当前矩阵
        int[][] curMatrix = new int[books.size() + 5][books.size() + 5];
//共现矩阵
        int[][] comMatrix = new int[books.size() + 5][books.size() + 5];
//喜欢每个物品的人数
        int[] N = new int[books.size() + 5];

        for (User user : users) {
            if (user.getUsername().equals(username)) {
                continue;
            }
//当前用户订单
            orderList = ordersService.queryOrderByUn(user.getUsername());
            //清空矩阵
            for (int i = 0; i < books.size(); i++) {
                for (int j = 0; j < books.size(); j++) {
                    curMatrix[i][j] = 0;
                }
            }

            for (int i = 0; i < orderList.size(); i++) {
                int bid1 = booksService.getBookById(orderList.get(i).getId()).getId();
                ++N[bid1];
                for (int j = i + 1; j < orderList.size(); j++) {
                    int bid2 = booksService.getBookById(orderList.get(j).getId()).getId();
                    ++curMatrix[bid1][bid2];
                    ++curMatrix[bid2][bid1];
                }
            }

            //累加当前矩阵，得到共现矩阵
            for (int i = 0; i < books.size(); i++) {
                for (int j = 0; j < books.size(); j++) {
                    int bid1 = books.get(i).getId();
                    int bid2 = books.get(j).getId();
                    comMatrix[bid1][bid2] += curMatrix[bid1][bid2];
                }
            }
        }

        TreeSet<Books> preList = new TreeSet<Books>(new Comparator<Books>() {
            @Override
            public int compare(Books o1, Books o2) {
                if (!o1.getWeight().equals(o2.getWeight())) {
                    if (o1.getWeight() - o2.getWeight() > 0) {
                        return 1;
                    } else {
                        return -1;
                    }
                } else {
                    if (o1.getSales() - o2.getSales() > 0) {
                        return 1;
                    } else {
                        return -1;
                    }

                }
            }
        });


        orderList = ordersService.queryOrderByUn(username);
        //判重数组
        boolean[] used = new boolean[books.size() + 5];
        for (Orders order : orderList) {
            int Nij = 0;
            double Wij;
            Books tmp;

            int i = booksService.getBookById(order.getId()).getId();

            for (Books book : books) {
                if (i == book.getId()) {
                    continue;
                }
                int j = book.getId();
                boolean flag = false;
                Nij = comMatrix[i][j];

                if (N[i] * N[j] != 0) {
                    Wij = (double) Nij / Math.sqrt(N[i] * N[j]);
                } else {
                    Wij = 0;
                }


                tmp = booksService.getBookById(book.getId());
                tmp.setWeight(Wij);

                if (used[tmp.getId()]) {
                    continue;
                }

                if (Wij != 0) {
                    for (Orders orders : orderList) {
                        if (booksService.getBookById(orders.getId()).getId() == j) {
                            flag = true;
                        }
                    }
                    if (!flag) {
                        preList.add(tmp);
                        used[tmp.getId()] = true;
                    }
                }


            }
        }

        List<Books> recomLists = new ArrayList<>();

        for (int i = 1; preList.size() > 0 && i <= 6; i++) {
            recomLists.add(preList.pollLast());
        }
        if (recomLists.size() < 6) {
            int i = 6 - recomLists.size();
            User user = userService.getUserPwdByUsername(username);
            String hobbies = user.getHobbies();
            String hobby1 = hobbies.substring(0, hobbies.indexOf(","));
            String hobby2 = hobbies.substring(hobbies.indexOf(",") + 1, hobbies.lastIndexOf(","));
            String hobby3 = hobbies.substring(hobbies.lastIndexOf(",") + 1, hobbies.length());
            PageHelper.startPage(0, i);
            List<Books> booksList = booksService.queryBookByUH(hobby1, hobby2, hobby3);
            for (Books book : booksList) {
                recomLists.add(book);
            }
        }

        return recomLists;
    }


}
