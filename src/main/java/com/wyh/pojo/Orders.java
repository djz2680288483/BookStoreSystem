package com.wyh.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.omg.PortableInterceptor.INACTIVE;

import java.io.Serializable;
import java.util.Date;

/**
 * @author 默尘
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("orders")
public class Orders implements Serializable {
    private static final long serialVersionUID = 1L;
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String orderId;
    private String username;
    private Integer isPay;
    private Date orderDate;
    private String receverAddr;
    private String receverTel;
    private Integer isDelivery;
    private Integer completion;
    private String bookName;
    private String bookId;
}
