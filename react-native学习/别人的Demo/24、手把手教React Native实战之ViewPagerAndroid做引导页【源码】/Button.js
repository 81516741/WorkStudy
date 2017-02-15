/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    TouchableWithoutFeedback,
    View
    } from 'react-native';
    
export default class Button extends Component{

  //开始 前进 后退 最后 还加1个  总共5个按钮的通用写法

  constructor(props) {
    super(props);

  }


  _handlePress=()=>{
    if (this.props.enabled && this.props.onPress) {
      //按钮可以按 没有变灰  则启用按钮的onPress（）方法
      this.props.onPress();
    }
  }


  render(){
    //这个View有2个样式，第二个样式是用来覆盖的（加了背景颜色和透明度）
    return(
        <TouchableWithoutFeedback onPress={this._handlePress}>

          <View style={[styles.button, this.props.enabled ? {} : styles.buttonDisabled]}>
            <Text style={styles.buttonText}>{this.props.text}</Text>
          </View>
        </TouchableWithoutFeedback>
    );
  }
}


const styles = StyleSheet.create({
  button: {
    flex: 1,
    width: 0,
    margin: 5,
    borderColor: 'gray',
    borderWidth: 1,
    backgroundColor: 'gray',
  },
  buttonDisabled: {
    backgroundColor: 'black',
    opacity: 0.5,
  },
  buttonText: {
    color: 'white',
  },
});


