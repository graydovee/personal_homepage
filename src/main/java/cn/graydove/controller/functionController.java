package cn.graydove.controller;

import cn.graydove.pojo.Files;
import cn.graydove.pojo.User;
import cn.graydove.pojo.Website;
import cn.graydove.service.FilesService;
import cn.graydove.service.UserService;
import cn.graydove.service.WebsiteService;
import cn.graydove.util.ServletUtil;
import cn.graydove.util.StateUtil;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;

@Controller
public class functionController {
    @Resource
    private UserService userServiceImpl;

    @Resource
    private WebsiteService websiteServiceImpl;

    @Resource
    private FilesService filesServiceImpl;

    @ResponseBody
    @RequestMapping("login_")
    public String login_(User user, @RequestParam(value = "verification_code",required = false) String verificationCode, @RequestParam(value = "remember", required = false) List<String> list, HttpServletRequest request, HttpServletResponse response){
        String code = (String)request.getSession().getAttribute("code");
        user.setLastIp(ServletUtil.getIPAddress(request));
        if(code!=null && code.equals(verificationCode)){
            User u = userServiceImpl.login(user);
            //登录成功
            if(u!=null) {
                if(list!=null && list.size()>0){
                    for(String each:list){
                        if("remuser".equals(each) || "auto".equals(each)){
                            Cookie cookie = new Cookie("username",user.getUsername());
                            cookie.setMaxAge(60*60*24*30);
                            response.addCookie(cookie);
                        }
                        if("auto".equals(each)){
                            Cookie cookie = new Cookie("password",user.getPassword());
                            cookie.setMaxAge(60*60*24*30);
                            response.addCookie(cookie);
                        }
                    }
                }
                request.getSession().setAttribute("user", u);
                return StateUtil.OK;
            }
            return StateUtil.PASSWORD_ERROR;
        }else{
            return StateUtil.VERIFICATION_CODE_ERROR;
        }
    }

    @RequestMapping("verification_code")
    public void verificationCode(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        //创建一张图片
        BufferedImage image = new BufferedImage(200, 100, BufferedImage.TYPE_INT_BGR);

        Graphics2D gra = image.createGraphics();
        gra.setColor(Color.WHITE);
        gra.fillRect(0, 0, image.getWidth(), image.getHeight());

        StringBuilder randCode = new StringBuilder();
        Random random = new Random();

        //设置字体
        gra.setFont(new Font("宋体", Font.BOLD|Font.ITALIC, 30));
        for(int i=0;i<4;++i) {
            randCode.append(random.nextInt(10));
        }

        String randList = randCode.toString();
        //画验证码
        Color[] colors = new Color[] {Color.RED,Color.GREEN,Color.BLUE,Color.PINK,Color.GRAY};
        for(int i=0;i<4;++i) {
            gra.setColor(colors[random.nextInt(colors.length)]);
            gra.drawString(""+randList.charAt(i), i*40, 50+(random.nextInt(21)-10));
        }
        //划横线
        for(int i=0;i<3;++i) {
            gra.setColor(colors[random.nextInt(colors.length)]);
            gra.drawLine(0, random.nextInt(41)+30, 200, random.nextInt(41)+30);

        }

        ServletOutputStream os = resp.getOutputStream();

        //工具类ImageIo
        ImageIO.write(image, "jpg", os);

        //把验证码放入Session中
        req.getSession().setAttribute("code", randList);
    }

