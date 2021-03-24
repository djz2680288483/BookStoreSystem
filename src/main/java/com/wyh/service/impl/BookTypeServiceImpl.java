package com.wyh.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.wyh.mapper.BookTypeMapper;
import com.wyh.pojo.BookType;
import com.wyh.service.IBookTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author djz
 * @date 2021/3/19 -7:13
 */
@Service
public class BookTypeServiceImpl implements IBookTypeService {
    @Autowired
    BookTypeMapper bookTypeMapper;

    @Override
    public int saveBookType(String typeId, String typeName, int number) {
        BookType bookType = new BookType();
        bookType.setTypeId(typeId);
        bookType.setTypeName(typeName);
        bookType.setNumbers(number);
        return bookTypeMapper.insert(bookType);
    }

    @Override
    public int deleteBookType(int id) {

        return bookTypeMapper.deleteById(id);
    }

    @Override
    public List<BookType> queryAllBookType() {
        List<BookType> bookTypeList = bookTypeMapper.selectList(null);
        if (bookTypeList.isEmpty()) {
            return null;
        }
        return bookTypeList;
    }

    @Override
    public BookType getBookType(String typeName) {
        QueryWrapper<BookType> query = new QueryWrapper<>();
        if (!StringUtils.isEmpty(typeName)) {
            query.lambda().eq(BookType::getTypeName, typeName);
        }
        return bookTypeMapper.selectOne(query);
    }

    @Override
    public int countBookType(String typeName) {
        QueryWrapper<BookType> query = new QueryWrapper<>();
        if (!StringUtils.isEmpty(typeName)) {
            query.lambda().eq(BookType::getTypeName, typeName);
        }
        return bookTypeMapper.selectCount(query);
    }

    @Override
    public int updateBookType(BookType bookType) {
        QueryWrapper<BookType> query = new QueryWrapper<>();
        if (StringUtils.isEmpty(bookType.getTypeName())) {
            return 0;
        }

        return bookTypeMapper.updateById(bookType);
    }
}
