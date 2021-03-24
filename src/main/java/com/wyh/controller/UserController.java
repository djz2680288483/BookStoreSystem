package com.wyh.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wyh.pojo.BookType;
import com.wyh.pojo.User;
import com.wyh.service.IBookTypeService;
import com.wyh.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.UUID;

/**
 * @author djz
 * @date 2021/3/19 -9:02
 */
@Controller
public class UserController {
    @Autowired
    IUserService userService;

    @Autowired
    IBookTypeService bookTypeService;

    @RequestMapping("/user/addUser")
    public String addUser(User user, Model model, String password2) {
        int count = userService.countUserByUsername(user.getUsername());
        if (count == 0 && password2.equals(user.getPassword())) {
            String uId = UUID.randomUUID().toString().replace("-", "").toUpperCase().substring(0, 20);
            user.setUid(uId);
            userService.saveUser(user);
            return "login";
        } else if (count != 0) {
            model.addAttribute("message1", "用户名已存在");
        }
        if (!(password2.equals(user.getPassword()))) {
            model.addAttribute("message2", "两次密码不一致");
        }
        return "regist";
    }

    @RequestMapping("/user/toLogin")
    public String toLogin() {
        return "login";
    }

    @RequestMapping("/user/toRegist")
    public String toRegist(Model model) {
        List<BookType> bookTypeList = bookTypeService.queryAllBookType();
        model.addAttribute("bookTypeList", bookTypeList);
        return "regist";
    }


    @RequestMapping("/user/userLogin")
    public String userLogin(String userName, String passWord, Model model, HttpServletRequest req) {
        int count = userService.countUserByUsername(userName);
        if (count == 0) {
            model.addAttribute("message", 1);
            return "login";
        } else {
            User user = userService.getUserPwdByUsername(userName);

            if ("admin".equals(userName)) {
                if (user.getPassword().equals(passWord)) {
                    req.getSession().setAttribute("userSession", user);
                    req.getSession().setAttribute("userName", user.getUsername());
                    req.getSession().setAttribute("id", user.getId());
                    return "redirect:/order/allOrder";
                } else {
                    model.addAttribute("message", 2);
                    return "login";
                }
            }

            if (user.getPassword().equals(passWord)) {
                req.getSession().setAttribute("userSession", user);
                req.getSession().setAttribute("userName", user.getUsername());
                req.getSession().setAttribute("userId", user.getId());
                return "redirect:../";
            } else {
                model.addAttribute("message", 2);
                return "login";
            }
        }
    }


    @RequestMapping("/user/userLogout")
    public String userLogout(HttpSession session) {
        session.removeAttribute("userSession");
        session.removeAttribute("userName");
        session.removeAttribute("userId");
        session.invalidate();
        return "redirect:../";
    }

    @RequestMapping("/Ajax/checkName")
    @ResponseBody
    public String checkName(String username) {
        String msg = "";
        if (username != null && username != "") {
            int count = userService.countUserByUsername(username);
            if (count == 1) {
                msg = "用户名已存在";
            } else {
                msg = "用户名可用";
            }
        }
        return msg;
    }

    @RequestMapping("/Ajax/checkName_update")
    @ResponseBody
    public String checkName_update(String username, String id, HttpServletRequest req) {
        String msg = "";
        String originalUN = (String) req.getSession().getAttribute("userName");
        if (username.equals(originalUN)) {
            return msg;
        } else {
            if (username != null && username != "") {
                int count = userService.countUserByUsername(username);
                if (count == 1) {
                    msg = "用户名已存在";
                } else {
                    msg = "用户名可用";
                }
            }
            return msg;
        }
    }

    @RequestMapping("/user/toMypage")
    public String toMypage() {
        return "myPage";
    }

    @RequestMapping("/user/allUser")
    public String allUser(@RequestParam(defaultValue = "1") int currentPage, Model model) {
        PageHelper.startPage(currentPage, 6);
        List<User> userList = userService.queryAllUser();
        PageInfo pageInfo = new PageInfo(userList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("userList", userList);
        return "userManagement";
    }

    @RequestMapping("/user/deleteUser")
    public String deleteUser(int id) {
        userService.deleteUserById(id);
        return "redirect:/user/allUser";
    }


}
