<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: HUIHUI
  Date: 2019/2/11
  Time: 0:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>del_website</title>
    <link rel="stylesheet" href="css/decorator.css">
    <script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
    <script>
        function delete_website($wid,obj){
            var $data = {
                wid:$wid
            }
            $.post('del_website_',$data,function(data){
                if(data==200){
                    alert('删除成功');
                    location.href = location.href;
                }else{
                    alert('系统繁忙，请稍后再试');
                }
            });
        }
    </script>
</head>
<body>

<div class="table">
    <table>
        <c:forEach items="${user.websites}" var="website">
            <tr>
                <td><div style="width: 200px">${website.name}</td>
                <td><div style="width: 80px"><button class="button_" onclick="delete_website(${website.wid},this)">删除</button></div></td>
            </tr>
        </c:forEach>

    </table>
</div>

</body>
</html>
