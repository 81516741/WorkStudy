/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    View,
    Text,
    Navigator,
    Image,
    StyleSheet,
    Platform,
} from 'react-native';

/**-----导入外部的组件类------**/
import TabNavigator from 'react-native-tab-navigator';

import Home from './Home/home';
import Me from './Me/me';
import More from './More/more';
import Shop from './Shop/shop';

export default class App extends Component {


    // 构造
    constructor(props) {
        super(props);
        // 初始状态
        this.state = {
            selectedTab: '首页',
            badgeNumHome:1000,
            badgeNumShop:15,
            badgeNumMe:9,
            badgeNumMore:100,
            tabBarHeight:49,
        };
    }

    render() {
        return (
            <TabNavigator
                tabBarStyle={{backgroundColor:'rgba(200,200,200,0.5)',height:this.state.tabBarHeight,overflow:'hidden'}}
                sceneStyle={{ paddingBottom: this.state.tabBarHeight}}
                ref="tab"
            >
                {/*--首页--*/}
                {this.getItem(require('./Images/icon_tabbar_homepage.png'),
                    require('./Images/icon_tabbar_homepage_selected.png'),
                    "首页",
                    Home, this.state.badgeNumHome)}
                {/*--商家--*/}
                {this.getItem(require('./Images/icon_tabbar_merchant_selected.png'),
                    require('./Images/icon_tabbar_merchant_normal.png'),
                    "商家",
                    Shop, this.state.badgeNumShop)}
                {/*--我的--*/}
                {this.getItem(require('./Images/icon_tabbar_mine_selected.png'),
                    require('./Images/icon_tabbar_mine.png'),
                    '我的',
                    Me, this.state.badgeNumMe)}
                {/*--更多--*/}
                {this.getItem(require('./Images/icon_tabbar_misc.png'),
                    require('./Images/icon_tabbar_misc_selected.png'),
                    '更多',
                    More, this.state.badgeNumMore)}
            </TabNavigator>

        );
    }

    getItem = (image, imageSelected, itemName, itemComponent, badgeText)=> {
        var normalImage = require('./Images/icon_tabbar_misc.png')
        return (
            <TabNavigator.Item
                title={itemName}
                style={this.state.tabStyle}
                renderIcon={() => <Image resizeMode={'contain'} source={image} style={styles.iconStyle}/>} // 图标
                renderSelectedIcon={() =><Image resizeMode={'contain'} source={imageSelected} style={styles.iconStyle}/>}   // 选中的图标
                onPress={()=>{
                        this.setState({selectedTab:itemName})
                        switch(itemName){
                            case '首页':
                            this.setState({
                                badgeNumHome:0,
                            });
                            break
                            case '商家':
                            this.setState({
                                badgeNumShop:0,
                            });
                            break
                            case '我的':
                            this.setState({
                                badgeNumMe:0,
                            });
                            break
                            case '更多':
                            this.setState({
                                badgeNumMore:0,
                            });
                            break
                            default:
                            break
                        }

                }}
                selected={this.state.selectedTab === itemName}
                selectedTitleStyle={styles.selectedTitleStyle}
                renderBadge={this.renderBadge.bind(this,badgeText)}
            >
                <Navigator
                    initialRoute={{name:itemName,component:itemComponent}}
                    configureScene={()=>{
                             return Navigator.SceneConfigs.PushFromRight;
                        }}
                    renderScene={(route,navigator)=>{
                           let Component = route.component;
                           return <Component {...route.passProps} navigator={navigator} setTabBarHidden={this.setTabBarHidden}/>;
                        }}
                />
            </TabNavigator.Item>
        );
    }

    setTabBarHidden = (hidhen)=>{
        let height = 49;
        if (hidhen){
            height = 0;
        }
        this.setState({
            tabBarHeight:height,
        });
    }

    renderBadge = (badgeText)=> {
        let isHideBadge = true;
        let len = 1;
        if (badgeText) {
            isHideBadge = false;
        }
        if (badgeText <= 0) {
            badgeText = null;
        } else if (badgeText > 0 && badgeText < 10) {
            len = 1
        } else if (badgeText > 10 && badgeText < 100) {
            len = 2
        } else if (badgeText >= 100) {
            len = 3;
            badgeText = '99+'
        }
        return (
            <View style={[styles.badgeView,isHideBadge&&{backgroundColor:'rgba(255,255,255,0)'}]}>
                <Text
                    style={[styles.badge,{width:len*10}]}>{badgeText}</Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    iconStyle: {
        width: Platform.OS === 'ios' ? 30 : 25,
        height: Platform.OS === 'ios' ? 30 : 25
    },
    selectedTitleStyle: {
        color: 'rgba(45,145,210,1)'
    },
    badge: {
        fontSize: 10,
        borderRadius: 5,//这个不加,那么在ios是方的,在Android是有圆角的
        textAlign: 'center',
        color: 'white',
    },
    badgeView: {
        height: 10,
        borderRadius: 5,
        backgroundColor: 'red',
        marginTop: 5,
        alignItems:'center',
        justifyContent:'center',
    },


});

