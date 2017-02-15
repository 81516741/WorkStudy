/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    Image,
    WebView,
    View,
    } from 'react-native';

import Dimensions from 'Dimensions';


const width=Dimensions.get('window').width;
const height=Dimensions.get('window').height;

export default class HomeUI extends Component{

    constructor(props) {
        super(props);//这一句不能省略，照抄即可

    }



    render(){


        return (

            <View style={styles.flex}>
            <WebView
                style={{height:height,width:width}}
                source={{uri:'http://m.chinanxh.com'}}
                injectedJavaScript={"alert('我是东方耀')"}
                ></WebView>
            </View>


        );

    }




}


const styles = StyleSheet.create({

    flex:{
        flex:1,
    },

});

