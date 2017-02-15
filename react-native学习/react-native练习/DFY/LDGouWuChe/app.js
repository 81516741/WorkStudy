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
    Navigator,
    AsyncStorage,
    View
    } from 'react-native';
import GoodsList from './GoodsList.js';
const Model = [
    {
        id: '1',
        title: '猕猴桃1',
        desc: '12个装',
        price: 99,
        url: 'https://gss0.bdstatic.com/5eR1dDebRNRTm2_p8IuM_a/res/img/richanglogo168_24.png',
    },
    {
        id: '2',
        title: '牛油果2',
        desc: '6个装',
        price: 59,
        url: 'https://gss0.bdstatic.com/5eR1dDebRNRTm2_p8IuM_a/res/img/richanglogo168_24.png',
    },
    {
        id: '3',
        title: '猕猴桃3',
        desc: '3个装',
        price: 993,
        url: 'https://gss0.bdstatic.com/5eR1dDebRNRTm2_p8IuM_a/res/img/richanglogo168_24.png',
    },
    {
        id: '4',
        title: '猕猴桃4',
        desc: '4个装',
        price: 994,
        url: 'https://gss0.bdstatic.com/5eR1dDebRNRTm2_p8IuM_a/res/img/richanglogo168_24.png',
    },
    {
        id: '5',
        title: '猕猴桃5',
        desc: '5个装',
        price: 995,
        url: 'https://gss0.bdstatic.com/5eR1dDebRNRTm2_p8IuM_a/res/img/richanglogo168_24.png',
    },{
        id: '6',
        title: '猕猴桃6',
        desc: '6个装',
        price: 996,
        url: 'https://gss0.bdstatic.com/5eR1dDebRNRTm2_p8IuM_a/res/img/richanglogo168_24.png',
    },
    {
        id: '7',
        title: '猕猴桃7',
        desc: '7个装',
        price: 997,
        url: 'https://gss0.bdstatic.com/5eR1dDebRNRTm2_p8IuM_a/res/img/richanglogo168_24.png',
    },{
        id: '8',
        title: '猕猴桃8',
        desc: '8个装',
        price: 998,
        url: 'https://gss0.bdstatic.com/5eR1dDebRNRTm2_p8IuM_a/res/img/richanglogo168_24.png',
    },
    {
        id: '9',
        title: '猕猴桃9',
        desc: '9个装',
        price: 999,
        url: 'https://gss0.bdstatic.com/5eR1dDebRNRTm2_p8IuM_a/res/img/richanglogo168_24.png',
    },


];
class LDGouWuChe extends Component {

    press = (i)=>{
        alert('我是主页的方法')
    }



    render() {
        let defaultName = 'GoodsList';
        let defaultComponent = GoodsList;
        return (
            <Navigator
            initialRoute = {{name:defaultName,component:defaultComponent}}
            configureScene = {
                (route)=>{
                return Navigator.SceneConfigs.FloatFromRight;
                }
                }
            renderScene = {
                (route,navigator)=>{
                let Component = route.component;
                return <Component {...route.params} navigator = {navigator} Model={Model} press={this.press}/>
                }
                }
            />
            );
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

AppRegistry.registerComponent('LDGouWuChe', () => LDGouWuChe);
