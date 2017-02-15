/**
 * Created by ld on 16/10/12.
 */
//var para=document.createElement("div");
//para.style.backgroundColor = 'red';
//para.style.width = 100;
//para.style.height = 100;
//
//var element=document.getElementById("container");
//element.appendChild(para);



//var para=document.createElement("p");
//var node=document.createTextNode("这是新段落。");
//para.appendChild(node);
//para.style.display = 'inline-block';
//para.style.width = 100;
//para.style.height = 100;
//para.style.backgroundColor="red";
//var element=document.getElementById("container");
//element.appendChild(para);


var div=document.createElement("div");
div.id = 'subContainer';
div.style.width = '500px';
div.style.height = '500px';
div.style.marginTop = '20px';
div.style.display = 'inline-block';
div.style.textAlign = 'left';
div.style.backgroundColor="red";
var element=document.getElementById("container");
element.appendChild(div);

for(i = 0;i < 30;i ++){
    var div1 = document.createElement('div');
    div1.id = 'subContainer';
    div1.style.width = '60px';
    div1.style.height = '60px';
    div1.style.display = 'inline-block';
    div1.style.backgroundColor="yellow";
    div1.style.margin = '10px';
    div1.style.textAlign = 'center';

    var para=document.createElement("p");
    var node=document.createTextNode("itemitemitemitemitem" + i);
    para.style.lineHeight = '60px';
    para.style.width = '60px';
    para.style.height = '60px';
    para.appendChild(node);
    div1.appendChild(para)

    var divGet = document.getElementById('subContainer');
    divGet.appendChild(div1);
}
