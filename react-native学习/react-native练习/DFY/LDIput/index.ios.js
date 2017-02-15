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
  TextInput,
    PixelRatio,
    TouchableHighlight,
    TouchableOpacity,
    TouchableWithoutFeedback,

    Image,
  View
} from 'react-native';


//touch组件
//<TouchableOpacity>
//<TouchableWithoutFeedback>
//<TouchableHighlight>


var onePT = 1 / PixelRatio.get();
class LDIput extends Component {
    show(){
        alert('touch');
    }
  render() {
    return (
      <View style = {[styles.flex,styles.marginTop20,styles.main_view_backgroundcolor]}>

            <SearchBar/>

          <TouchableHighlight
              onPress = {this.show.bind(this)}
          underlayColor='red'
          style={[styles.touchSize,styles.border,styles.center]}
          >
              <Text style={[styles.touchText]}>touch</Text>

          </TouchableHighlight>
      </View>
    );
  }
}

class SearchBar extends Component{
    constructor(props){
        super(props);
        this.state = {
            show:false,
            value:null,
        }
    }

    hide(value){
        this.setState({
            show:false,
            value:value,
        });
    }

    getValue(value){
        this.setState({
            show:true,
            value:value,
        });
    }
    render(){
        return(
            <View style = {styles.flex}>
                <View style = {styles.flexDirection}>
                    <View style = {styles.searchContainer}>
                        <TextInput
                        style = {styles.text_input}
                        placeholder="请输入关键词"
                        value={this.state.value}
                        onChangeText={this.getValue.bind(this)}
                        />
                    </View>
                    <View style={styles.search_button}>
                        <Text onPress = {this.hide.bind(this,this.state.value)}>搜索</Text>
                    </View>
                </View>
            {(this.state.show && this.state.value)?
                <View style = {styles.result}>
                    <Text numberOfLines={2} onPress={this.hide.bind(this,this.state.value + '曾令达')} >
                    {this.state.value}曾令达
                    </Text>
                    <Text numberOfLines={2} onPress={this.hide.bind(this,this.state.value + '小孩子')} >
                    {this.state.value}小孩子
                    </Text>
                </View>
                :null
                }
            </View>
            );
    }
}

const styles = StyleSheet.create({
    flex:{flex:1},
    main_view_backgroundcolor:{backgroundColor:'yellow'},
    center:{
        alignItems:'center',
        justifyContent:'center',
        alignSelf:'center'
    },
    marginTop20:{
        marginTop:20,
    },
    flexDirection:{
      flexDirection:'row',
    },
    searchContainer:{
        flex:1,
      borderWidth:onePT,
        borderColor:'rgb(43,143,204)',
        borderRadius:10,
        height:44,
        marginLeft:20,
        marginRight:-10,
    },
    text_input:{
        flex:1,
        marginLeft:10,
    },
    search_button:{
        width:50,
        height:44,
        backgroundColor:'blue',
        alignItems:'center',
        justifyContent:'center',
        marginRight:20,
        borderBottomRightRadius:10,
        borderTopRightRadius:10,
    },
    result:{
        flex:1,
        backgroundColor:'red',
        marginLeft:20,
        marginRight:20,
        marginBottom:200,
    },
    touchSize:{
        width:100,
        height:40,
        marginBottom:20,
    },
    touchText:{
        fontSize:18,
    },
    border:{
        borderWidth:onePT,
        borderColor:'rgb(43,143,204)',
    }

});

AppRegistry.registerComponent('LDIput', () => LDIput);
