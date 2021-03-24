package com.wyh.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.wyh.mapper.BooksMapper;
import com.wyh.pojo.Books;
import com.wyh.service.IBooksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author djz
 * @date 2021/3/18 -19:33
 */
@Service
public class BooksServiceImpl implements IBooksService {

    @Autowired
    BooksMapper booksMapper;

    @Override
    public int saveBook(Books books) {

        return booksMapper.insert(books);
    }

    @Override
    public int deleteBookById(int id) {
        return booksMapper.deleteById(id);
    }

    @Override
    public int updateBook(Books books) {
        return booksMapper.updateById(books);
    }

    @Override
    public List<Books> queryAllBook() {
        List<Books> list = booksMapper.selectList(null);
        if (list.isEmpty()) {
            return null;
        }
        return list;
    }

    @Override
    public List<Books> queryBook(String bookName, int lp, int hp) {
        QueryWrapper<Books> query = new QueryWrapper<>();

        if (!StringUtils.isEmpty(bookName)) {
            query.lambda().eq(Books::getBookName, bookName);
        }
        if (lp != 0) {
            query.lambda().ge(Books::getBookPrice, lp);
        }
        if (hp != 0) {
            query.lambda().le(Books::getBookPrice, hp);
        }
        List<Books> books = booksMapper.selectList(query);
        if (books.isEmpty()) {
            return null;
        }
        return books;
    }

    @Override
    public List<Books> querySpecilBook() {
        QueryWrapper<Books> query = new QueryWrapper<>();

        query.lambda().lt(Books::getBookDiscount, 10.0);
        return booksMapper.selectList(query);
    }

    @Override
    public List<Books> queryBookByType(String bookType) {
        QueryWrapper<Books> query = new QueryWrapper<>();

        if (!StringUtils.isEmpty(bookType)) {
            query.lambda().eq(Books::getBookType, bookType);
        }
        List<Books> books = booksMapper.selectList(query);
        if (books.isEmpty()) {
            return null;
        }
        return books;
    }

    @Override
    public Books getBookById(int id) {

        return booksMapper.selectById(id);
    }

    @Override
    public List<Books> queryBookByUH(String hobby1, String hobby2, String hobby3) {
        return booksMapper.queryBookByUH(hobby1, hobby2, hobby3);
    }

    @Override
    public int saveSaleById(int id) {

        QueryWrapper<Books> query = new QueryWrapper<>();

        return booksMapper.saveSaleById(id);
    }
}
