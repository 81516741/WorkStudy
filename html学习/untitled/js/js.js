/**
 * Created by yh on 16/6/12.
 */
document.getElementById('js').innerHTML = 'ios你好'
document.write('<h3>这是用js写进来的</h3>')
function myClickFunc()
{
    document.write('不要惊讶，说了叫你不要点击的啊')
    console.log('来了吗')
}
function changenextworld()
{
    var valueWorld = '现在知道js的强大了吧,哈哈哈'
    document.getElementById('nilp').innerHTML = valueWorld;

    var arr = new Array(1,2,3)
    var arr = [1,2,3,4,5,6]
    for(i = 0;i<arr.length;i++) {
        console.log(arr[i])
    }
    var dic = {'name':'linda','address':'guanzhuang'}
    console.log(dic.name)
    console.log(dic['address'])

    var world = 'ni zai na li'
    console.log(world.toUpperCase());

    console.log('2+3的和是：'+ add(2,3));

    console.log('===的尝试'+ (2=='2'));
    forFunc(['nihao','wohenhao','zailaiyige ']);

}

function add(x1,x2)
{
    return x1 + x2;
}

function equalsBoth(x1,x2)
{
    return x1===x2;
}

function forFunc(arr)
{
    for (a in arr)
    {
        document.write(arr[a] + '<br>');
    }
    for(var i = 0;i < arr.length;i++)
    {
        document.write(arr[i]+'<br>');
    }
}