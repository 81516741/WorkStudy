/**
 * Created by ld on 16/10/19.
 */

function bridgeCall(src,callback) {
    iframe = document.createElement("iframe");
    iframe.style.display = "none";
    iframe.src = src;
    var cleanFn = function(state){
        console.log(state)
        try {
            iframe.parentNode.removeChild(iframe);
        } catch (error) {}
        if(callback) callback();
    };
    iframe.onload = cleanFn;
    document.documentElement.appendChild(iframe);
}

bridgeCall("bridge://myhtml");

document.getElementById('my_btn').onclick = function(){
    bridgeCall("bridge1://myhtml");
}

var ocMethod = function(){
    alert('原生还没赋予方法');
}

var ocMethod1 = function (){
    alert('这种方式是替换不了的');
    document.getElementById('oc_method').style.backgroundColor = 'red';
    
}
document.getElementById('oc_method').onclick = ocMethod1;
