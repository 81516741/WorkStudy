/**
 * Created by yh on 16/7/26.
 */

import React, { Component } from 'react';
import {
    View,
    Text,
    StyleSheet,
    Image,
    Switch,
    TouchableOpacity,
} from 'react-native';

let Dimensions = require('Dimensions')
let {width,height,scale} = Dimensions.get('window')

export default class LDCell extends Component {

    static defaultProps = {
        leftImage: '',
        title: '',
        subTitle: '',
        rightTitle: '',//这个值存在,rightImage就不会出现
        rightImage: '',
        showSwich: false,//这个为true,则上面的两个就不会出现
        cellClick:null,
    }

    // 构造
    constructor(props) {
        super(props);
        // 初始状态
        this.state = {
            isOn: false,
        };
    }


    render() {
        renderLeftImage = ()=> {
            if (this.props.leftImage.length > 0) {
                return <Image style={[styles.leftImage]} source={{uri:this.props.leftImage}}/>;
            }
        }

        renderLeftText = ()=> {
            let items = []
            if ((this.props.title.length > 0) && (this.props.subTitle.length > 0)) {
                items.push(
                    <Text key={1} style={[styles.leftTitle]}>{this.props.title}</Text>
                );
                items.push(
                    <Text key={2} style={[styles.leftSubTitle]}>{this.props.subTitle}</Text>
                );
            } else {
                if (this.props.title.length > 0) {
                    items.push(
                        <Text key={1} style={[styles.leftTitle]}>{this.props.title}</Text>
                    );
                } else if (this.props.subTitle.length > 0) {
                    items.push(
                        <Text key={1} style={[styles.leftTitle]}>{this.props.subTitle}</Text>
                    );
                }
            }
            return (
                <View style={[styles.leftTextView]}>
                    {items}
                </View>
            );
        }

        renderRightItems = ()=> {
            let items = []
            if (this.props.showSwich) {
                items.push(
                    <Switch key={1} value={this.state.isOn == true} onValueChange={this.swichChangeValue}/>
                );

            } else {
                if (this.props.rightTitle.length > 0) {
                    items.push(
                        <Text key={1} style={[styles.rightTitle]}>{this.props.rightTitle}</Text>
                    );
                } else {
                    if (this.props.rightImage.length > 0) {
                        items.push(
                            <Image key={1} style={[styles.rightImage]} source={{uri:this.props.rightImage}}/>
                        );
                    }
                }
                items.push(<Image key={2} style={[styles.rightArrow]} source={{uri:'icon_cell_rightArrow'}}/>);
            }

            return (
                <View style={[styles.rightItemsView]}>
                    {items}
                </View>
            );
        }

        return (
            <TouchableOpacity activeOpacity={this.opacity} onPress={this.props.cellClick}>
                <View style={[styles.container]}>
                    {/*左边的图标*/}
                    {renderLeftImage()}
                    {/*左边的text*/}
                    {renderLeftText()}
                    {/*右边的item*/}
                    {renderRightItems()}
                </View>
            </TouchableOpacity>
        );
    }

    //swich点击后的操作
    swichChangeValue = ()=> {
        this.setState({
            isOn: !this.state.isOn
        });
    }
    //控制当cell含swich就cell就没有点击特效
    opacity = this.props.showSwich ? 1 : 0.5

}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        flexDirection: 'row',
        height: 44,
        width: width,
        backgroundColor: 'white',
        alignItems: 'center',
        borderBottomColor: 'rgba(200,200,200,0.8)',
        borderBottomWidth: 1 / scale,
    },
    leftImage: {
        width: 25,
        height: 25,
        borderRadius:12.5,
        marginLeft: 8,
    },
    leftTextView: {
        marginLeft: 3,
        height: 44,
        justifyContent: 'center',
        marginLeft: 8
    },
    leftTitle: {
        fontSize: 16
    },
    leftSubTitle: {
        fontSize: 12
    },
    rightItemsView: {
        height: 44,
        flexDirection: 'row',
        alignItems: 'center',
        position: 'absolute',
        right: 18,
    },
    rightArrow: {
        width: 16 * 0.6,
        height: 26 * 0.6,
    },
    rightImage: {
        width: 25,
        height: 25,
        marginRight: 8,
    },
    rightTitle: {
        marginRight: 8,
    },


});

