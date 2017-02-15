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
    ViewPagerAndroid,
    Navigator,
    Image,
    Platform,
    BackAndroid,
    ToastAndroid,
  View
} from 'react-native';


import Button from './Button'
import ProgressBar from './ProgressBar'
import Group from './Group'
import HomeUI from './HomeUI'

import Dimensions from 'Dimensions';
const Width = Dimensions.get('window').width;
const Height = Dimensions.get('window').height;

const IMAGE_URIS=[
  'http://apod.nasa.gov/apod/image/1410/20141008tleBaldridge001h990.jpg',
  'http://apod.nasa.gov/apod/image/1409/volcanicpillar_vetter_960.jpg',
  'http://apod.nasa.gov/apod/image/1409/m27_snyder_960.jpg',
  'http://apod.nasa.gov/apod/image/1409/PupAmulti_rot0.jpg',
];

class MainUI extends Component {

      constructor(props){
        super(props);
        this.state={
          progressCount:4,
          progressIndex:1,
          anima:true,
        };
      }

      switchAnima=()=>{
        this.setState({
            anima:!this.state.anima
         });
      }
      next=()=>{
        let index = this.state.progressIndex + 1;
        this.setState({
          progressIndex:index,
          });
        this.go(index);
      }


      pre=()=>{
        let index = this.state.progressIndex - 1;
        this.setState({
          progressIndex:index,
        });
       this.go(index);
      }

      startPosition=()=>{
        this.setState({
          progressIndex:0,
        });
        this.go(1);
      }
      endPosition=()=>{
        this.setState({
          progressIndex:IMAGE_URIS.length,
        });
        this.go(IMAGE_URIS.length);
      }

    go=(progressIndex)=>{
      if(this.state.anima){
        this.viewPager.setPage(progressIndex - 1);
      }else{
        this.viewPager.setPageWithoutAnimation(progressIndex - 1);
      }
      //刷新了
      this.setState({progressIndex});
    }

    backHome = ()=>{
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
    render() {
      let items = [];
      for(let i in IMAGE_URIS){
        let uri = IMAGE_URIS[i];
        if(i != IMAGE_URIS.length - 1){
          items.push(<Group uri={uri} key={i} />);
        }else {
          items.push(
              <View key ={i} >
                  <Group uri={uri} />
                  <View style={[styles.backButtonUI]}>
                    <Text onPress = {this.backHome} style={[styles.text]}>回到首页</Text>
                  </View>
              </View>
          );
        }
      }
      let preState ;
      let nextState;
      if(this.state.progressIndex != IMAGE_URIS.length){
        nextState = true;
      }else {
        nextState = false;
      }

      if (this.state.progressIndex != 1){
        preState = true;
      }else {
        preState = false;
      }

      let animaWorlds = this.state.anima ? '动画' :'不动画'
      return (
          <View style={{backgroundColor:'green',flex:1,}}>


              <ViewPagerAndroid
                style={styles.viewPager}
                initialPage={0}
                onPageScroll={this.onPageScroll}
                onPageSelected={this.onPageSelected}
                ref={viewPager => { this.viewPager = viewPager; }}>
                {items}
              </ViewPagerAndroid>
              <View style={styles.bottomUI}>
                <Button worlds={animaWorlds} enable={true} width={Width - 10} height={20} press={this.switchAnima}/>
                <View style={[styles.row,styles.center]}>
                  <Button worlds={'起始'} enable={preState} width={36} height={18} press={this.startPosition}/>
                  <Button worlds={'上翻'} enable={preState} width={36} height={18} press={this.pre}/>
                  <Text>页: {this.state.progressIndex}/{IMAGE_URIS.length} </Text>
                  <ProgressBar width={100} height={18} count={this.state.progressCount} index={this.state.progressIndex}/>
                  <Button worlds={'下翻'} enable={nextState} width={36} height={18} press={this.next} />
                  <Button worlds={'末尾'} enable={nextState} width={36} height={18} press={this.endPosition}/>
                </View>

              </View>

          </View>
    );
    }
}

export default class App extends Component {

    componentWillMount() {
        if (Platform.OS === 'android') {
            BackAndroid.addEventListener('hardwareBackPress', this.onBackAndroid);
            // BackAndroid.addEventListener('sss',this.onBackAndroid,true);
        }
    }
    componentWillUnmount() {
        if (Platform.OS === 'android') {
            BackAndroid.removeEventListener('hardwareBackPress', this.onBackAndroid);
        }
    }

    onBackAndroid = () => {
        const navigator = this.refs.navigator;
        const routers = navigator.getCurrentRoutes();
        console.log('当前路由长度：' + routers.length);
        if (routers.length > 1) {
            navigator.pop();
            return true;//接管默认行为
        } else {

            //到了主页了
            if (this.lastBackPressed && this.lastBackPressed + 2000 >= Date.now()) {
                //最近2秒内按过back键，可以退出应用。
                return false;
            }
            this.lastBackPressed = Date.now();
            ToastAndroid.show('再按一次退出应用', ToastAndroid.SHORT);
            return true;
        }
        // return false;//默认行为

    };


    render() {

    let defaultName='MainUI';
    let defaultComponent=MainUI;
    return (
        <Navigator
    initialRoute={{ name: defaultName, component: defaultComponent }}
    ref="navigator"
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


//<ProgressBar height={12} width={100} count={this.state.progressCount} index={this.state.progressIndex}/>
//<Text onPress={this._move}>点击我</Text>
//<Button width={60} font={18} press={this._move} enable={true}/>

const styles = StyleSheet.create({
    backButtonUI: {
      borderColor: 'yellow',
      backgroundColor: 'rgba(24,124,222,0.3)',
      borderWidth: 2,
      borderRadius: 5,
      width: 100,
      height: 44,
      justifyContent: 'center',
      alignItems: 'center',
      alignSelf: 'center',
      marginBottom:50,
    },
    text:{
      fontSize:18,
      color:'white',
      fontWeight:'bold',
    },
    marginBottom:{
      marginBottom:50,
    },
    bottomUI:{
      backgroundColor:'rgb(24,124,201)',
      opacity:0.5,
      height:52,
    },
  flex:{
    flex:1,
  },
  viewPager: {
    flex: 1,
  },
  row:{

    flexDirection:'row',
  },
  center:{
    alignItems:'center',
  },
  centerObj:{
    alignItems:'center',
    justifyContent:'center',
    alignSelf:'center',
  },

});
