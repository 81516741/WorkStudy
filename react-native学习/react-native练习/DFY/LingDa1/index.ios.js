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

const Header = require('./header');

class LingDa1 extends Component {

  render() {
    return (
      <View>
        <Header text = '你在吗'></Header>
         <View style = {styles.list_container}>
            <Text style = {[styles.list,styles.news_title]}>这里是新闻列表</Text>
         </View>
          <NewsList news = {
              [
                  '你在做什么',
                  '我在砍打怪兽'
              ]
              }></NewsList>
      </View>
    );
  }
}

class NewsList extends Component{
    handleClick(title){
        alert('你妹-'+title);
    }
    render(){
        var news = [];
        for(var i in this.props.news){
            var text =(
                <View key = {i} style = {styles.news}>
                <Text style = {styles.text} onPress = {this.handleClick.bind(this,this.props.news[i])}>{this.props.news[i]}</Text>
                </View>
                )
             news.push(text)
        }
        return(
            <View style = {styles.list_container}>
            {news}
            </View>

            );
    }

}

const styles = StyleSheet.create({
    list_container:{
        flex:1,
        alignItems:'center',
        justifyContent:'center',
    },
    list:{
      marginTop:10,
    },
    news_title:{
        fontSize:24,
        color:'blue',
        fontWeight:'bold'
    },
    news:{
        marginTop:10,
        marginLeft:8,
        marginRight:8,
        flexDirection:'column',
        alignSelf: 'stretch',
        backgroundColor:'yellow',
        borderBottomWidth:2,
        borderBottomColor:'gray',
        alignItems:'center',
        justifyContent:'center',
    },
    text:{
        flex:1,
        fontSize:20,
        fontWeight:'bold',
    }
});

AppRegistry.registerComponent('LingDa1', () => LingDa1);
