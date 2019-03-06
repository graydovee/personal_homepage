<%--
  Created by IntelliJ IDEA.
  User: HUIHUI
  Date: 2019/1/9
  Time: 21:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title><c:if test="${user!=null}">${user.nickname}的主页</c:if><c:if test="${user==null}">个人主页</c:if></title>
    <link rel="stylesheet" href="css/decorator.css">
    <script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">
        $(function(){

            $("li").slideUp(0);

            $(".slid").on("click","p",function(){
                $(this).parent().children("ul").children("li").slideToggle(300);
            });

            $("#right").load("main");

            $("#my_file").click(function(){
                $("#right").load("file");
            });

            $("#my_message").click(function(){
                $("#right").load("update_message");
            });

            $("#update_password").click(function(){
                $("#right").load("update_password");
            });

            $("#main_page").click(function(){
                $("#right").load("main");
            });

            $(".close").click(function(){
                close_mb();
            });
        })

    </script>
</head>
<body>
<div id="body">
    <div id="main">
        <div id="head">
            <p id="main_page">主页</p>
            <c:if test="${user == NULL}">
                <span id="b1" class="btn" onclick="javascript:open_mb('register');">注册</span>
                <span id="b2" class="btn" onclick="javascript:open_mb('login');">登录</span>
            </c:if>
            <c:if test="${user != NULL}">
                <a href="logout"><span id="b3" class="btn">登出</span></a>
                <p id="user">${user.nickname}</p>
            </c:if>
        </div>
        <div id="left">
            <c:if test="${user != null}">
            <div class="slid">
                <p style="cursor:pointer;">个人空间</p>
                <ul>
                    <c:forEach items="${user.elements}" var="ele">
                        <c:if test="${ele.name eq 'file'}">
                            <li id="my_file">我的文件</li>
                        </c:if>
                        <c:if test="${ele.name eq 'msg'}">
                            <li id="my_message">我的信息</li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
            <div class="slid">
                <p style="cursor:pointer;">个人设置</p>
                <ul>
                    <c:forEach items="${user.elements}" var="ele">
                        <c:if test="${ele.name eq 'updpwd'}">
                            <li id="update_password">修改密码</li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
            </c:if>
        </div>
        <div id="right"></div>
    </div>
</div>
<div class="black_over"></div>
<div class="white_content">
    <p class="close">×</p>
    <div></div>
</div>
</body>
</html>
