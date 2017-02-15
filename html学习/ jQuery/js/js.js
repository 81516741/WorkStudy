/**
 * Created by ld on 16/10/10.
 */
$(document).ready(function(){
    //$("button").click(function(){
    //    $("p").toggle("slow",function(){
    //        $(this).slideDown();
    //        //$(this).animated({left:'100px'});
    //    });
    //})
    $(document).ready(function(){
        $("button").click(function(){
            $("p").animate({left:'250px'});
        });
    });
});
$("#button1").click(function(){
    $("#pp").val("这是用jq修改的");
});

$(document).ready(function(){

})

$("#size").click(function(){
   var x = "";
    x = x + "宽度是:" + $("#divSize").width() + "<br>" +"高度是:" + $("#divSize").height();
    $("#divSize").html(x);
});
