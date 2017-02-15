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
    NativeModules,
    NativeAppEventEmitter,
    Alert,
    View
  } from 'react-native';

  class LD_hunhe_ios extends Component {




    componentWillMount(){
      NativeAppEventEmitter.addListener('NativeMsg',this.handleNativeInterfaceMsg);
    }

    componentWillUnmount(){
      NativeAppEventEmitter.remove('NativeMsg',this.handleNativeInterfaceMsg);
    }

    handleNativeInterfaceMsg=(reminder)=>{
      alert('RN收到原生的消息：'+reminder.message);
    }

    render() {
      return (
        <View style={styles.container}>
          <Text style={styles.welcome}
         onPress={this.callIos}
          >
            Welcome to React Native!ios与rn混合
          </Text>
          <Text style={styles.instructions}>
            To get started, edit index.ios.js
          </Text>
          <Text style={styles.instructions}>
            Press Cmd+R to reload,{'\n'}
            Cmd+D or shake for dev menu
          </Text>
        </View>
      );
    }

    callIos=()=>{
      NativeModules.Bridging.sendMessage('{\"msgType\":\"pickContact\"}');
    }
  }

  const styles = StyleSheet.create({
    container: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: '#F5FCFF',
    },
    welcome: {
      fontSize: 20,
      textAlign: 'center',
      margin: 10,
    },
    instructions: {
      textAlign: 'center',
      color: '#333333',
      marginBottom: 5,
    },
  });

AppRegistry.registerComponent('LD_hunhe_ios', () => LD_hunhe_ios);
