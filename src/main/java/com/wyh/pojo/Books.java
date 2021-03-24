package com.wyh.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;


/**
 * @author 默尘
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("books")
public class Books implements Serializable {
    private static final long serialVersionUID = 1L;
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String bookId;
    private String bookType;
    private String bookAuthor;
    private BigDecimal bookPrice;
    private String bookPic;
    private BigDecimal bookDiscount;
    private String bookName;
    private String detail;
    @TableField(exist = false)
    private Double weight;
    private Integer sales;
}
