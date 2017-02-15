/**
 * Created by ld on 16/7/30.
 */
/**
 * Created by ld on 16/7/30.
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
    ListView,
    Image,
    TouchableOpacity,
} from 'react-native';

let Dimensions = require('Dimensions');
const {width,height,scale} = Dimensions.get('window');

export default class LD9GongGe extends Component {

    count = this.props.data.length;
    static defaultProps = {
        data: [],
        col: 5,
        handle:null,
        section:0,
    };
    // 构造
    constructor(props) {
        super(props);
        // 初始状态
        var ds = new ListView.DataSource({rowHasChanged: (r1, r2)=>r1 !== r2})
        this.state = {
            dataSource: ds.cloneWithRows(this.props.data)
        };
    }

    render() {
        return (
            <ListView
                dataSource={this.state.dataSource}
                renderRow={this.renderRow}
                contentContainerStyle={styles.contentContainerStyle}
                scrollEnabled={false}
            />
        );
    }

    renderRow = (rowData,s,r)=> {
        let viewW = width / this.props.col;
        let viewH = viewW * 1.2;
        return (
            <TouchableOpacity activeOpacity={0.5} onPress={this.itemClick.bind(this,r)}>
                <View style={{width:viewW,height:viewH,alignItems:'center'}}>
                    <Image style={{width:viewW * 0.8,height:viewW * 0.8,resizeMode:'contain'}}
                           source={{uri:rowData.image}}/>
                    <Text numberOfLines={1} style={{fontSize:12}}>{rowData.title}</Text>
                </View>
            </TouchableOpacity>
        );
    }

    itemClick = (r)=>{
        if (this.props.handle){
            this.props.handle(this.props.section,r);
        }
    }


}

const styles = StyleSheet.create({

    contentContainerStyle: {
        flexDirection: 'row',
        flexWrap: 'wrap',
        width: width,
    }

});

