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
    TouchableOpacity,
    Image,
} from 'react-native';
var Dimensions = require('Dimensions');
var {width,scale} = Dimensions.get('window');
var dataJson = require('./shareData.json');

var col = 3;
var cellWidth = 100;
var leftMargin = (width - col * cellWidth) / (col + 1);
var topMargin = 25;

class LD_9GongGe extends Component {

    // 构造
    constructor(props) {
        super(props);
        // 初始状态
        let ds = new ListView.DataSource({rowHasChanged: (r1, r2)=>r1 !== r2});
        this.state = {
            dataSource: ds.cloneWithRows(dataJson.data)
        };
    }

    render() {
        return (
            <View style={styles.container}>
                <ListView
                    dataSource={this.state.dataSource}
                    renderRow={this.renderRow}
                    contentContainerStyle={[styles.listView]}
                />
            </View>
        );
    }

    renderRow = (rowData, sectionID, rowID)=> {
        return (
            <View style={[styles.itemView]}>

                <TouchableOpacity activeOpacity={0.5} onPress={this.itemClick.bind(this,rowID)}>
                    <View style={{width: cellWidth,height:cellWidth,alignItems:'center'}}>
                        <Image source={require('./1.jpg')} style={[styles.icon]}/>

                        <Text>{rowID}</Text>
                    </View>
                </TouchableOpacity>
            </View>


        );
    }

    itemClick = (rowID)=> {
        alert(rowID)
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#F5FCFF',
    },
    listView: {
        flexDirection: 'row',
        flexWrap: 'wrap',
    },
    itemView: {
        width: cellWidth,
        height: cellWidth,
        marginLeft: leftMargin,
        marginTop: topMargin,
        backgroundColor: 'rgba(42,142,204,0.8)',
        alignItems: 'center',
        justifyContent: 'center',
    },
    icon: {
        width: 80,
        height: 80,
        borderRadius: 40,
        borderColor: 'blue',
        borderWidth: 2,
    }

});

AppRegistry.registerComponent('LD_9GongGe', () => LD_9GongGe);
