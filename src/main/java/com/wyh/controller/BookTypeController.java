package com.wyh.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wyh.pojo.BookType;
import com.wyh.service.IBookTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @author djz
 * @date 2021/3/19 -9:02
 */
@Controller
public class BookTypeController {
    @Autowired
    IBookTypeService bookTypeService;

    @RequestMapping("/bookType/deleteType")
    public String deleteType(int id) {
        bookTypeService.deleteBookType(id);
        return "redirect:/bookType/allType";
    }


    @RequestMapping("/bookType/allType")
    public String allBook(@RequestParam(defaultValue = "1") int currentPage, Model model) {
        PageHelper.startPage(currentPage, 6);
        List<BookType> bookTypeList = bookTypeService.queryAllBookType();
        PageInfo pageInfo = new PageInfo(bookTypeList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("typeList", bookTypeList);
        return "typeManagement";
    }


}
