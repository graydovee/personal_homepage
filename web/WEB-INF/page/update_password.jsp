<%--
  Created by IntelliJ IDEA.
  User: HUIHUI
  Date: 2019/1/11
  Time: 19:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">

    <link rel="stylesheet" href="css/decorator.css">
    <script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">
        var password = false;
        var confirm = false;

        $(function(){
            $(":password").css("width","200px");
            $(":password").css("height","30px");

            $("#reset").click(function(){
                $(":password:eq(1)").next().css("color","red").html("")
                $(":password:eq(2)").next().css("color","red").html("")
            })


            $(":password:eq(1)").blur(function(){
                password_();
                confirm_();
            })
            //确认密码
            $(":password:eq(2)").blur(function(){
                password_();
                confirm_();
            })

            $("#update").click(function(){
                if(password && confirm ){
                    $data = {
                        oldPwd:$(":password:eq(0)").val(),
                        newPwd:$(":password:eq(1)").val()
                    }
                    $.post("update_password_",$data,function(data){
                        if(data=="200"){
                            alert("修改成功");
                            window.location.href = window.location.href;
                        }else if(data=="401"){
                            alert("密码错误");
                        }else{
                            alert("服务器繁忙，错误代码"+data);
                        }
                    })
                }else{
                    alert("请正确填写信息");
                }
            });
        })

        function password_(){
            if(!$(":password:eq(1)").val().match(/^\w{6,12}$/)){
                $(":password:eq(1)").next().css("color","red").html("×")
                password = false;
            }else{
                $(":password:eq(1)").next().css("color","green").html("√")
                password = true;
            }
        }

        function confirm_(){
            if($(":password:eq(2)").val()=="" || $(":password:eq(2)").val()!=$(":password:eq(1)").val()){
                $(":password:eq(2)").next().css("color","red").html("×")
                confirm = false;
            }else{
                $(":password:eq(2)").next().css("color","green").html("√")
                confirm  = true;
            }
        }
    </script>
</head>
<body>
<div class="upd_div">
    <form class="" action="index.html" method="post">
        <table class="form_table">
            <tr>
                <td>原始密码</td>
                <td><input type="password" name="old_password" value=""><span></span></td>
            </tr>
            <tr>
                <td>新密码</td>
                <td><input type="password" name="new_password" value=""><span></span></td>
            </tr>
            <tr>
                <td>确认密码</td>
                <td><input type="password" name="confirm" value=""><span></span></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <button id="reset" type="reset" name="button">清空</button>
                    <button id="update" type="button" name="button">修改</button>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
