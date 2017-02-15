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
  View,
    PixeRatio,
} from 'react-native';

class LingDa extends Component {
  render() {
    return (
      <View style={styles.container}>
            <View style = {styles.main}>
                <View style = {styles.item}></View>
                <View style = {styles.item}>
                    <View  style ={styles.itemChild}>
                        <Text>我在吗</Text>
                    </View>
                    <View style = {[styles.flex]}>
                        <Text style = {{color:'red'}}>这是一个bug</Text>
                    </View>
                </View>
                <View style = {styles.circleParent}>
                    <View style = {styles.circle}>

                    </View>
                </View>
            </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'green',
     flexDirection:'column',
      alignItems:'center',
      justifyContent:'center',
  },
    flex:{
        flex:1,

        alignItems:'center',
        justifyContent:'center',

    },
  main:{
      width:300,
      height:120,
      backgroundColor: 'red',
      borderWidth:3,
      borderColor:'white',
      borderRadius:20,
      flexDirection:'row',

  },
    item:{
        flex:1,
        flexDirection:'column',
        backgroundColor: 'white',
        margin:5,

    },
    itemChild:{
          flex:1,
          borderColor:'green',
                        borderBottomWidth:2,
        backgroundColor: 'yellow',
        alignItems:'center',
        justifyContent:'center',
    },
    circle:{
      width:80,
        height:80,
        borderRadius:40,
        borderWidth:40,
        borderColor:'purple',
    },
    circleParent:{
        flex:1,
        alignItems:'center',
        justifyContent:'center',
        backgroundColor: 'white',
        margin:5,
    }
});

AppRegistry.registerComponent('LingDa', () => LingDa);
