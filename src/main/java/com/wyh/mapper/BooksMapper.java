package com.wyh.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.wyh.pojo.Books;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author djz
 * @date 2021/3/18 -19:22
 */
@Repository
public interface BooksMapper extends BaseMapper<Books> {
    /**
     * 销售数量加一
     *
     * @param id
     * @return
     */
    int saveSaleById(int id);



    /**
     * 通过用户爱好查询书籍
     *
     * @param hobby1
     * @param hobby2
     * @param hobby3
     * @return
     */

    List<Books> queryBookByUH(@Param("hobby1") String hobby1, @Param("hobby2") String hobby2, @Param("hobby3") String hobby3);
}
