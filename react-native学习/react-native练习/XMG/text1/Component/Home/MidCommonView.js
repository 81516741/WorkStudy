/**
 * Created by yh on 16/8/2.
 */

import React, { Component ,PropTypes} from 'react';
import {
    AppRegistry,
    View,
    Text,
    StyleSheet,
    Image,
    TouchableOpacity,
} from 'react-native';


let Dimensions = require('Dimensions')
let {width,height,scale} = Dimensions.get('window')

export default class MidCommonView extends Component {
    image = '';
    static defaultProps = {
        title: '',
        subTitle: '',
        image: 'ddd',
        titleColor: 'red',
        subTitleColor: '',
        itemW: width * 0.5,
        itemH: 50,
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
        let data = this.props.data;

        return (
            <TouchableOpacity activeOpacity={0.5}>
                <View
                    style={[styles.container,{width:this.props.itemW,height:this.props.itemH,backgroundColor:'white'}]}>
                    <View style={[styles.LeftView,{width:this.props.itemW * 0.5}]}>
                        <Text style={{fontSize:17,color:this.props.titleColor,fontWeight:'bold'}}
                              numberOfLines={1}>{this.props.title}</Text>
                        <Text style={{fontSize:14,color:'rgba(200,199,204,1)'}}
                              numberOfLines={1}>{this.props.subTitle}</Text>
                    </View>
                    <Image source={{uri:this.props.image}} resizeMode={'contain'}
                           style={[{height:this.props.itemH - 6,width:this.props.itemW *0.5 - 1}]}/>

                    <View style={{backgroundColor:'rgba(200,199,204,1)',width:1,height:50}}/>
                </View>
            </TouchableOpacity>
        );
    }

}

const styles = StyleSheet.create({
    container: {
        borderBottomWidth: 1,
        borderColor: 'rgba(200,199,204,1)',
        flexDirection: 'row',
        alignItems: 'center'

    },
    LeftView: {
        width: width * 0.25,
        alignItems: 'center',
        justifyContent: 'space-between',
    },
});

