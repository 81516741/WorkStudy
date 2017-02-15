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
    Navigator,
    ListView,
    ActivityIndicator,
    View,
    Image,
    TextInput,
} from 'react-native';

var Dimensions = require('Dimensions');
var {width, height, scale} = Dimensions.get('window');

class LDQQLogin extends  Component{
  render() {
    return (
        <View style = {[style1.container]}>

          <Image source={require('./img/icon.png')}  style={[style1.icon]} />

          <TextInput placeholder={'请输账号'} style={[style1.input]}/>
          <TextInput placeholder={'请输入密码'}  password={true}  style={[style1.input]} />
          <View  style={[style1.loginBtn]}>
            <Text style={[{color:'white',fontSize:18}]}>登陆</Text>
          </View>
          <View style={[style1.proble]}>
            <Text style={{fontSize:15}}>无法登陆</Text>
            <Text style={{fontSize:15}}>新用户</Text>
          </View>

          <View style={[style1.otherLogin]}>
            <Text style={[{fontSize: 16}]}>其他登陆方式: </Text>
            <Image style={[style1.otherImg]} source={require('./img/icon3.png')}  />
            <Image style={[style1.otherImg]} source={require('./img/icon7.png')}  />
            <Image style={[style1.otherImg]} source={require('./img/icon8.png')}  />
          </View>
        </View>
    );
  }

}
const style1 = StyleSheet.create({
  container:{
    flex:1,
    alignItems:'center',
    backgroundColor:'rgba(0,0,0,0.2)'
  },
  icon:{
    width:100,
    height:100,
    borderWidth:2,
    borderColor:'rgba(255,255,255,1)',
    borderRadius:50,
    marginTop:50,
    marginBottom:50,
  },
  input:{
    marginTop:5,
    height:36,
    width:width - 40,
    backgroundColor:'white',
    // 内容居中
    textAlign:'center',
    fontSize:18,
    alignSelf:'center',

  },
  loginBtn:{
    backgroundColor:'blue',
    borderRadius:8,
    height:44,
    width:width * 0.8,
    alignItems:'center',
    justifyContent:'center',
    marginTop:20,
  },
  proble:{
    flexDirection:'row',
    width:width * 0.9,
    justifyContent:'space-between',
    marginTop:20,
  },
  otherLogin:{
    flexDirection:'row',
    width:width * 0.9,
    marginTop:10,
    alignItems:'center',
    justifyContent:'center',
    // 绝对定位
    position:'absolute',
    bottom:10,
    left:width * 0.05,
  },
  otherImg:{
    width:40,
    height:40,
    borderRadius:20,
    marginLeft:(1/scale) * 8,
  },

});

AppRegistry.registerComponent('LDQQLogin', () => LDQQLogin);
