<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: HUIHUI
  Date: 2019/1/11
  Time: 19:58
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
        $(function(){

            $("#reset").click(function(){
                location=location;
            });

            $("#update").click(function(){
                var $data = $("#update_message_form").serialize();
                $.post("update_message_",$data,function(data){
                    if(data==200){
                        alert("修改成功");
                        location = location;
                    }else if(data==501){
                        alert("格式错误");
                    }else{
                        alert("系统繁忙，错误代码"+data);
                    }
                });
            });

            var birth = "${user.birth}";
            if(birth!=""){
                var date = birth.split("-");
                $("#year").val(date[0]);
                $("#month").val(date[1]);
                $("#day").val(date[2]);
            }

        })
    </script>
</head>
<body>
<div class="upd_div">
    <form id="update_message_form" action="index.html" method="post">
        <table class="form_table">
            <tr>
                <td>昵称:</td>
                <td><input type="text" name="nickname" value="${user.nickname}" style="height: 30px;width: 200px"></td>
            </tr>
            <tr>
                <td>性别：</td>
                <td>
                    <select class="sel" name="sex" style="height: 30px;width: 50px">
                        <option value="0" <c:if test="${user.sex==0}">selected="selected"</c:if>>男</option>
                        <option value="1" <c:if test="${user.sex==1}">selected="selected"</c:if>>女</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>出生年月：</td>
                <td><input id="year" type="text" name="year" style="height: 25px;width: 50px">年<input id="month" type="text" name="month" style="height: 25px;width: 30px">月<input id="day" type="text" name="day" style="height: 25px;width: 30px">日</td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <button id="reset" type="reset" name="button">返回</button>
                    <button id="update" type="button" name="button">确认</button>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
