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
    TouchableWithoutFeedback,
  View
} from 'react-native';


export default class Button extends Component {

  constructor(props){
    super(props);

  }

  _handleClick=()=>{
    if(this.props.enable && this.props.press){
      this.props.press();
    }
  }

  render() {

    return (
          <TouchableWithoutFeedback
          onPress={this._handleClick}
          >
              <View style={[styles.button,!this.props.enable && styles.enable,{width:this.props.width,height:this.props.height}]}>
                 <Text style={[styles.buttonText,{fontSize:this.props.font}]}>{this.props.worlds}</Text>
              </View>
          </TouchableWithoutFeedback>
    );
  }
}

const styles = StyleSheet.create({
    button:{
      backgroundColor:'gray',
      borderWidth:1,
      borderColor:'gray',
        margin:3,
        justifyContent:'center'
    },
    enable:{
      backgroundColor:'rgba(0,0,0,0.5)'
    },
    buttonText:{
      color:'white',
    }
});

