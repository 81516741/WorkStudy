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
    View,
    ListView,
    Image,
} from 'react-native';

import LDWineCell from './commonView/LDWineCell'

var dataList = require('./Wine.json');
var Dimensions = require('Dimensions');
var {width,height,scale} = Dimensions.get('window');

class LDWine extends Component {

    // 构造
    constructor(props) {
        super(props);
        // 初始状态
        let ds = new ListView.DataSource({rowHasChanged: (r1, r2)=>r1 !== r2});
        this.state = {
            ds: ds.cloneWithRows(dataList),
        };
    }

    text = ()=> {
        alert(dataList[0].image);
    }

    render() {
        return (
            <View style={styles.container}>
                <View style={[styles.navi]}>
                    <Text style={[{fontSize:18}]}>这是我的地盘</Text>
                </View>
                <ListView
                    dataSource={this.state.ds}
                    renderRow={this.renderCell}
                />
            </View>
        );
    }

    //返回cell
    renderCell = (rowData, sectionID, rowID, highlightRow)=> {
        return (
            <LDWineCell rowData = {rowData} clickCell = {this.clickCell}/>
        );
    }

    //cell的点击事件
    clickCell = ()=>{
        alert('cell被点击了')
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },
    navi: {
        backgroundColor: 'red',
        height: 44, width: width, marginTop: 20,
        justifyContent: 'center',
        alignItems: 'center'
    },
    cellContainer: {
        padding: 10,
        borderBottomWidth: 1,
        borderColor: 'black',
        backgroundColor: 'yellow',
        width: width * 0.98,
        flexDirection: 'row',
    },
    image: {
        width: 60,
        height: 60,
        borderRadius: 30,
        borderWidth: 2,
        borderColor: 'blue'
    },
    rightView:{
      marginLeft:10,
        alignItems:'center',
        justifyContent:'center',
    },
    textTop: {
        width: width * 0.98 - 80
    },
    textBottom: {
        marginTop:8,
        width: width * 0.98 - 80,
        color:'red',
        fontSize:15,
    },

});

AppRegistry.registerComponent('LDWine', () => LDWine);
