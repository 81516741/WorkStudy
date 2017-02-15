/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
    AsyncStorage,
    ScrollView,
  View
} from 'react-native';

import GoodsItem from './GoodsItem.js';
import Dimensions from 'Dimensions';

const Width = Dimensions.get('window').width;
const Height = Dimensions.get('window').height;
export default class GoodsList extends Component{

    constructor(props){
        super(props);
        this.state = {
            count:0,
        }
    }



    myClick = function(i){
        this.props.press();
        let data = this.props.Model[i];
        AsyncStorage.setItem('SP-' + this.genId() + '-SP', JSON.stringify(data), function (err) {
            if (err) {
                //TODO：存储出错
                alert(err);
            } else {
                alert('保存成功');
            }
        });
        this.setState({
            count:this.state.count +1,
        });
    }


    //生成随机ID：GUID 全局唯一标识符（GUID，Globally Unique Identifier）是一种由算法生成的二进制长度为128位的数字标识符
    //GUID生成的代码来自于Stoyan Stefanov
    genId() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
            let r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
            return v.toString(16);
        }).toUpperCase();
    }


    payClick=()=>{
        const {navigator} = this.props;
        if(navigator){
            navigator.push({
                    name: 'Detail',
                    component: Detail,
            }
            );
        }
    }

    clearGoods=()=>{
        let _that = this;
        AsyncStorage.clear(
            function(err){
                if(err){
                    alert(err);
                    return;
                }else{
                    alert('清空数据成功');

                    _that.setState({
                        count:0,
                    });
                }
            }

        );
    }

    componentDidMount() {
        let _that = this;




        AsyncStorage.getAllKeys(
            function (err, keys) {
                if (err) {
                    //TODO:存储取数据出错
                    //给用户提示错误信息
                    console.log(err);
                } else {
                    alert('读取数据成功：'+keys.toString());
                }
                _that.setState({

                    count: keys.length,
                });
            }
        );
    }

    render(){

        let list = [];
        for(let i in this.props.Model){
            if(i%2==0){
                let length = this.props.Model.length;
                let url1 = this.props.Model[i].url;
                let title1 = this.props.Model[i].title;
                let nextItem ;
                //因为i是从0开始的
                if((parseInt(i)+1) <= length - 1){
                    let url2 = this.props.Model[parseInt(i)+1].url;
                    let title2 = this.props.Model[parseInt(i)+1].title;
                    nextItem =
                        <GoodsItem url={url2} title={title2} press={this.myClick.bind(this,parseInt(i)+1)}/>;
                }else{
                    nextItem = <View style={styles.size}/>;
                }
                let item = (
                    <View key = {i} style = {[styles.row]} >
                        <GoodsItem url={url1} title={title1} press={this.myClick.bind(this,i)}/>
                        {nextItem}
                    </View>
                    );
                list.push(item);
            }

        }

        return(
            <ScrollView>
                {list}
                <View style={styles.center}>
                    <View style = {[styles.button,styles.margin,styles.center]}>
                        <Text style = {styles.text} onPress = {this.payClick}>点击支付</Text>
                    </View>
                    <View style = {[styles.button,styles.margin,styles.center]}>
                        <Text style = {styles.text}>当前数量:{this.state.count}</Text>
                    </View>
                    <View style = {[styles.button,styles.margin,styles.center]}>
                        <Text style = {styles.text} onPress={this.clearGoods}>清空商品</Text>
                    </View>
                </View>
            </ScrollView>

            );
    }
}

class Detail extends Component{

    constructor(props){
        super(props);
        this.state = {
          data:'不要怕哦'
        };
    }



    back=()=>{
        let {navigator} = this.props;
        navigator.pop();
    }

    componentDidMount() {
        let _that = this;
        AsyncStorage.getAllKeys(
            function (err, keys) {
                if (err) {
                    //TODO 存储数据出错
                    alert(err)
                    return;
                }
                //keys是字符串数组
                AsyncStorage.multiGet(keys, function (err, result) {
                    //得到的结构是二维数组
                    //result[i][0]表示我们存储的键   result[i][1]表示我们存储的值
                    let arr = [];
                    for (let i in result) {
                        arr.push(JSON.parse(result[i][1]));
                    }
                    alert(arr)
                    _that.setState(
                        {

                            data: arr,
                        }
                    );


                });
            }
        );
    }

    render(){
        let data = this.state.data;
        let price = 0.0;
        let str ='暂无商品';
        if(data){
            for(let i in data){
                price += parseFloat(data[i].price);
            }
            str = '商品的总价格：'+price;
        }

        return (
            <View style={[styles.flex,styles.center]}>
                <Text onPress={this.back} style={[styles.text]}>{str}</Text>
            </View>
            );
    }



}

const styles = StyleSheet.create({
    flex:{
        flex:1,
    },
    row:{
        flexDirection:'row',
    },
    size:{
        width:Width * 0.4,
        height:Width * 0.4,
        margin:Width * 0.05,
    },
    center:{
        alignItems:'center',
        justifyContent:'center',
    },
    margin:{
        marginTop:10,
    },
    button:{
        width:Width * 0.8,
        height:44,
        backgroundColor:'blue',
    },
    text:{

        fontSize:24,
        color:'gray',
        fontWeight:'bold',
    }

});


