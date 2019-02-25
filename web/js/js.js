
function open_mb(url){
    $(".black_over").css("display","block");
    $(".white_content").slideDown(200);
    $(".white_content").children("div").load(url);
}

function close_mb(){
    $(".black_over").css("display","none");
    $(".white_content").slideUp(200);
}

function refresh_verification_code(){
    //浏览器有缓存，不会多次请求相同数据
    $(".verification_code_img").attr("src","verification_code?data="+new Date());
}

function openwindow(html)
{
    return window.open(html,'newindow','height=400,width=600,top=300,left=800,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');

}