    @RequestMapping("logout")
    public String logout(HttpServletRequest request,HttpServletResponse response){
        request.getSession().invalidate();
        Cookie[] cookies = request.getCookies();
        if(cookies!=null){
            for (Cookie cookie:cookies){
                if("password".equals(cookie.getName())){
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
        return "redirect:/";
    }

    @ResponseBody
    @RequestMapping("register_")
    public String register_(User user, @RequestParam(value = "verification_code", required = false) String verificationCode, HttpSession session){
        String code = (String)session.getAttribute("code");
        if(code!=null && code.equals(verificationCode)){
            user.setRid(1);
            int count = userServiceImpl.insUser(user);
            if(count>0){
                return StateUtil.OK;
            }else{
                return StateUtil.SYSTEM_ERROR;
            }
        }else{
            return StateUtil.VERIFICATION_CODE_ERROR;
        }
    }

    @ResponseBody
    @RequestMapping("repeat")
    public String repeat(String username){
        int count = 0;
        if(username!=null){
            count = userServiceImpl.selUsernameCount(username);
        }
        return ""+count;
    }

    @ResponseBody
    @RequestMapping("update_password_")
    public String updatePassword_(String oldPwd,String newPwd,HttpSession session){
        if(oldPwd!=null && newPwd!=null){
            User user = (User)session.getAttribute("user");
            if(user!=null){
                if(oldPwd.equals(user.getPassword())){
                    user.setPassword(newPwd);
                    int count = userServiceImpl.updUser(user);
                    if(count>0){
                        session.invalidate();
                        return StateUtil.OK;
                    }else{
                        return StateUtil.SYSTEM_ERROR;
                    }
                }
            }else{
                return StateUtil.NO_LOGIN;
            }
        }
        return StateUtil.PASSWORD_ERROR;
    }

    @ResponseBody
    @RequestMapping("update_message_")
    public String updateMessage_(String nickname,int sex,int year,int month,int day,HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        if(user != null){
            //设置昵称
            if(nickname!=null && !"".equals(nickname)){
                user.setNickname(nickname);
            }

            //设置性别
            user.setSex(sex);

            //设置生日
            if(year!=0 && month!=0 && day!=0){
                String dayStr = year+"-"+month+"-"+day;
                Date date = null;
                try {
                    date = new SimpleDateFormat("yyyy-MM-dd").parse(dayStr);
                } catch (ParseException e) {
                    return StateUtil.FORMAT_ERROR;
                }
                java.sql.Date sqlDate = new java.sql.Date(date.getTime());
                user.setBirth(sqlDate);
            }

            int count = userServiceImpl.updUser(user);
            if(count>0){
                return StateUtil.OK;
            }else{
                return StateUtil.SYSTEM_ERROR;
            }
        }
        return StateUtil.NO_LOGIN;
    }

    @ResponseBody
    @RequestMapping("add_website_")
    public String addWebsite_(Website website,HttpSession session){
        User user = (User) session.getAttribute("user");

        if(user!=null){
            int count;
            website.setUid(user.getUid());
            count = websiteServiceImpl.insWebsite(website);
            if(count>0){
                user.setWebsites(websiteServiceImpl.selByUid(user.getUid()));
                session.setAttribute("user",user);
                return StateUtil.OK;
            }else{
                return StateUtil.SYSTEM_ERROR;
            }
        }else{
            return StateUtil.NO_LOGIN;
        }
    }

    @ResponseBody
    @RequestMapping("upload_file_")
    public String uploadFile_(MultipartFile file,HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");

        Logger logger = Logger.getLogger(functionController.class);
        if(user!=null){
            if(file !=null ){
                Files files = new Files();
                files.setUid(user.getUid());

                //获取文件名
                files.setName(file.getOriginalFilename());

                //获取文件后缀
                String suffix = files.getName().substring(files.getName().lastIndexOf('.'));
                String classPath = this.getClass().getClassLoader().getResource("").getPath();
                File f = new File(classPath+"../../..","files");
                if(!f.exists()){
                    f.mkdir();
                }

                logger.debug(f.getAbsolutePath());

                //生成uuid
                files.setUuid(UUID.randomUUID().toString()+suffix);

                try {
                    FileUtils.copyInputStreamToFile(file.getInputStream(),new File(f,files.getUuid()));
                    filesServiceImpl.insFiles(files);
                } catch (IOException e) {
                    return StateUtil.SYSTEM_ERROR;
                }


                return StateUtil.OK;
            }
            return StateUtil.FORMAT_ERROR;
        }else{
            return StateUtil.NO_LOGIN;
        }

    }

    @ResponseBody
    @RequestMapping("delete_file_")
    public String deleteFile_(String uuid,HttpServletRequest request){
        User u = (User)request.getSession().getAttribute("user");
        if(u!=null){
            String classPath = this.getClass().getClassLoader().getResource("").getPath();
            File f = new File(classPath+"../../..","files");

            if(f.exists() && f.isDirectory()){
                File file = new File(f,uuid);
                if(file.exists()){
                    file.delete();
                    filesServiceImpl.delFile(uuid);
                    return StateUtil.OK;
                }
            }
            return StateUtil.SYSTEM_ERROR;
        }
        return StateUtil.NO_LOGIN;
    }

    @RequestMapping("download_")
    public void download_(String uuid,String fileName,HttpServletResponse response) throws IOException {
        response.setHeader("Content-Disposition","attachment;filename="+new String(fileName.getBytes("GBK"),"ISO8859_1"));

        String classPath = this.getClass().getClassLoader().getResource("").getPath();
        File f = new File(classPath+"../../..","files");

        if(f.exists() && f.isDirectory()){
            File file = new File(f,uuid);
            if(file.exists()){
                filesServiceImpl.updCount(uuid);
                OutputStream os = response.getOutputStream();
                byte[] bytes = FileUtils.readFileToByteArray(file);
                os.write(bytes);
                os.flush();
                os.close();
            }else{
                filesServiceImpl.delFile(uuid);
            }
        }
    }

    @ResponseBody
    @RequestMapping("del_website_")
    public String delWebsite_(int wid,HttpServletRequest request){
        User u = (User)request.getSession().getAttribute("user");

        if(u!=null){
            int count = 0;
            List<Website> websites = u.getWebsites();
            for(int i =0;i<websites.size();++i){
                Website website = websites.get(i);
                if(website.getWid()==wid){
                    count = websiteServiceImpl.delWebsite(wid);
                    websites.remove(i);
                    break;
                }
            }
            if(count>0){
                return StateUtil.OK;
            }else{
                return StateUtil.SYSTEM_ERROR;
            }

        }else{
            return StateUtil.NO_LOGIN;
        }

    }
}
