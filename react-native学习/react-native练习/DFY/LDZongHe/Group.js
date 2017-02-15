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
    Image,
    TouchableOpacity,
  View
} from 'react-native';

import Dimensions from 'Dimensions';
import Like from './Like'

const Width = Dimensions.get('window').width;
const Height = Dimensions.get('window').height;

export default class Group extends Component {

  constructor(props){
    super(props);
  }
  static defaultProps = {
    uri: 'http://apod.nasa.gov/apod/image/1409/volcanicpillar_vetter_960.jpg',
  };  // 注意这里有分号
  static propTypes = {
    uri: React.PropTypes.string.isRequired,
  };  // 注意这里有分号

  render() {
    return (
        <View style={[styles.container,styles.flex]}>
            <View style = {[styles.picture]}>
              <Image
                //resizeMode='contain'  有了这句就会按图片原来尺寸等比例缩放
                style={styles.imageSize}
                source={{uri: this.props.uri}}
               />
            </View>
            <Like/>
        </View>
    );
  }
}

const styles = StyleSheet.create({
  container:{
    backgroundColor:'green',
  },
  flex:{
    flex:1,
  },
  picture:{
    margin:Width * 0.1,
    width:Width * 0.8,
    height:Width * 0.8,
  },
  imageSize:{
    width:Width * 0.8,
    height:Width * 0.8,
  }
});

