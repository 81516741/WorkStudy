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
    ScrollView,
    ListView,
} from 'react-native';

let Dimensions = require('Dimensions');
const {width,height,scale} = Dimensions.get('window');

import LD9GongGe from './LD9GongGe'

export default class LDLikeCollection extends Component {

    row = ()=>{
        let max = 0;
        for (let i = 0;i < this.props.data.length;i++){
            if(this.props.data[i].length > max){
                max = this.props.data[i].length;
            }
        }
        let row = Math.ceil(max /this.props.col);
        return row;
    }
    count = this.props.data.length;
    height = this.props.showIndicator? this.row()  * (width*1.2/this.props.col) + 30 :this.row()  * (width*1.2/this.props.col);

    static defaultProps = {
        data: [],
        col:5,
        showIndicator:true,
        handle:null,
    };
    // 构造
      constructor(props) {
        super(props);
        // 初始状态
        this.state = {
            currentIndex:0,
        };
      }
    render() {
        return (
            <View style={[styles.container,{height:this.height}]}>
                {this.renderTopItemsView()}
                {this.renderIndicatorView()}
            </View>
        );
    }

    renderTopItemsView = ()=> {
        let items = []
        for (let i = 0; i < this.count; i++) {
            let s = i == this.state.currentIndex ? {}:{backgroundColor:'blue'}
                items.push(
                <LD9GongGe key={i} handle={this.props.handle} section={i} col = {this.props.col} data={this.props.data[i]}/>
            );
        }
        return (<ScrollView
            horizontal={true}
            showsHorizontalScrollIndicator={false}
            pagingEnabled={true}
            onMomentumScrollEnd={this.endScroll}
        >
            {items}
        </ScrollView>);
    }

    renderIndicatorView=()=>{
        let indicarors = []
        viewHeight = this.props.showIndicator ? {height:30}:{height:0}
        for(let i = 0;i < this.count;i ++){
            let currentIndicatorStyle = this.state.currentIndex == i? {color:'white'}:{color:'gray'}
            indicarors.push(
                <Text key={i} style={[currentIndicatorStyle]}>&bull;</Text>
            );
        }

        return (
            <View style={[styles.indicator,viewHeight]}>
                {indicarors}
            </View>);
    }

    endScroll =(scrollView)=>{
        let index =  Math.floor(scrollView.nativeEvent.contentOffset.x/width)
        this.setState({currentIndex:index});
    }

}

const styles = StyleSheet.create({
    container: {
        width:width,
        height:150,
        backgroundColor:'white'
    },
    indicator:{
        flexDirection:'row',
        position:'absolute',
        bottom:0,
        left:0,
        width:width,
        height:30,
        backgroundColor:'rgba(45,145,200,0.4)',
        alignItems:'center',
        justifyContent:'center',
    },
});

