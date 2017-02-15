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
} from 'react-native';

import LDNaviBar from '../CommonView/LDNaviBar'

export default class MoreDetail extends Component {

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
                <LDNaviBar backWorlds='返回' title='首页详情' backClick={this.show}/>
                <Text onPress={this.show}>我是详情页</Text>
            </View>
        );
    }

    show = ()=> {
        this.props.setTabBarHidden(false)
        this.props.navigator.pop()
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'red',

    }
});

