package com.wyh.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wyh.pojo.BookType;
import com.wyh.pojo.Books;
import com.wyh.pojo.Orders;
import com.wyh.pojo.User;
import com.wyh.service.IBookTypeService;
import com.wyh.service.IBooksService;
import com.wyh.service.IOrdersService;
import com.wyh.utils.FileUtils;
import com.wyh.utils.Items_based;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * @author djz
 * @date 2021/3/19 -7:44
 */
@Controller
public class BooksController {
    @Autowired
    IBooksService booksService;

    @Autowired
    IBookTypeService bookTypeService;

    @Autowired
    IOrdersService ordersService;


    public int lowestPrice;
    public int highestPrice;
    public String typeName;
    public String searchContent;
    public String hobby1;
    public String hobby2;
    public String hobby3;

    /**
     * 查询所有书籍，并返回首页
     *
     * @param currentPage
     * @param model
     * @return
     */
    @RequestMapping("/")
    public String list(@RequestParam(defaultValue = "1") int currentPage, Model model) {
        PageHelper.startPage(currentPage, 6);
        List<Books> booksList = booksService.queryAllBook();
        PageInfo pageInfo = new PageInfo(booksList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("bookList", booksList);
        List<BookType> bookTypeList = bookTypeService.queryAllBookType();
        model.addAttribute("bookTypeList", bookTypeList);
        return "index";
    }

    @RequestMapping("/book/toAddBook")
    public String toAddBook() {
        return "addBook";
    }

    @PostMapping("/book/addBook")
    public String addBook(MultipartFile file, Books books, HttpServletRequest request) throws IOException {
        String filePath = "D:\\images\\";
        String newFilePath = "D:\\bookPicture\\";
        String originalFilename = file.getOriginalFilename();
        String newFileName = originalFilename.substring(30);
        FileUtils.renameFile(filePath + originalFilename, newFileName + newFileName);
        books.setBookId(UUID.randomUUID().toString().replace("-", "").toUpperCase().substring(0, 20));
        books.setBookPic(newFileName);
        booksService.saveBook(books);
        int count = bookTypeService.countBookType(books.getBookType());
        if (count == 1) {
            BookType bookType = bookTypeService.getBookType(books.getBookType());
            int newNumber = bookType.getNumbers() + 1;
            bookType.setNumbers(newNumber);
            bookTypeService.updateBookType(bookType);
            return "redirect:/book/allBook";
        } else {
            bookTypeService.saveBookType(UUID.randomUUID().toString().replace("-", "").toUpperCase().substring(0, 20), books.getBookType(), 1);
            return "redirect:/book/allBook";
        }
    }

    @RequestMapping("/book/specilBook")
    public String specilBook(@RequestParam(defaultValue = "1") int currentPage, Model model) {
        PageHelper.startPage(currentPage, 6);
        List<Books> booksList = booksService.querySpecilBook();
        PageInfo pageInfo = new PageInfo(booksList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("bookList", booksList);
        List<BookType> bookTypeList = bookTypeService.queryAllBookType();
        model.addAttribute("bookTypeList", bookTypeList);
        return "index";
    }


    @RequestMapping("/book/queryBookByType")
    public String queryBookByType(@RequestParam(defaultValue = "1") int currentPage, Model model, String bookType) {
        if (bookType != null) {
            typeName = bookType;
        }

        PageHelper.startPage(currentPage, 6);
        List<Books> booksList = booksService.queryBookByType(typeName);
        PageInfo pageInfo = new PageInfo(booksList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("bookList", booksList);
        List<BookType> bookTypeList = bookTypeService.queryAllBookType();
        model.addAttribute("bookTypeList", bookTypeList);
        return "index";
    }


    @RequestMapping("/book/queryBook")
    public String queryBookByType(@RequestParam(defaultValue = "1") int currentPage, Model model, String bookName, boolean bNIsinput, @RequestParam(defaultValue = "0") int lp, boolean lpIsinput, boolean hpIsinput, @RequestParam(defaultValue = "10000") int hp) {
        if (bNIsinput && (!lpIsinput) && (!hpIsinput)) {
            searchContent = bookName;
            lowestPrice = 0;
            highestPrice = 100000000;
        }
        if (!(bNIsinput) && lpIsinput && !(hpIsinput)) {
            lowestPrice = lp;
            highestPrice = 100000000;
            searchContent = "";
        }
        if (!(bNIsinput) && !(lpIsinput) && hpIsinput) {
            lowestPrice = 100000000;
            highestPrice = hp;
            searchContent = "";
        }
        if (!(bNIsinput) && lpIsinput && hpIsinput) {
            lowestPrice = lp;
            highestPrice = hp;
            searchContent = "";
        }
        if (bNIsinput && lpIsinput && hpIsinput) {
            lowestPrice = lp;
            highestPrice = hp;
            searchContent = bookName;
        }


        if (lowestPrice > highestPrice) {
            int t;
            t = lowestPrice;
            lowestPrice = highestPrice;
            highestPrice = t;
        }
        PageHelper.startPage(currentPage, 6);
        List<Books> booksList = booksService.queryBook(searchContent, lowestPrice, highestPrice);
        PageInfo pageInfo = new PageInfo(booksList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("bookList", booksList);
        List<BookType> bookTypeList = bookTypeService.queryAllBookType();
        model.addAttribute("bookTypeList", bookTypeList);
        return "index";
    }

    @RequestMapping("/book/toBookDetail")
    public String toBookDetail() {
        return "bookDetail";
    }

    @RequestMapping("/book/queryBookById")
    public String queryBookById(int id, Model model) {
        Books book = booksService.getBookById(id);
        model.addAttribute("book", book);
        return "bookDetail";
    }

    @RequestMapping("/book/allBook")
    public String allBook(@RequestParam(defaultValue = "1") int currentPage, Model model) {
        PageHelper.startPage(currentPage, 6);
        List<Books> booksList = booksService.queryAllBook();
        PageInfo pageInfo = new PageInfo(booksList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("bookList", booksList);
        return "bookManagement";
    }

    @RequestMapping("/book/toUpdateBook")
    public String toUpdateBook(int id, Model model) {
        Books book = booksService.getBookById(id);
        model.addAttribute("book", book);
        return "updateBook";
    }

    @PostMapping("/book/updateBook")
    public String updateBook(MultipartFile file, Books books, String originalPic) throws IOException {
        String filePath = "D:\\bookPicture\\";

        String originalFilename = file.getOriginalFilename();
        String newFileName = originalFilename.substring(30);
        FileUtils.renameFile(filePath + originalFilename, filePath + newFileName);
        File originalTF = new File(filePath, originalPic);
        originalTF.delete();
        books.setBookPic(newFileName);
        booksService.updateBook(books);
        int count = bookTypeService.countBookType(books.getBookType());
        if (count == 1) {
            BookType bookType = bookTypeService.getBookType(books.getBookType());
            bookType.setNumbers(bookType.getNumbers() + 1);
            bookTypeService.updateBookType(bookType);
            return "redirect:/book/allBook";
        } else {
            bookTypeService.saveBookType(UUID.randomUUID().toString().replace("-", "").toUpperCase().substring(0, 20), books.getBookType(), 1);
            return "redirect:/book/allBook";
        }
    }

    @RequestMapping("/book/deleteBook")
    public String deleteBook(int id) {
        String filePath = "D:\\bookPicture";

        Books book = booksService.getBookById(id);
        File targetFile = new File(filePath, book.getBookPic());
        targetFile.delete();
        booksService.deleteBookById(id);
        return "redirect:/book/allBook";
    }

    @RequestMapping("/book/recommendBook")
    public String recommendBook(String hobbies, Model model, @RequestParam(defaultValue = "1") int currentPage, HttpServletRequest request) {
        boolean flag = true;
        User user = (User) request.getSession().getAttribute("userSession");
        List<Orders> orders = ordersService.queryOrderByUn(user.getUsername());
        int size = orders.size();
        if (size != 0) {
            flag = false;
        }
        if (flag) {
            if (hobbies != null) {
                hobby1 = hobbies.substring(0, hobbies.indexOf(","));
                hobby2 = hobbies.substring(hobbies.indexOf(",") + 1, hobbies.lastIndexOf(","));
                hobby3 = hobbies.substring(hobbies.lastIndexOf(",") + 1, hobbies.length());
            }
            PageHelper.startPage(currentPage, 6);
            List<Books> booksList = booksService.queryBookByUH(hobby1, hobby2, hobby3);

            model.addAttribute("bookList", booksList);
            List<BookType> bookTypeList = bookTypeService.queryAllBookType();
            model.addAttribute("bookTypeList", bookTypeList);
            return "index";
        } else {


            List<Books> recommend = Items_based.recommend(user.getUsername());
            model.addAttribute("bookList", recommend);
            System.out.println("====================================================" + recommend.size());

            List<BookType> bookTypeList = bookTypeService.queryAllBookType();
            model.addAttribute("bookTypeList", bookTypeList);
            return "index";
        }


    }

}
