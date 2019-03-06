<%--
  Created by IntelliJ IDEA.
  User: HUIHUI
  Date: 2019/1/10
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>login</title>
    <link rel="stylesheet" href="css/decorator.css">
    <script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="js/js.js"></script>
    <script type="text/javascript">
        $(function(){
            $(".reset_btn").click(function(){
                $("#username").val("");
                $("#password").val("");
                $("#verification_code").val("");
            });

            $(".verification_code_btn").click(function(){
                refresh_verification_code();
                return false;
            })

            if($("#username").val()!=""){
                document.getElementById("remuser").checked="checked";
            }

            $(".submit_btn").click(function(){
                var $date = $('.login_form').serialize();
                $.post("login_",$date,function(data){
                    if(data=="200"){
                        window.location.href=window.location.href;
                    }else if(data=="401"){
                        alert("用户名或密码错误");
                        refresh_verification_code();
                        $("#password").val("");
                        $("#verification_code").val("");
                    }else if(data=="402"){
                        alert("验证码错误");
                        refresh_verification_code();
                        $("#verification_code").val("");
                    }
                });
                return false;
            });
        });
    </script>
</head>
<body>
<div class="mb_div">
    <form class="login_form" action="#" method="post">
        <table class="form_table">
            <tr>
                <td>用户名：</td>
                <td><input id="username" class="text_input" type="text" name="username" value="${username}"></td>
            </tr>
            <tr>
                <td>密码：</td>
                <td><input id="password" class="text_input" type="password" name="password" value="${password}"></td>
            </tr>
            <tr>
                <td>验证码：</td>
                <td><input id="verification_code" class="text_input" type="text" name="verification_code" style="width:50px;"><a class="verification_code_btn"><img class="verification_code_img" src="verification_code"></a></td>
            </tr>
            <tr>
                <td><input id="remuser" name="remember" type="checkbox" value="remuser"><span style="font-size: 18px">记住账号</span></td>
                <td><input name="remember" type="checkbox" value="auto"><span style="font-size: 18px">自动登录</span></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><button type="button" class="reset_btn">重置</button>&nbsp;&nbsp;&nbsp;<button type="button" class="submit_btn">登录</button></td>
            </tr>
        </table>
    </form>
</div>

</body>
</html>
