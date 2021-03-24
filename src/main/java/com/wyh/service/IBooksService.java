package com.wyh.service;

import com.wyh.pojo.Books;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author djz
 * @date 2021/3/18 -19:32
 */
public interface IBooksService {
    /**
     * 增加一本书
     *
     * @param books
     * @return
     */

    int saveBook(Books books);

    /**
     * 删除一本书
     *
     * @param id
     * @return
     */
    int deleteBookById(int id);

    /**
     * 更新一本书
     *
     * @param books
     * @return
     */
    int updateBook(Books books);

    /**
     * 查询全部的书
     *
     * @return
     */
    List<Books> queryAllBook();

    /**
     * 通过名字查询书
     *
     * @param bookName
     * @param lp
     * @param hp
     * @return
     */
    List<Books> queryBook(String bookName, int lp, int hp);

    /**
     * 查询特价书籍
     *
     * @return
     */

    List<Books> querySpecilBook();

    /**
     * 通过类型查询书籍
     *
     * @param bookType
     * @return
     */
    List<Books> queryBookByType(@Param("bookType") String bookType);

    /**
     * 通过ID查询书籍
     *
     * @param id
     * @return
     */
    Books getBookById(@Param("id") int id);

    /**
     * @param hobby1
     * @param hobby2
     * @param hobby3
     * @return
     */
    List<Books> queryBookByUH(@Param("hobby1") String hobby1, @Param("hobby2") String hobby2, @Param("hobby3") String hobby3);

    /**
     * 销量加1
     *
     * @param id
     * @return
     */
    int saveSaleById(@Param("id") int id);
}
