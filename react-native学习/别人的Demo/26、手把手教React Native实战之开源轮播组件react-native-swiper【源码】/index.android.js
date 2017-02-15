/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    Image,
    TouchableOpacity,
    ViewPagerAndroid,
    Navigator,
    View
    } from 'react-native';

import LikeCount from './LikeCount.js';//导入喜欢数 组件
import Button from './Button.js';//导入 自定义的按钮的 组件
import HomeUI from './HomeUI.js';//导入 首页 组件

const PAGES=5;

const BGCOLOR=['#fdc08e', '#fff6b9', '#99d1b7', '#dde5fe', '#f79273'];

const IMAGE_URIS=[
  'http://apod.nasa.gov/apod/image/1410/20141008tleBaldridge001h990.jpg',
  'http://apod.nasa.gov/apod/image/1409/volcanicpillar_vetter_960.jpg',
  'http://apod.nasa.gov/apod/image/1409/m27_snyder_960.jpg',
  'http://apod.nasa.gov/apod/image/1409/PupAmulti_rot0.jpg',
  'https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png',
];


class ProgressBar extends Component{
  //进度条组件
  constructor(props) {
    super(props);

  }
  render(){
    //当前位置+偏移量
    var fractionalPosition = (this.props.progress.position + this.props.progress.offset);

    var progressBarSize = (fractionalPosition / (PAGES - 1)) * this.props.size;
    return(
      //这进度条 2个view搞定了 通过宽度来区别
      //progressBarSize当前的进度
      //this.props.size总共的大小 或者 是进度的长度
        <View style={[styles.progressBarContainer, {width: this.props.size}]}>

          <View style={[styles.progressBar, {width: progressBarSize}]}/>

        </View>
    );
  }
}




class WelcomeUI extends Component {
  //引导页 或者 欢迎界面  用viewpager实现

  //null is not an object 解决办法：初始化的时候要用constructor 而不是getInitialState
  //current using ES6 as standart programming.

  //to initial state you must create cnostructor in your react component class

  //用构造函数来替代之前的 Initial实例化

  constructor(props) {
    super(props);
    this.state = {
      page: 0,
      animationsAreEnabled: true,//动画是否开启
      progress: {
        position: 0,
        offset: 0,
      },
    };

    //undefined is not a function (evaluating
    //React components using ES6 classes no longer autobind this to non React methods

    //this.setState=this.setState.bind(this);


  }



  //getInitialState(){
  //  return {
  //    page: 0,
  //    animationsAreEnabled: true,
  //    progress: {
  //      position: 0,
  //      offset: 0,
  //    },
  //  };
  //}



  onPageSelected=(e)=>{
    //这个回调会在页面切换完成后（当用户在页面间滑动）调用
    //回调参数中的event.nativeEvent对象
    this.setState({page:e.nativeEvent.position});
  }




  //onPageScroll(e){
  //  //当在页间切换时（不论是由于动画还是由于用户在页间滑动/拖拽）执行。
  //  this.setState({progress:e.nativeEvent});
  //}

  //See React on ES6+
  onPageScroll=(e)=>{
    //当在页间切换时（不论是由于动画还是由于用户在页间滑动/拖拽）执行。

//    回调参数中的event.nativeEvent对象会包含如下数据：
//
//position 从左数起第一个当前可见的页面的下标。
//
//offset 一个在[0,1)（大于等于0，小于1）之间的范围，代表当前页面切换的状态。值x表示现在"position"所表示的页有(1 - x)的部分可见，而下一页有x的部分可见。
    this.setState({progress:e.nativeEvent});
  }


  move(delta){
    var page=this.state.page+delta;
    this.go(page);
  }


  go(page){
    if(this.state.animationsAreEnabled){
      this.viewPager.setPage(page);
    }else{
      this.viewPager.setPageWithoutAnimation(page);
    }
    //刷新了
    this.setState({page});
  }

  onClick=()=>{
    //alert('点击了');
    const { navigator } = this.props;
    //为什么这里可以取得 props.navigator?请看上文:
    //<Component {...route.params} navigator={navigator} />
    //这里传递了navigator作为props
    if(navigator) {
      navigator.push({
        name: 'HomeUI',
        component: HomeUI,
      })
    }
  }

