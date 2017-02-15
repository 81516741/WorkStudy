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
  View
} from 'react-native';

class Header extends Component {
    handleClick(tag,text){
        var myText = this.props.text;
        alert(tag + text + '---\n'+myText);
    }
  render() {
        return (
            <View style = {styles.flex}>
                <Text style = {styles.text} onPress = {this.handleClick.bind(this,'该title的内容是:',this.props.text)}>{this.props.text}</Text>
            </View>
            );
    }
}

const styles = StyleSheet.create({
  flex: {
    backgroundColor: 'yellow',
    height:50,
      alignItems:'center',
      justifyContent:'center',
      marginTop:20,
      borderBottomWidth:2,
      borderTopWidth:2,
      borderBottomColor:'red',
      borderTopColor:'blue',

  },
  text:{
      fontSize:36,
      fontWeight:'bold',
      color:'red'
  }

});

module.exports = Header;

