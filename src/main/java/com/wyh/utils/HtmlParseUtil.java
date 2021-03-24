package com.wyh.utils;

import com.wyh.pojo.BookType;
import com.wyh.pojo.Books;
import com.wyh.service.IBookTypeService;
import com.wyh.service.IBooksService;
import com.wyh.service.impl.BookTypeServiceImpl;
import com.wyh.service.impl.BooksServiceImpl;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;

import java.io.*;
import java.math.BigDecimal;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @author 默尘
 */
@Controller
public class HtmlParseUtil {


    public static void main(String[] args) throws IOException {
        IBooksService booksService = new BooksServiceImpl();
        IBookTypeService bookTypeService = new BookTypeServiceImpl();

        String address = "_0_0_11_0_1_1_0_0_/";
        for (int j = 1; j < 5; j++) {
            String newaddress = address.substring(0, 12) + j + address.substring(13, address.length());
            List<Books> booksList = new HtmlParseUtil().parseBooksChina(newaddress);
            for (Books books : booksList) {
                booksService.saveBook(books);
                int count = bookTypeService.countBookType(books.getBookType());
                if (count == 1) {
                    BookType bookType = bookTypeService.getBookType(books.getBookType());
                    bookType.setNumbers(bookType.getNumbers() + 1);
                    bookTypeService.updateBookType(bookType);

                } else {
                    bookTypeService.saveBookType(UUID.randomUUID().toString().replace("-", "").toUpperCase(), books.getBookType(), 1);

                }
            }
        }

    }


    public List<Books> parseBooksChina(String keywords) throws IOException {
        String url = "http://www.bookschina.com/kinder/23000000" + keywords;

        Document document = Jsoup.parse(new URL(url).openStream(), "GBK", url);
        Elements elements = document.getElementsByClass("bookList");
        Elements elements1 = document.select("div.bookList");
        Elements li = elements1.select("li");

        ArrayList<Books> booksList = new ArrayList<Books>();

        for (Element el : li) {
            String bookPic = el.getElementsByTag("img").eq(0).attr("data-original");
            String bookName = el.getElementsByClass("name").eq(0).text();
            String bookAuthor = el.getElementsByClass("author").eq(0).text();

            String bookType = "古籍";

            String detail = el.getElementsByClass("recoLagu").eq(0).text();

            String bookPrice1 = el.getElementsByTag("del").eq(0).text();
            String bookPrice2 = bookPrice1.substring(1, bookPrice1.length());
            BigDecimal bookPrice = new BigDecimal(bookPrice2);

            String bookDiscount1 = el.getElementsByClass("discount").eq(0).text();
            String bookDiscount2 = bookDiscount1.substring(1, bookDiscount1.length() - 2);
            BigDecimal bookDiscount = new BigDecimal(bookDiscount2);


            // 截取图片文件名
            String fileName = bookPic.substring(bookPic.lastIndexOf('/') + 1, bookPic.length());
            try {
                // 文件名里面可能有中文或者空格，所以这里要进行处理。但空格又会被URLEncoder转义为加号
                String urlTail = URLEncoder.encode(fileName, "UTF-8");
                // 因此要将加号转化为UTF-8格式的%20
                bookPic = bookPic.substring(0, bookPic.lastIndexOf('/') + 1) + urlTail.replaceAll("\\+", "\\%20");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            String newfileName = UUID.randomUUID().toString().replace("-", "").toUpperCase() + fileName;
            HtmlParseUtil.downImages("D:\\images", newfileName, bookPic);
            Books books = new Books();
            books.setBookId(UUID.randomUUID().toString().replace("-", "").toUpperCase());
            books.setBookPic(newfileName);
            books.setBookName(bookName);
            books.setBookAuthor(bookAuthor);
            books.setBookType(bookType);
            books.setDetail(detail);
            books.setBookPrice(bookPrice);
            books.setBookDiscount(bookDiscount);
            booksList.add(books);
        }
        return booksList;
    }


    public static void downImages(String filePath, String newfileName, String imgUrl) {
        // 若指定文件夹没有，则先创建
        File dir = new File(filePath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // 写出的路径
        File file = new File(filePath + File.separator + newfileName);

        try {
            // 获取图片URL
            URL url = new URL(imgUrl);
            // 获得连接
            URLConnection connection = url.openConnection();
            // 设置10秒的相应时间
            connection.setConnectTimeout(10 * 1000);
            // 获得输入流
            InputStream in = connection.getInputStream();
            // 获得输出流
            BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(file));
            // 构建缓冲区
            byte[] buf = new byte[1024];
            int size;
            // 写入到文件
            while (-1 != (size = in.read(buf))) {
                out.write(buf, 0, size);
            }
            out.close();
            in.close();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }


}
