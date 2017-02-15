/**
 * Created by yh on 16/8/2.
 */
/**
 * Created by yh on 16/8/2.
 */

import React, { Component ,PropTypes} from 'react';
import {
    AppRegistry,
    View,
    Text,
    StyleSheet,
    Image
} from 'react-native';


let Dimensions = require('Dimensions')
let {width,height,scale} = Dimensions.get('window')
// 引入外部数据
var TopData = require('../../LocalData/HomeTopMiddle');
var BottomData = require('../../LocalData/HomeHotData');

import MidCommonView from './MidCommonView'

export default class MidBottomView extends Component {

    static defaultProps = {
        name1: 'z在'
    };
    static propTypes = {
        name: PropTypes.string
    };
    // 构造
    constructor(props) {
        super(props);
        // 初始状态
        this.state = {};
    }

    render() {
        return (
            <View style={[styles.container]}>
                <MidCommonView title = {TopData.data[0].title} subTitle ={TopData.data[0].subTitle } image={TopData.data[0].rightImage} itemW={width + 1}/>
                <View style={[styles.bottomView]}>
                    {this.renderItems()}
                </View>

            </View>
        );
    }

    renderItems =()=>{
        let items = [];
        for(let i = 0;i < 4;i ++){
            items.push(
                <MidCommonView key = {i} title = {TopData.data[0].title} subTitle ={TopData.data[0].subTitle } image={TopData.data[0].rightImage} itemW={width * 0.5}/>
            )
        }
        return items;

    }

}

const styles = StyleSheet.create({
    container: {
        width: width,
        height: 150,
        backgroundColor:'white',
    },
    bottomView:{
        flexDirection:'row',
        flexWrap:'wrap',
    }

});

