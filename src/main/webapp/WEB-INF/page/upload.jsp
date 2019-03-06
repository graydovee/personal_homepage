<%--
  Created by IntelliJ IDEA.
  User: HUIHUI
  Date: 2019/2/11
  Time: 23:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>upload</title>
    <link rel="stylesheet" href="css/decorator.css">
    <script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
    <script>
        $(function(){

            $("#submit_btn").click(function () {

                $(".black_over").css("display","block");
                var file_obj = document.getElementById('file').files[0];

                var fd = new FormData();
                fd.append('file', file_obj);

                $.ajax({
                    url:'upload_file_',
                    type:'POST',
                    data:fd,
                    processData:false,  //tell jQuery not to process the data
                    contentType: false,  //tell jQuery not to set contentType

                    success:function (data) {
                        if(data==200){
                            alert("上传成功");
                        }else{
                            alert("上传失败");
                        }
                        window.opener.location.reload();
                        window.close();
                    }

                });
            });

            window.setInterval(function(){
                time_count=(time_count+1)%2;
                if(time_count==0){
                    $(".wait").html('文件正在上传中...<br />请不要关闭此窗口')
                }else{
                    $(".wait").html('文件正在上传中..<br />请不要关闭此窗口')
                }
            },1000);
        })
        var time_count = 0;
    </script>
</head>
<body>
<div id="upload_button_div">
    <form>
    <input id="file" type="file" name="file"><br>
    <input id="submit_btn" type="button" value="确认上传">
    </form>
</div>
<div class="black_over">
    <p class="wait"></p>
</div>
</body>
</html>
