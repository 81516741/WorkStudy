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
    ScrollView,
} from 'react-native';

import LDNaviBar from '../CommonView/LDNaviBar'
import LDCell from '../CommonView/LDCell'

import MoreDetail from './moreDetail'

export default class More extends Component {

    jump = ()=>{
        let {navigator} = this.props;
        if (navigator){
            navigator.push({
                component: MoreDetail,
            })
        }
    }

    render() {
        return (
            <View style={[styles.container]}>
                <LDNaviBar backWorlds='' title='更多' rightItems={['icon_mine_setting']}/>
                <ScrollView style={[styles.flex]}>
                    <View style={[styles.group]}>
                        <LDCell title='扫一扫' cellClick={this.jump}/>
                    </View>

                    <View style={[styles.group]}>
                        <LDCell title='开启声音' showSwich={true}/>
                        <LDCell title='消息提醒'/>
                        <LDCell title='邀请好友使用达达商城'/>
                        <LDCell title='清空缓存' rightTitle='52.0M'/>
                    </View>


                    <View style={[styles.group]}>
                        <LDCell title='意见反馈'/>
                        <LDCell title='问卷调查'/>
                        <LDCell title='支付问题'/>
                        <LDCell title='网络诊断'/>
                        <LDCell title='关于烟花'/>
                        <LDCell leftImage="avatar_grassroot" title='我要应聘'/>
                    </View>

                    <View style={[styles.group]}>
                        <LDCell title='我要应聘'/>
                        <LDCell title='我要用RN'/>
                    </View>

                </ScrollView>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'rgba(200,200,200,0.4)'
    },
    group: {
        marginTop:12,
    },
});

