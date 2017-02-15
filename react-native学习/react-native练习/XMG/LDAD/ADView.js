/**
 * Created by yh on 16/7/20.
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Image,
    ScrollView,
} from 'react-native';

const Dimensions = require('Dimensions');
const {width,height,scale} = Dimensions.get('window');
// 引入计时器类库
var TimerMixin = require('react-timer-mixin');

const images = require('./ImageData.json').data;

export default class ADView extends Component {

    // 注册计时器,这个有毛用,据说是可以控制好定时器的内存
    mixins:[TimerMixin]

    // 构造
    constructor(props) {
        super(props);
        // 初始状态
        this.state = {
            currentIndex:0,
        };
    }

    render() {
        return (
            <View style={[styles.container]}>
                <ScrollView
                    showsHorizontalScrollIndicator={false}
                    showsVerticalScrollIndicator={false}
                    horizontal={true}
                    pagingEnabled={true}
                    ref='scrollView'
                    onMomentumScrollEnd = {(e)=>this.endScroll(e)}
                    onScrollBeginDrag = {this.beginDrag}
                    onScrollEndDrag = {this.endDrag}
                >
                    {this.getImages()}
                </ScrollView>
                <View style = {[styles.desView]}>
                    {this.getIndicator()}
                </View>
            </View>
        );
    }
    //scrollView的几个代理方法
    endDrag = ()=>{
        this.startTimer();
    }
    beginDrag = ()=>{
        this.stopTimer();
    }
    endScroll = (e)=>{
        let offsetX = e.nativeEvent.contentOffset.x / width;
        let index = Math.floor(offsetX);
        this.setState({
            currentIndex:index,
        });
    }
    componentDidMount() {
        this.startTimer();
    }

    //定时器的开关方法
    startTimer = ()=>{
        let self = this
        let count = images.length;
        clearInterval(this.timer);
        this.timer = setInterval(function () {
            let nextIndex = self.state.currentIndex + 1;
            if (nextIndex >= images.length){
                nextIndex = 0;
            }
            self.scrollToIndex(nextIndex)
        },1000)
    }
    stopTimer = ()=>{
        this.timer && clearInterval(this.timer);
    }

    //for循环获取   指示小点  和 轮播图片
    getIndicator = ()=>{
        let indicator = []
        for (let i = 0;i < images.length;i++){
            let styleString = (this.state.currentIndex === i) ? {color:'blue'} : {color:'red'};
            indicator.push(
                <Text key={i} style={[styleString,{fontSize:22}]} onPress={this.dotClick.bind(this,i)}>  &bull;</Text>
            );
        }
        return indicator;
    }
    //------dot被点击
    dotClick = (i)=> {
        //在setTimeout方法里面的函数,调用this并不指向这个类 LDAD
        let self = this
        this.stopTimer()
        this.timerOut = setTimeout(function(){
            self.startTimer();
            clearTimeout(self.timerOut);
        },1000)
        this.scrollToIndex(i)
    }
    getImages = ()=> {
        let imageItem = [];
        for (let i = 0; i < images.length; i++) {
            //这个数据没用到,拼接字符串后会报错,不明白
            let imageString = images[i].img;
            switch (i) {
                case 0:
                    imageItem.push(
                        <Image style={[styles.image]} key={i} source={require('./img/img_01.png')}/>
                    );
                    break
                case 1:
                    imageItem.push(
                        <Image style={[styles.image]} key={i} source={require('./img/img_02.png')}/>
                    );
                    break
                case 2:
                    imageItem.push(
                        <Image style={[styles.image]} key={i} source={require('./img/img_03.png')}/>
                    );
                    break
                case 3:
                    imageItem.push(
                        <Image style={[styles.image]} key={i} source={require('./img/img_04.png')}/>
                    );
                    break
                case 4:
                    imageItem.push(
                        <Image style={[styles.image]} key={i} source={require('./img/img_05.png')}/>
                    );
                    break
                default:
                    break
            }
        }
        return imageItem;
    }
    //scrollview移动到指定index
    scrollToIndex = (index)=>{
        let scrollView = this.refs.scrollView;
        let offset = index * width;
        scrollView.scrollResponderScrollTo({x:offset,y:0,animated:true})
        this.setState({
            currentIndex:index,
        });
    }

}

const styles = StyleSheet.create({
    container: {
        marginTop: 20,
    },
    image: {
        width: width,
        height: 150,
    },
    desView:{
        width:width,
        height:30,
        backgroundColor:'rgba(0,0,0,0.4)',
        position:'absolute',
        bottom:0,
        flexDirection:'row',
        alignItems:'center',
    },

});

