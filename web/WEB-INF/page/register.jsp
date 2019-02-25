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

        var username = false;
        var nickname = false;
        var password = false;
        var confirm = false;

        $(function(){
            $(".verification_code_btn").click(function(){
                refresh_verification_code();
                return false;
            });

            $("#username").blur(function(){
                if($(this).val()==""){
                    $(this).next().css("color","red").html("×");
                    $("#username_span").css("color","red").html("");
                    username = false;
                }else{
                    $.post("repeat","username="+$(this).val(),function(data){
                        if(data=="1"){
                            $("#username_span").css("color","red").html("用户名已存在")
                            $("#username").next().css("color","red").html("×");
                            username = false;
                        }else if(data=="0"){
                            $("#username").next().css("color","green").html("√")
                            $("#username_span").css("color","red").html("");
                            username = true;
                        }
                    });
                }
            });

            $("#nickname").blur(function(){
                if($(this).val()==""){
                    $(this).next().css("color","red").html("×")
                    nickname = false;
                }else{
                    $(this).next().css("color","green").html("√")
                    nickname = true;
                }
            });
            //密码
            $("#password").blur(function(){
                check_password();
                check_confirm()
            });
            //确认密码
            $("#confirm").blur(function(){
                check_password()
                check_confirm()
            });

            $(".reset_btn").click(function(){
                $("#username").val("");
                $("#nickname").val("");
                $("#password").val("");
                $("#confirm").val("");
                $("#verification_code").val("");
                $("#username").next().html("");
                $("#nickname").next().html("");
                $("#password").next().html("");
                $("#confirm").next().html("");
                $("#username_span").css("color","red").html("");
            });

            $(".submit_btn").click(function(){
                if(username && nickname && password && confirm){
                    var $data = $(".register_form").serialize();
                    $.post("register_",$data ,function(data){
                        if(data=="200"){
                            alert("注册成功");
                            open_mb("login");
                        }else if(data=="402"){
                            alert("验证码错误");
                        }else if(data=="500"){
                            alert("服务器繁忙，错误代码"+data);
                        }
                        refresh_verification_code();
                    });
                }
                else{
                    alert("请正确填写信息");
                }
            });
        });

        function check_password(){
            if(!$("#password").val().match(/^\w{6,12}$/)){
                $("#password").next().css("color","red").html("×")
                password = false;
            }else{
                $("#password").next().css("color","green").html("√")
                password = true;
            }
        }

        function check_confirm(){
            if($("#confirm").val()=="" || $("#confirm").val()!=$("#password").val()){
                $("#confirm").next().css("color","red").html("×")
                confirm = false;
            }else{
                $("#confirm").next().css("color","green").html("√")
                confirm  = true;
            }
        }

    </script>
</head>
<body>
<div class="mb_div">
    <form class="register_form" action="" method="post">
        <table class="form_table">
            <tr>
                <td>用户名：</td>
                <td><input id="username" class="text_input" type="text" name="username" value=""><span></span></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td><span id="username_span" style="font-size: 14px"></span></td>
            </tr>
            <tr>
                <td>昵称：</td>
                <td><input id="nickname"  class="text_input" type="text" name="nickname" value=""><span></span></td>
            </tr>
            <tr>
                <td>密码：</td>
                <td><input id="password"  class="text_input" type="password" name="password" value=""><span></span></td>
            </tr>
            <tr>
                <td>确认密码：</td>
                <td><input id="confirm"  class="text_input" type="password" name="confirm" value=""><span></span></td>
            </tr>
            <tr>
                <td>验证码：</td>
                <td><input id="verification_code" class="text_input" type="text" name="verification_code" style="width:50px;"><a class="verification_code_btn"><img class="verification_code_img" src="verification_code"></a></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><button type="button" class="reset_btn">重置</button>&nbsp;&nbsp;&nbsp;<button class="submit_btn" type="button">注册</button></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>

