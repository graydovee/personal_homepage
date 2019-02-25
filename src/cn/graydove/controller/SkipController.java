package cn.graydove.controller;

import cn.graydove.pojo.User;
import cn.graydove.service.FilesService;
import cn.graydove.service.UserService;
import cn.graydove.util.ServletUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

@Controller
public class SkipController {
    @Resource
    private UserService userServiceImpl;

    @Resource
    private FilesService filesServiceImpl;

    @RequestMapping("/index")
    public String index(HttpServletRequest request){
        //项目路径
        request.setAttribute("path",request.getServletContext().getContextPath());

        Cookie[] cookies = request.getCookies();
        String username = null;
        String password = null;
        if(cookies!=null){
            for(Cookie cookie:cookies){
                if("username".equals(cookie.getName())){
                    username = cookie.getValue();
                    request.getSession().setAttribute("username",username);
                }
                if("password".equals(cookie.getName())){
                    password = cookie.getValue();
                    request.getSession().setAttribute("password",password);
                }
            }
        }
        //自动登录
        if(username!=null && password!=null){
            User user = (User)request.getSession().getAttribute("user");
            if(user==null){
                user = new User();
                user.setPassword(password);
                user.setUsername(username);
                user.setLastIp(ServletUtil.getIPAddress(request));
                User u = userServiceImpl.login(user);
                if(u!=null){
                    request.getSession().setAttribute("user",u);
                }
            }
        }
        return "index";
    }

    @RequestMapping("/main")
    public String main(){
        return "main";
    }

    @RequestMapping("/file")
    public String file(HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        if(user != null){
            user.setFiles(filesServiceImpl.selByUid(user.getUid()));
        }
        return "file";
    }

    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @RequestMapping("/register")
    public String register(){
        return "register";
    }

    @RequestMapping("/update_password")
    public String updPwd(){
        return "update_password";
    }

    @RequestMapping("/update_message")
    public String updMsg(){
        return "update_message";
    }

    @RequestMapping("/del_website")
    public String delWebsite(){
        return "del_website";
    }

    @RequestMapping("upload")
    public String upload(){
        return "upload";
    }

    @RequestMapping("/open_new_page")
    public String openNewPage(String url,HttpServletRequest request){
        if(url==null){
            url="";
        }
        if(!url.startsWith("http")){
            url = "http://"+url;
        }
        request.setAttribute("url",url);
        return "open_new_page";
    }


}
