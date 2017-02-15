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
    StyleSheet,
    WebView,
    ActivityIndicator,
} from 'react-native';

import LDNaviBar from '../CommonView/LDNaviBar'

export default class Shop extends Component {

    // 构造
      constructor(props) {
        super(props);
        // 初始状态
        this.state = {
            url:"http://i.meituan.com/topic/mingdian?ci=1&f=iphone&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-02-16-25124&token=p19ukJltGhla4y5Jryb1jgCdKjsAAAAAsgAAADHFD3UYGxaY2FlFPQXQj2wCyCrhhn7VVB-KpG_U3-clHlvsLM8JRrnZK35y8UU3DQ&userid=10086&utm_campaign=AgroupBgroupD100Fab_chunceshishuju__a__a___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_waimaiwending__a__a___ab_gxh_82__nostrategy__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_pindaoshenyang__a__leftflow___ab_pindaoquxincelue0630__b__b1___a20141120nanning__m1__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___ab_waimaizhanshi__b__b1___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGhomepage_bargainmiddle_30311731&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7&lat=23.12005&lng=113.3076"
        };
      }

    render() {
        return (

            <View style={[styles.container]}>
                <LDNaviBar backWorlds = '' title='商家' rightItems={['icon_homepage_message','icon_homepage_scan']} />
                <WebView
                    automaticallyAdjustContentInsets={true}
                    source={{uri: this.state.url}}
                    javaScriptEnabled={true}
                    domStorageEnabled={true}
                    decelerationRate="normal"
                    startInLoadingState={true}
                    renderLoading ={this.renderLoading}
                    onShouldStartLoadWithRequest={this.load}
                />
            </View>
        );
    }

    load=(e)=>{
        if (e.title.length > 0){
            alert('我们不跳转');
            return false;
        }
        return true;
    }

    renderLoading =()=>{
        return(
            <View style={{flex:1,alignItems:'center',justifyContent:'center'}}>
                <ActivityIndicator
                    animating={true}
                    style={{width:40,height: 40}}
                    size="large"
                />
                <Text style={{fontSize:16,color:'gray'}}>正在玩命加载中...</Text>
            </View>
        );
    }
}

const styles  = StyleSheet.create({
    container:{
        flex:1,
    }
});

