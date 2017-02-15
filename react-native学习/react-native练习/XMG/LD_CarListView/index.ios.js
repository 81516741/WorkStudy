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
    ListView,
    Image,
} from 'react-native';

const  Car = require('./Car.json');

class LD_CarListView extends Component {

  // 构造
    constructor(props) {
      super(props);

      let getRowData = (b,s,r)=>{
          return b[s+'r'+r];
      }

      let getSectionData =(b,s)=>{
          return b[s];
      }
      // 初始状态
      this.state = {
        dataSource:new ListView.DataSource({
          getRowData:getRowData,
          getSectionData:getSectionData,
          rowHasChanged:(r1,r2)=>r1 !== r2,
          sectionHeaderHasChanged:(s1,s2)=>s1 !== s2
        }),
      };
    }

  render(){
    return(
        <View style={styles.outerViewStyle}>
          {/*头部*/}
          <View style={styles.headerViewStyle}>
            <Text style={{color:'white', fontSize:25}}>SeeMyGo品牌</Text>
          </View>
          {/*ListView*/}
          <ListView
              dataSource={this.state.dataSource}
              renderRow={this.renderRow}
              renderSectionHeader={this.renderSectionHeader}
          />
        </View>
    );
  }

  // 每一行的数据
  renderRow=(rowData)=>{
    return(
        <TouchableOpacity activeOpacity={0.5}>
          <View style={styles.rowStyle}>
            <Image source={{uri: rowData.icon}} style={styles.rowImageStyle}/>
            <Text style={{marginLeft:5}}>{rowData.name}</Text>
          </View>
        </TouchableOpacity>
    );
  }

  // 每一组中的数据
  renderSectionHeader=(sectionData, sectionID)=>{
    return(
        <View style={styles.sectionHeaderViewStyle}>
          <Text style={{marginLeft:5, color:'red'}}>{sectionData}</Text>
        </View>
    );
  }

  componentDidMount() {
    this.loadDataFromJson();
  }

  loadDataFromJson=()=>{
      let b={},
          s=[],
          r=[],
          cars=[]
    let data = Car.data;

      //彻底理解了listView

      //b[0]='怕怕'
      //  b[0+'r'+0] = '好'
      //  s[0] = 0
      //  r[0] =[0]

    for (let i =0;i < data.length;i ++){
      b[i] = data[i].title;
      s.push(i);
      r[i] = [];
      cars = data[i].cars;
      for (let j = 0;j< cars.length;j++){
        r[i].push(j);
        b[i+'r'+j]=cars[j];
      }
    }
    this.setState({
      dataSource:this.state.dataSource.cloneWithRowsAndSections(b,s,r)
    });
  }


}

// 设置样式
const  styles = StyleSheet.create({
  outerViewStyle:{
    //占满窗口
    flex:1
  },

  headerViewStyle:{
    height:64,
    backgroundColor:'orange',

    justifyContent:'center',
    alignItems:'center'
  },

  rowStyle:{
    // 设置主轴的方向
    flexDirection:'row',
    // 侧轴方向居中
    alignItems:'center',
    padding:10,

    borderBottomColor:'#e8e8e8',
    borderBottomWidth:0.5
  },

  rowImageStyle:{
    width:70,
    height:70,
  },

  sectionHeaderViewStyle:{
    backgroundColor:'#e8e8e8',
    height:25,

    justifyContent:'center'
  }
});

AppRegistry.registerComponent('LD_CarListView', () => LD_CarListView);
