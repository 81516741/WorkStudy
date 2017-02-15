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
    Image,
    View,
} from 'react-native';

import TabNavigator from 'react-native-tab-navigator';

class LDTirdTab extends Component {
    constructor(props) {
        super(props);//这一句不能省略，照抄即可
        this.state = {

            selectedTab: 'home',
        };
    }





    render() {

        var homeView = (

            <View style={[styles.flex, styles.center,{backgroundColor:'#ffff0044'}]}>
                <Text style={{ fontSize: 22 }}>我是主页</Text>
            </View>
        );


        var settingView = (

            <View style={[styles.flex, styles.center,{backgroundColor:'#ff000044'}]}>
                <Text style={{ fontSize: 22 }}>我是设置页面</Text>
            </View>
        );


        return (

            <TabNavigator
                tabBarStyle={{ height: 60 }}
            >
                <TabNavigator.Item
                    selected={this.state.selectedTab === 'home'}
                    title="主页"
                    renderIcon={() => <Image style={styles.img} source={require('./home_tab_home_normal.png') }/>}
                    renderSelectedIcon={() => <Image style={styles.img} source={require('./home_tab_home_pressed.png') }/>}
                    badgeText="200"

                    onPress={() => this.setState({ selectedTab: 'home' })}

                >
                    {homeView}
                </TabNavigator.Item>

                <TabNavigator.Item
                    selected={this.state.selectedTab === 'setting'}
                    title="设置"
                    renderIcon={() => <Image style={styles.img} source={require('./home_tab_setting_normal.png') }/>}
                    renderSelectedIcon={() => <Image style={styles.img} source={require('./home_tab_setting_pressed.png') }/>}
                    renderBadge={() => <Text>东方耀</Text>}
                    onPress={() => this.setState({ selectedTab: 'setting' })}

                >

                    {settingView}
                </TabNavigator.Item>


            </TabNavigator>


        );

    }



}


const styles = StyleSheet.create({

    flex: {
        flex: 1,
    },




    img: {
        width: 40,
        height: 33,
    },

    center: {
        justifyContent: 'center',
        alignItems: 'center',


    },



});


AppRegistry.registerComponent('LDTirdTab', () => LDTirdTab);
