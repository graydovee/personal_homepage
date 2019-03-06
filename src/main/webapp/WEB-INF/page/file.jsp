<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>file</title>
    <link rel="stylesheet" href="css/decorator.css">
    <script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
    <script>
        $(function () {
            $("#upload_file").click(function(){
                openwindow('upload');
            });


        });



        function delete_file(obj){
            var $data = {
                uuid:obj.getAttribute('uuid')
            }
            $.post("delete_file_",$data,function(data){
                if(data==200){
                    alert('删除成功');
                    $(obj).parent().parent().parent().remove();
                }else{
                    alert('删除失败');
                }
            })
        }

    </script>
    <style>
        table{
            table-layout:fixed;
        }
        .table_div{
            overflow: hidden;text-overflow:ellipsis; word-break:keep-all;white-space:nowrap
        }
    </style>
</head>
<body>
<div class="table" >
    <table>
        <tr>
            <th>文件名</th>
            <th>下载次数</th>
            <th>操作</th>
        </tr>
        <%--<tr>--%>
            <%--<td>aaa.jpg</td>--%>
            <%--<td>0</td>--%>
            <%--<td><a href="#">下载</a>&nbsp;&nbsp;&nbsp;<a href="#">删除</a></td>--%>
        <%--</tr>--%>
        <c:forEach items="${user.files}" var="file">
        <tr>
            <td title="${file.name}"><div class="table_div" style="width: 200px;"><a class="a_" href="download_?uuid=${file.uuid}&fileName=${file.name}">${file.name}</a></div></td>
            <td><div class="table_div" style="width: 80px">${file.count}</div></td>
            <td><div class="table_div" style="width: 120px"><button class="button_" onclick="delete_file(this)" uuid="${file.uuid}">删除</button></div></td>
        </tr>
        </c:forEach>
    </table>
</div>
<div id="upload">
    <button id="upload_file">上传文件</button>
</div>
</body>
</html>
