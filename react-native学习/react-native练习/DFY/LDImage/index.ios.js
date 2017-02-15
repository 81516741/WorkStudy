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
  View
} from 'react-native';

var imgs=[
    'https://www.baidu.com/img/bd_logo1.png',
    'https://gss1.bdstatic.com/5eN1dDebRNRTm2_p8IuM_a/res/img/xiaoman2016_24.png',
];

class LDImage extends Component {

  render() {
    return (
      <View style = {[styles.flex,styles.container]}>
            <MyImage imgs = {imgs}></MyImage>
      </View>
    );
  }
}

class MyImage extends Component{

    constructor(props){
        super(props);
        this.state = {
            index:0,
            imgs:this.props.imgs,
        }
    }

    next(){
        let newIndex = this.state.index + 1;
        if(newIndex == 2){
            newIndex = 0;
        }
        this.setState({
            index:newIndex,
        });
    }

    pre(){
        let newIndex = this.state.index - 1;
        if(newIndex == -1){
            newIndex = 1;
        }
        this.setState({
            index:newIndex,
        });
    }


    render(){
        return(

            <View style={[styles.center,styles.flex]}>
                <Text style = {[styles.title]}>下面是一个相册</Text>
                <View style={[styles.center,styles.imageBox]}>
                    <Image style={styles.img}
                    resizeMode="contain"
                    source={{uri:this.state.imgs[this.state.index]}}

                    />
                </View>
                <View style={[styles.center,styles.flexDirectionRow]}>
                    <Text style = {[styles.button]} onPress = {this.pre.bind(this)}>上一张</Text>
                    <Text style = {[styles.button]} onPress = {this.next.bind(this)}>下一张</Text>
                </View>
            </View>
            );
    }
}

const styles = StyleSheet.create({
    flex:{
        flex:1,
    },
    flexDirectionRow:{
        flexDirection:'row',
    },
    flexDirectionColumn:{
       flexDirection:'column',
    },
     container:{
       marginTop:45,
         backgroundColor:'red',

     },
    center:{
        alignItems:'center',
        alignSelf:'center',
    },
    title:{
        marginTop:20,
        fontSize:20,
        fontWeight:'bold',
        color:'blue',
    },
    imageBox:{
        width:200,
        height:200,
        backgroundColor:'yellow',
        marginTop:20,
    },
    buttonBox:{

    },
    button:{
        marginLeft:10,
        marginRight:10,
        marginTop:20,
        fontSize:18,
        fontWeight:'bold',
        backgroundColor:'rgb(45,145,202)',
    },
    img:{
        height:200,
        width:200,
    },
});

AppRegistry.registerComponent('LDImage', () => LDImage);
