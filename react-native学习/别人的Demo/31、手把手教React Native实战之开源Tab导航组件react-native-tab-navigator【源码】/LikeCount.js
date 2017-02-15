/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    TouchableOpacity,
    View
    } from 'react-native';

export default class LikeCount extends Component{
  //喜欢数 组件

  constructor(props){
    super(props);

    this.state={
      likes:0,
    };
  }



  onClick=()=>{
    this.setState({likes:this.state.likes + 1});
  }


  render(){
    //这是一个点赞的小图标 一个代码就搞定了
    const thunbsUp='\uD83D\uDC4D';
    return (
        <View style={styles.likeContainer}>
          <TouchableOpacity onPress={this.onClick} style={styles.likeButton}>
            <Text style={styles.likesText}>{thunbsUp+'Like'}</Text>

          </TouchableOpacity>

          <Text style={styles.likesText}>{this.state.likes+'个喜欢数'}</Text>
        </View>
    );
  }
}


const styles = StyleSheet.create({
  likeButton: {
    backgroundColor: 'rgba(0, 0, 0, 0.1)',
    borderColor: '#333333',
    borderWidth: 1,
    borderRadius: 5,
    flex: 1,
    margin: 8,
    padding: 8,
  },
  
  likeContainer: {
    flexDirection: 'row',
  },
  likesText: {
    flex: 1,
    fontSize: 18,
    alignSelf: 'center',
  },
 
 
});