  render(){
    const thunbsUp='\uD83D\uDC4D';
    var pages=[];
    for(var i=0;i<PAGES;i++){
      var pageStyle = {
        backgroundColor: BGCOLOR[i % BGCOLOR.length],
        alignItems: 'center',
        padding: 20,
      };
      if(i<PAGES-1){
        //前面几个viewpage

        //collapsable 如果一个View只用于布局它的子组件，
        // 则它可能会为了优化而从原生布局树中移除。 把此属性设为false可以禁用这个优化，以确保对应视图在原生结构中存在。
        pages.push(
            <View key={i} style={pageStyle} collapsable={false}>
              <Image
                  style={styles.image}
                  source={{uri: IMAGE_URIS[i % BGCOLOR.length]}}
                  />
              <LikeCount />
            </View>
        );
      }else{
        //最后一个viewpage 加了一个按钮
        pages.push(
            <View key={i} style={pageStyle} collapsable={false}>
              <Image
                  style={styles.image}
                  source={{uri: IMAGE_URIS[i % BGCOLOR.length]}}
                  />
              <LikeCount />


              <TouchableOpacity onPress={this.onClick} style={styles.startupButton}>
                <Text style={styles.likesText}>{thunbsUp+'启动首页'}</Text>

              </TouchableOpacity>
            </View>
        );
      }

    }

    var { page, animationsAreEnabled } = this.state;

    //var page=this.state.page;
    //var animationsAreEnabled=this.state.animationsAreEnabled;

    return (
        <View style={styles.container}>
          <ViewPagerAndroid
              style={styles.viewPager}
              initialPage={0}
              onPageScroll={this.onPageScroll}
              onPageSelected={this.onPageSelected}
              ref={viewPager => { this.viewPager = viewPager; }}>
            {pages}
          </ViewPagerAndroid>
          <View style={styles.buttons}>
            { animationsAreEnabled ?
                <Button
                    text="Turn off animations"
                    enabled={true}
                    onPress={() => this.setState({animationsAreEnabled: false})}
                    /> :
                <Button
                    text="Turn animations back on"
                    enabled={true}
                    onPress={() => this.setState({animationsAreEnabled: true})}
                    /> }
          </View>
          <View style={styles.buttons}>
            <Button text="Start" enabled={page > 0} onPress={() => this.go(0)}/>
            <Button text="Prev" enabled={page > 0} onPress={() => this.move(-1)}/>

            <Text style={styles.buttonText}>页：{page + 1} / {PAGES}</Text>
            <ProgressBar size={100} progress={this.state.progress}/>

            <Button text="Next" enabled={page < PAGES - 1} onPress={() => this.move(1)}/>
            <Button text="Last" enabled={page < PAGES - 1} onPress={() => this.go(PAGES - 1)}/>
          </View>
        </View>
    );
  }
}


class DfyProject01 extends Component {
  render() {
    let defaultName='WelcomeUI';
    let defaultComponent=WelcomeUI;
    return (
        <Navigator
            initialRoute={{ name: defaultName, component: defaultComponent }}
            //配置场景
            configureScene=
                {
            (route) => {

            //这个是页面之间跳转时候的动画，具体有哪些？可以看这个目录下，有源代码的: node_modules/react-native/Libraries/CustomComponents/Navigator/NavigatorSceneConfigs.js

            return Navigator.SceneConfigs.FloatFromRight;
          }
          }
            renderScene={
            (route, navigator) =>
             {
            let Component = route.component;
            return <Component {...route.params} navigator={navigator} />
          }
          } />


    );
  }
}

const styles = StyleSheet.create({
  buttons: {
    flexDirection: 'row',
    height: 30,
    backgroundColor: 'black',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  container: {
    flex: 1,
    backgroundColor: 'white',
  },
  image: {
    width: 300,
    height: 200,
    padding: 20,
  },

  startupButton:{
    backgroundColor: 'rgba(0, 0, 0, 0.1)',
    borderColor: '#333333',
    borderWidth: 1,
    borderRadius: 5,
    margin: 8,
    padding: 8,
  },


  progressBarContainer: {
    height: 10,
    margin: 10,
    borderColor: '#eeeeee',
    borderWidth: 2,
  },
  progressBar: {
    alignSelf: 'flex-start',
    flex: 1,
    backgroundColor: '#ff0000',
  },
  viewPager: {
    flex: 1,
  },
  buttonText: {
    color: 'white',
  },
});


AppRegistry.registerComponent('DfyProject01', () => DfyProject01);
