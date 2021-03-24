package com.wyh.service;

import com.wyh.pojo.BookType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author djz
 * @date 2021/3/19 -7:13
 */
public interface IBookTypeService {
    /**
     * 添加书籍类型
     *
     * @param id
     * @param type
     * @param number
     * @return
     */
    int saveBookType(String id, String type, int number);

    /**
     * 删除书籍类型
     *
     * @param autoId
     * @return
     */
    int deleteBookType(int autoId);

    /**
     * 查询所有书籍类型
     *
     * @return
     */
    List<BookType> queryAllBookType();

    /**
     * 查询指定书籍类型
     *
     * @param typeName
     * @return
     */
    BookType getBookType(@Param("typeName") String typeName);

    /**
     * 查询该书籍类型数量
     *
     * @param type
     * @return
     */
    int countBookType(String type);

    /**
     * 更新该书籍类型的书籍数量
     *
     * @param bookType
     * @return
     */
    int updateBookType(BookType bookType);
}
