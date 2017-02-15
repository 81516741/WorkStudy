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
var MiddleTopData = require('../../LocalData/HomeTopMiddleLeft.json');

import MidCommonView from './MidCommonView'

export default class MidTopView extends Component {

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
        let dataLeft = MiddleTopData.dataLeft;
        let dataRight = MiddleTopData.dataRight;
        return (
            <View style={[styles.container]}>
                {/*左边的view*/}
                {this.renderLeftView(dataLeft)}
                {/*右边的view*/}
                <View>
                    <MidCommonView image={dataRight[0].rightImage} title = {dataRight[0].title} subTitle ={dataRight[0].subTitle } titleColor={dataRight[0].titleColor}/>
                    <MidCommonView image={dataRight[0].rightImage} title = {dataRight[1].title} subTitle ={dataRight[1].subTitle } titleColor={dataRight[1].titleColor}/>
                </View>
            </View>
        );
    }

    renderLeftView = (data)=> {
        return (
            <View style={[styles.leftView]}>
                <Image source={{uri:data[0].img1}} style={styles.leftImage} resizeMode={'contain'}/>
                <Image source={{uri:data[0].img2}} style={styles.leftImage} resizeMode={'contain'}/>
                <Text style={{color:'rgba(200,199,204,1)',fontSize:16,fontWeight:'bold'}}>麻辣小龙虾</Text>
                <View style={[styles.leftBottomView]}>
                    <Text style={{color:'rgba(45,145,204,1)'}}>¥99.9</Text>
                    <Text style={{backgroundColor:'yellow',color:'orange',marginLeft:5}}>再减10元</Text>
                </View>
            </View>
        );
    }

}

const styles = StyleSheet.create({
    container: {
        width: width,
        height: 100,
        flexDirection: 'row',
        backgroundColor:'white'

    },
    leftView: {
        flex: 1,
        alignItems:'center',
        justifyContent:'center',
        borderRightWidth:1,
        borderBottomWidth:1,
        borderColor:'rgba(200,199,204,1)'
    },
    leftImage:{
        width:width * 0.4,
        height:25,
    },
    leftBottomView:{

        flexDirection: 'row',
        justifyContent:'center',
        alignItems:'center',
    }
});

