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
    Image,
    Platform,
    TouchableOpacity,
} from 'react-native';

let Dimensions = require('Dimensions')
let {width,height,scale} = Dimensions.get('window')

export default class NaviBar extends Component {

    static defaultProps = {
        backWorlds: '返回',
        title: '',
        rightItems: [],//右边图片的uri集合,最多2个
        backClick:null,
    };

    render() {
        //左边的返回按钮
        renderBackView = ()=>{
            if (this.props.backWorlds.length > 0){
                return (
                    <TouchableOpacity activeOpacity={0.5} onPress={this.props.backClick}>
                        <View style={[styles.naviBackView]}>
                            <Image style={[styles.naviBackArrow]} source={require('../Images/navigationbar_arrow_up.png')}/>
                            <Text style={[styles.naviBackText]} numberOfLines={1}>{this.props.backWorlds}</Text>
                        </View>
                    </TouchableOpacity>
                )
            }else {
                return (<View></View>)
            }
        }

        //右边的图标
        renderRightItems = ()=>{
            let items = []
            for (let i = 0;i < this.props.rightItems.length;i ++){
                let imageName = this.props.rightItems[i];
                items.push(
                    <TouchableOpacity key={i} activeOpacity={0.5} onPress={this.jumpToDetail}>
                        <Image style={[styles.naviRightImage]}
                               source={{uri: imageName}}/>
                    </TouchableOpacity>
                )
            }
            return items;
        }

        return (
            <View style={[styles.container]}>
                <View style={[styles.navi]}>
                    <View style={[styles.naviSub]}>

                        {/*左边返回按钮*/}
                        {renderBackView()}

                        {/*中间的title*/}
                        <View style={[styles.naviMidTitleView]}>
                            <Text style={[styles.naviMidText]} numberOfLines={1}>{this.props.title}</Text>
                        </View>

                        {/*右边的图标*/}
                        <View style={[styles.naviRightView]}>
                            {renderRightItems()}
                        </View>
                    </View>
                </View>
            </View>
        );
    }

}

const styles = StyleSheet.create({

    navi: {
        backgroundColor: 'rgba(45,145,210,1)',
        height: Platform.OS === 'ios' ? 64 : 44,
    },
    naviSub: {
        position: 'absolute',
        bottom: 0,
        left: 0,
        height: 44,
        width: width,
        flexDirection: 'row'
    },
    naviBackView: {
        height: 44,
        alignItems: 'center',
        flexDirection: 'row',
    },
    naviBackArrow: {
        width: 14 * 0.8,
        height: 26 * 0.8,
        marginLeft: 10,
    },
    naviBackText: {
        fontSize: 15,
        fontWeight: 'bold',
        color: 'white',
        width: 80,
        marginLeft: 8
    },
    naviMidTitleView: {
        height: 44,
        justifyContent: 'center',
        width: 120,
        position: 'absolute',
        left: width * 0.5 - 60
    },
    naviMidText: {
        fontSize: 16,
        color: 'white',
        width: 120,
        textAlign: 'center',
    },
    naviSearchInput: {
        height: 30,
        marginLeft: 10,
        marginRight: 10,
        paddingLeft: 10,
        paddingRight: 10,
        backgroundColor: 'white',//这个样式不加,会导致input 在Android中 有一条蓝色的下划线
    },
    naviRightView: {
        height: 44,
        width: 60,
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent:'flex-end',
        position: 'absolute',
        right: 8
    },
    naviRightImage: {
        height: 25,
        width: 25,
        marginLeft: 3.33
    },
});

