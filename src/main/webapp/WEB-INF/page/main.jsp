<%--
  Created by IntelliJ IDEA.
  User: HUIHUI
  Date: 2019/1/10
  Time: 13:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="css/decorator.css"/>
    <title>index</title>
    <script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="js/js.js"></script>
    <script type="text/javascript">
        $(function(){
            $("#baidu").click(function(){
                $("#search_form").submit();
            });

            $("#add_web").click(function(){
                show_add_box();
            })

            $("#del_web").click(function(){
                open_mb("del_website");
            });

            $("#web_confirm").click(function () {
                var txt1 = $("#url").val();
                var txt2 = $("#name").val();
                if("" != txt1 || txt2!=""){
                    $data = $("#insWeb").serialize();
                    $.post('add_website_',$data,function(data){
                        if(data==200){
                            alert("新增成功");
                            location.href=location.href;
                        }else if(data==300){
                            alert('请先登录');
                        }else{
                            alert('服务器繁忙');
                        }
                    });
                }else{
                    alert("请完整填写信息");
                }
            })
        })

        function show_add_box() {
            $(".add_form").slideToggle(100);
            $("#del_web").slideToggle(100);
            $("#web_confirm").slideToggle(100);
        }

        function openWebsite(url){
            window.open("open_new_page?url="+url);
        }
    </script>
</head>
<body>
<div id="baidu_logo_div">
    <a href="https://www.baidu.com/s" target="_blank"><img src="img/baidu_logo.png" id="baidu_logo"></a>
</div>
<div id="search">
    <form id="search_form" action="https://www.baidu.com/s">
        <input  id="search_input" type="text" name="wd"/>
        <div class="search_btn" id="baidu" ><p>百度一下<p></div>
    </form>
</div>
<div id="myweb">

    <c:if test="${user != null}">
    <hr style="position: absolute;width:70%;top:8%;">
    <div style="position: absolute;top:0%;color:#2319DC;">常用网站:</div>
    <div class="add_form" style="width: 300px;height: 100px;position: absolute;border: 1px solid black;padding: 10px;right:20%;top:-100px;background-color: white;display: none">
        <form id="insWeb">
            <table>
                <tr>
                    <td style="font-size: 16px">地址:</td>
                    <td><input id="url" type="text" name="url"></td>
                </tr>
                <tr>
                    <td style="font-size: 16px">名称:</td>
                    <td><input id="name" type="text" name="name"></td>
                </tr>
            </table>
        </form>
    </div>
    <div id="add_web" class="search_btn ">新增</div>
    <div id="del_web" class="search_btn ">编辑</div>
    <div id="web_confirm" class="search_btn ">确认</div>
    <table style="width: 80%">
        <%
            int count = 0;
            out.write("<tr>");
        %>
        <c:forEach items="${user.websites}" var="website">

            <%
                ++count;
                if(count != 0 && count%5==0){
                    out.write("</tr>");
                    out.write("<tr>");
                }
            %>
            <td><a href="javascript:void(0);" onclick="openWebsite('${website.url}')" target="_blank" >${website.name}</a></td>
        </c:forEach>
        <%
            out.write("</tr>");
        %>
    </table>
    </c:if>
</div>
</body>
</html>
