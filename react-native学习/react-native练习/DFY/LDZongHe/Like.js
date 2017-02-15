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
    TouchableOpacity,
  View
} from 'react-native';


export default class Like extends Component {

  constructor(props){
    super(props);
    this.state = {
      like:0,
    }
  }

  clickCount = function(){

    this.setState({
      like:this.state.like + 1,
    });
  }

  render() {

//这是一个点赞的小图标 一个代码就搞定了
    const thunbsUp='\uD83D\uDC4D';
    return (
        <View style={[styles.row,styles.center,]}>
          <View style={[styles.text]}>
            <TouchableOpacity
              onPress={this.clickCount.bind(this)}
            >
              <Text style={styles.font}>{thunbsUp}赞</Text>
            </TouchableOpacity>
          </View>
          <View>
            <Text style={styles.font}> {this.state.like}个喜欢数</Text>
          </View>
        </View>
    );
  }
}

const styles = StyleSheet.create({
  text:{
    borderWidth:1,
    borderRadius:10,
    margin:3,
    alignItems:'center',
    justifyContent:'center',
    padding:3,
  },
  font:{
    fontSize:21,
    fontWeight:'bold',
  },
  row:{
    flexDirection:'row',
  },
  center:{
    alignItems:'center',
    justifyContent:'center',

  },
  flex:{
    flex:1,
  }
});

