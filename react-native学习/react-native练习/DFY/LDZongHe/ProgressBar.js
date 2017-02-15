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


export default class ProgressBar extends Component {

  constructor(props){
    super(props);
    this.state = {
      progress:props.index,
    }
  }

  static defaultProps = {
    count: 1,
    index: 0,
  };  // 注意这里有分号
  static propTypes = {
    count: React.PropTypes.number.isRequired,
    index: React.PropTypes.number.isRequired,
  };  // 注意这里有分号

  clickCount = function(){

    this.setState({
      progress:this.state.progress + 1,
    });
  }

  render() {
    let progressWidth = (this.props.index/this.props.count)*(this.props.width);
    if (progressWidth == 0){
      progressWidth = 4
    }
    return (
        <View style={[styles.container,{height:this.props.height,width:this.props.width}]}>
            <View style={[styles.content,{width:progressWidth - 4,height:this.props.height - 4}]}>
            </View>
        </View>
    );
  }
}

const styles = StyleSheet.create({
  container:{
    backgroundColor:'rgba(0,0,0,0.5)',
    borderColor:'white',
    borderWidth:2,
  },
  content:{
    backgroundColor:'gray',

  },
});

