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
    TouchableOpacity,
    Image,
} from 'react-native';

var Dimensions = require('Dimensions');
var {width,height,scale} = Dimensions.get('window');

export default class LDWineCell extends Component {
    render() {
        return (
            <TouchableOpacity activeOpacity={0.5} onPress={this.props.clickCell}>
                <View style={[styles.cellContainer]}>
                    <Image style={[styles.image]} source={require('../images/2.jpg')}/>
                    <View style={[styles.rightView]}>
                        <Text style={[styles.textTop]}>{this.props.rowData.name}</Text>
                        <Text style={[styles.textBottom]}>¥{this.props.rowData.money}</Text>
                    </View>
                </View>
            </TouchableOpacity>
        );
    }
}
const styles = StyleSheet.create({
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


