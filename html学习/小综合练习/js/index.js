/**
 * Created by yh on 16/5/26.
 */

function $(id){
    return typeof id === 'string' ? document.getElementById(id) : id;
}

window.onload = function(){

    var titles = $('tabheader').getElementsByTagName('li');
    var divs = $('tabcontent').getElementsByClassName('dom');
    if(titles.length != divs.length) return;

    for(var i = 0;i < titles.length;i++){
        var li = titles[i];
        li.id = i;
        li.onmouseover = function(){
            for(var j = 0;j < titles.length;j++){
                titles[j].className = '';
                divs[j].style.display = 'none';
            }
            this.className = 'seleted';
            divs[this.id].style.display = 'block';
        }

    }

}