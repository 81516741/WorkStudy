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
    Platform,
    TouchableOpacity,
    TextInput,
    Image,
    Navigator,
    ScrollView,
    ListView,
} from 'react-native';
let Dimensions = require('Dimensions')
let {width,height,scale} = Dimensions.get('window')

const homeTopData = require('../../LocalData/TopMenu.json');
var youLikeData = require('../../LocalData/HomeGeustYouLike.json');

import Detail from './Detail'
import MidTopView from  './MidTopView'
import MidBottomView from './MidBottonView'
import ShopCenter from  './ShopCenter'
import LDLikeCollection from './LDCollectionView/LDLikeCollection'
import LDCell from '../CommonView/LDCell'

const Data = require('../../LocalData/ShopCenterShops');

export default class Home extends Component {
    // 构造
    constructor(props) {
        super(props);
        // 初始状态
        this.state = {
            dataSource: new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2}),
        };
    }

    render() {
        return (
            <View style={[styles.container]}>
                {/*导航条*/}
                {this.renderNavi()}

                <ScrollView style={{backgroundColor:'rgba(200,199,204,0.4)'}}>
                    {/*topView*/}
                    <LDLikeCollection handle ={this.topItemClick} col = {5} showIndicator={true} data={homeTopData.data}/>

                    {/*中间View的上部*/}
                    <View style={{marginTop:10,borderTopWidth:1,borderTopColor:'rgba(200,199,204,1)'}}>
                        <MidTopView/>
                    </View>
                    {/*中间View的下部*/}
                    <View style={{marginTop:10}}>
                        <MidBottomView/>
                    </View>

                    {/*购物中心*/}
                    <View style={{marginTop:10}}>
                        <ShopCenter data={Data.data}/>
                    </View>

                    {/*猜你喜欢*/}
                    <View style={{marginTop:10}}>
                        <LDCell leftIamge="avatar_grassroot" title="猜你喜欢"/>
                        <ListView
                            dataSource={this.state.dataSource}
                            renderRow={this.renderRow}
                        />
                    </View>

                </ScrollView>
            </View>
        );
    }

    componentDidMount() {
        this.setState({
            dataSource: this.state.dataSource.cloneWithRows(youLikeData.data),
        });
    }

    renderRow = (data)=> {
        let url = this.dealWithImgUrl(data.imageUrl)
        return (
            <TouchableOpacity activeOpacity={0.5}>
                <View
                    style={[styles.LikeCellContainer]}>
                    <Image resizeMode={'cover'}
                           source={{uri:url}}
                           style={styles.LikeCellImage}/>
                    <View style={styles.LikeCellRightView}>

                        <View style={{flexDirection:'row',marginBottom:5}}>
                            <Text style={{fontSize:18}}>{data.title}</Text>

                        </View>

                        <Text numberOfLines={2} style={{width:width - 150,color:'gray'}}>{data.subTitle}</Text>

                        <View style={{marginTop:5,flexDirection:'row',alignItems:'center',height:18}}>
                            <Text style={{color:'red',fontSize:18}}>{data.mainMessage + data.mainMessage2}</Text>
                            <View  style={{position:'absolute',right:0}}>
                                <Text>{data.bottomRightInfo}</Text>
                            </View>
                        </View>
                    </View>

                </View>
            </TouchableOpacity>
        );
    }

    //处理图像的尺寸
    dealWithImgUrl(url) {
        if (url.search('w.h') == -1) { // 没有找到,正常返回
            return url;
        } else {
            return url.replace('w.h', '120.90');
        }
    }

    renderNavi = ()=> {
        return (
            <View style={[styles.navi]}>
                <View style={[styles.naviSub]}>
                    <TouchableOpacity activeOpacity={0.5} onPress={this.selectedPlace}>
                        <View style={[styles.naviPlace]}>
                            <Text style={[styles.naviPlaceText]}>广州</Text>
                        </View>
                    </TouchableOpacity>
                    <View style={[styles.naviSearch]}>
                        {/*这里必须要加个包装,如果直接设置input,在ios是圆的,在Android是方的*/}
                        <View style={[styles.naviSearchInputContainer]}>
                            <TextInput
                                style={[styles.naviSearchInput]}
                                placeholder="商品,店铺"
                            />
                        </View>
                    </View>
                    <View style={[styles.naviRight]}>
                        <TouchableOpacity activeOpacity={0.5} onPress={this.jumpToDetail}>
                            <Image style={[styles.naviRightImage]}
                                   source={{uri: 'icon_homepage_message'}}/>
                        </TouchableOpacity>

                        <TouchableOpacity activeOpacity={0.5} onPress={this.selectedPlace}>
                            <Image style={[styles.naviRightImage]}
                                   source={{uri: 'icon_homepage_scan'}}/>
                        </TouchableOpacity>
                    </View>
                </View>
            </View>
        );
    }

    jumpToDetail = ()=> {
        let {navigator,setTabBarHidden} = this.props;
        if (!navigator || !setTabBarHidden) return;
        setTabBarHidden(true);
        navigator.push(
            {
                component: Detail, // 要跳转的版块
                passProps: {
                    name: '你好',
                    age: 18,
                    city: 'lanhu',
                    setTabBarHidden: setTabBarHidden,
                },
            }
        );
    }

    selectedPlace = ()=> {
        alert('跳转到选择地方')
    }
    topItemClick = (s,r)=>{
        alert(s +'-'+ r);
    }
}


const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    navi: {
        backgroundColor: 'rgba(45,145,210,1)',
        height: Platform.OS === 'ios' ? 64 : 44,
    },
    naviSub: {
        position: 'absolute',
        bottom: 0,
        left: 0,
        height: 44,
        width: width,
        flexDirection: 'row'
    },
    naviPlace: {
        height: 44,
        width: 60,
        justifyContent: 'center',
        alignItems: 'center',
    },
    naviPlaceText: {
        fontSize: 15,
        fontWeight: 'bold',
        color: 'white',
    },
    naviSearch: {
        height: 44,
        width: width - 120,
        justifyContent: 'center',
    },
    naviSearchInputContainer: {
        backgroundColor: 'white',
        borderRadius: 15,
    },
    naviSearchInput: {
        height: 30,
        marginLeft: 10,
        marginRight: 10,
        paddingLeft: 10,
        paddingRight: 10,
        backgroundColor: 'white',//这个样式不加,会导致input 在Android中 有一条蓝色的下划线
    },
    naviRight: {
        height: 44,
        width: 60,
        flexDirection: 'row',
        alignItems: 'center',
    },
    naviRightImage: {
        height: 25,
        width: 25,
        marginLeft: 3.33
    },
    LikeCellContainer: {
        flexDirection: 'row',
        alignItems: 'center',
        backgroundColor: 'white',
        borderBottomWidth: 1 / scale,
        borderBottomColor: 'rgba(200,199,204,1)',
        height: 90 + 20,
        width: width,
        flexDirection: 'row',
        alignItems: 'center',
        backgroundColor: 'white',
        borderBottomWidth: 1 / scale,
        borderBottomColor: 'rgba(200,199,204,1)',
        height: 90 + 20,
        width: width,
    },
    LikeCellImage: {
        width: 120, height: 90, margin: 10, borderRadius: 10
    },
    LikeCellRightView: {
        height: 90,
        width: width - 150,
        justifyContent:'center',
    },

});
