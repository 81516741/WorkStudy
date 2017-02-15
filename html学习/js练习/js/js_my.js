/**
 * Created by yh on 16/5/25.
 */
var image = document.getElementsByTagName('img')[0]
var next = document.getElementsByTagName('button')[0]
var pre = document.getElementsByTagName('button')[1]
image.style.display = 'block';
image.style.width = '100px'
image.style.height = '100px'
var i = 1;
function nextfun(){
    if(i==7) {
        i = 0;
    }
    i++;
    image.src = 'images/00'+i+'.jpg';
    console.log('images/00'+i+'.jpg'+'---------')
}
function prefun(){
    if(i==1){
        i = 8;
    }
    i--;
    image.src = 'images/00'+i+'.jpg';
    console.log('images/00'+i+'.jpg'+'---------')
}

document.write('<p>这是2个p标签下面也有个p标签，待会我会删1个，另一个修成成我的名字</p>');
document.write('<p id="delete">这是一个要删除的p标签</p>');
document.write('<p id ="change">这是要修改的标签</p>');
document.write('<p id ="change1">这是要修改的标签</p>');
document.write('<p id ="change2">这是要修改的标签</p>');

var btn = document.createElement('button')
var needchange = document.getElementById('change')
console.log(btn)
btn.innerHTML='我是btn';
needchange.appendChild(btn)


var needdelete = document.getElementById('delete');
//needdelete.remove();
needdelete.parentNode.removeChild(needdelete)


var needchange1 = document.getElementById('change1');
needchange1.innerText='我已经被改变了';





