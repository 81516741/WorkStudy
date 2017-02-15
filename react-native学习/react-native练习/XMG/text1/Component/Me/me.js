/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    View,
    Text,
    StyleSheet,
    TouchableOpacity,
    Image,
    Platform,
    ScrollView,
} from 'react-native';

let Dimensions = require('Dimensions');
let {width,height,scale} = Dimensions.get('window');
import  LDCell from '../CommonView/LDCell'
import LDNaviBar from '../CommonView/LDNaviBar'

export default class Me extends Component {
    render() {
        return (
            <View style={[styles.container]}>
                <Header/>
                <ScrollView style={{backgroundColor:'rgba(236,234,242,1)'}}>
                    <LDCell cellClick={this.cellClick} leftImage="collect" title="我的订单" rightTitle="查看全都订单"/>
                    <View style={{flexDirection:'row',backgroundColor:'white'}}>{this.renderItems()}</View>
                    <View style={{marginTop:10}}>
                        <LDCell leftImage="pay" title="我的钱包" rightTitle="查看全都订单"/>
                        <LDCell leftImage="draft" title="抵用卷" rightTitle="查看全都订单"/>
                    </View>
                    <View style={{marginTop:10}}>
                        <LDCell leftImage="card" title="积分商城" rightTitle="查看全都订单"/>
                    </View>
                    <View style={{marginTop:10}}>
                        <LDCell leftImage="like" title="今日推荐" rightTitle="查看全都订单"/>
                    </View>
                    <View style={{marginTop:10}}>
                        <LDCell leftImage="new_friend" title="我要合作" rightTitle="查看全都订单"/>
                    </View>

                </ScrollView>
            </View>
        );
    }

    cellClick = ()=> {
        alert('我被点击了');
    }
    renderItems = ()=> {
        let datas = require('./me.json');
        items = [];
        for (let i = 0; i < 4; i++) {
            let data = datas[i];
            items.push(
                <TouchableOpacity  key={i} activeOpacity={0.8}>
                    <View style={{width:width/4,height:60,alignItems:'center',justifyContent:'center'}}>
                        <Image style={{width:40,height:30}} source={{uri:data.icon}}/>
                        <Text>{data.title}</Text>
                    </View>
                </TouchableOpacity>
            );
        }
        return items;
    }
}

class Header extends Component {
    render() {
        return (
            <View style={[styles.headerContainer]}>
                {/*header*/}
                <TouchableOpacity activeOpacity={0.7} style={{flex:1}}>
                    <View style={[styles.headerView]}>
                        <Image style={[styles.headerViewLeftIcon]} source={{uri:"yhicon"}} resizeMode="cover"/>
                        <Text style={[styles.headerViewLeftText]}>达达商城</Text>
                        <Image style={[styles.headerViewLeftVip]} source={{uri:"avatar_vip"}}/>
                        <Image style={[styles.headerViewArrow]} source={{uri:"icon_cell_rightArrow"}}/>
                    </View>
                </TouchableOpacity>
                {/*footer*/}
                <View style={[styles.footerView]}>
                    {/*头部控件底部的第1个item*/}
                    <TouchableOpacity activeOpacity={0.5}>
                        <View style={[styles.footerViewItem]}>
                            <Text style={[styles.footerViewItemText]}>100</Text>
                            <Text style={[styles.footerViewItemText]}>达达卷</Text>
                        </View>
                    </TouchableOpacity>

                    {/*头部控件底部的第2个item*/}
                    <TouchableOpacity activeOpacity={0.5}>
                        <View style={[styles.footerViewItem]}>
                            <Text style={[styles.footerViewItemText]}>998</Text>
                            <Text style={[styles.footerViewItemText]}>评价</Text>
                        </View>
                    </TouchableOpacity>

                    {/*头部控件底部的第3个item*/}
                    <TouchableOpacity activeOpacity={0.5}>
                        <View style={[styles.footerViewItem]}>
                            <Text style={[styles.footerViewItemText]}>100W+</Text>
                            <Text style={[styles.footerViewItemText]}>收藏</Text>
                        </View>
                    </TouchableOpacity>

                </View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    headerContainer: {
        width: width,
        height: Platform.OS == 'ios' ? 150 : 130,
        backgroundColor: 'rgba(45,145,210,1)'
    },
    headerView: {
        width: width,
        height: 86,
        position: 'absolute',
        left: 0,
        bottom: 44,
        flexDirection: 'row',
        alignItems: 'center',

    },
    headerViewLeftIcon: {
        width: 76,
        height: 76,
        borderRadius: 38,
        borderWidth: 3,
        borderColor: 'rgba(45,145,210,0.5)',
        marginLeft: 10,
    },
    headerViewLeftText: {
        color: 'white',
        fontSize: 18,
        fontWeight: 'bold',
        marginLeft: 5
    },
    headerViewLeftVip: {
        width: 25,
        height: 25,
        marginLeft: 3
    },
    headerViewArrow: {
        position: 'absolute',
        right: 20, top: 0.5 * (86 - 26 * 0.6),
        width: 16 * 0.6,
        height: 26 * 0.6
    },
    footerView: {
        position: 'absolute',
        bottom: 0,
        left: 0,
        width: width,
        height: 44,
        backgroundColor: 'rgba(35,135,200,0.5)',
        flexDirection: 'row',
        alignItems: 'center',
    },
    footerViewItem: {
        width: width / 3 + 0.5,
        height: 36,
        alignItems: 'center',
        justifyContent: 'center',
        borderRightWidth: 1,
        borderColor: 'white',

    },
    footerViewItemText: {
        color: 'white',
        fontSize: 14,

    }
});
