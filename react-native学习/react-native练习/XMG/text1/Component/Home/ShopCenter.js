/**
 * Created by yh on 16/8/2.
 */
/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component ,PropTypes} from 'react';
import {
    AppRegistry,
    View,
    Text,
    StyleSheet,
    Image,
    ScrollView,
    TouchableOpacity,
} from 'react-native';

let Dimensions = require('Dimensions')
let {width,height,scale} = Dimensions.get('window')


import LDCell from '../CommonView/LDCell'
export default class ShopCenter extends Component {

    static defaultProps = {
        data: null
    };
    static propTypes = {};
    // 构造
    constructor(props) {
        super(props);
        // 初始状态
        this.state = {};
    }

    render() {
        return (
            <View style={[styles.container,{}]}>
                <LDCell leftIamge="avatar_grassroot" title="购物中心" rightTitle="总共4家"/>
                {this.renderItems()}
            </View>
        );
    }

    renderItems = ()=> {
        let items = [];
        let data = this.props.data;
        for (let i = 0; i < data.length; i++) {
            items.push(
                <TouchableOpacity key={i} activeOpacity={0.5}>
                    <View  style={[styles.itemStyle]}>

                        <Image style={{width:width * 0.3,height:width * 0.3,borderRadius:10}}
                               source={{uri:data[i].shopImage}}/>

                    </View>
                </TouchableOpacity>
            );
        }
        return (
            <ScrollView
                showsHorizontalScrollIndicator={false}
                horizontal={true}
            >
                {items}
            </ScrollView>
        );

    }

}

const styles = StyleSheet.create({
    container: {
        width: width,
        height: 44 + width * 0.3 + 30,
        backgroundColor: 'white'
    },
    itemStyle: {
        marginTop: 10,
        marginLeft: 10,
        alignItems: 'center'
    }
});

