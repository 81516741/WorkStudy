/**
 * Created by ld on 16/10/9.
 */

btn = document.getElementById('btnClick');
btn.onclick = btnClick;

function btnClick(){
    x = document.getElementById('h3');
    x.innerHTML = "<p>js变得</p>";
    x.style.color = 'red';
    car.tankuang = function tan(){
        alert('tankuang');
    };
    with (car){
        alert(name);
        alert(price);
    }
}

 car = {
    name:'宝马',
    price:'$10000000',
    qidong:function star(){
        alert('汽车发动');
    },

}

function diaoyong(){
    alert('diaoyong');

}

try {

}catch (error){

}