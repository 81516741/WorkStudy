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
    ListView,
    TouchableWithoutFeedback,
    ScrollView,
  View
} from 'react-native';

import Dimensions from 'Dimensions';

const Width = Dimensions.get('window').width;
const Height = Dimensions.get('window').height;

const REQUEST_URL = 'https://raw.githubusercontent.com/facebook/react-native/master/docs/MoviesExample.json';

var desMovie = null;

export default class HomeUI extends Component{

    constructor(props){
        super(props)
        this.state={
           load:false,
            dataSource:new ListView.DataSource({
                    rowHasChanged:(row1,row2)=>row1!==row2
        }),
        }
    }




      backHome = ()=>{
      const { navigator } = this.props;
      //为什么这里可以取得 props.navigator?请看上文:
      //<Component {...route.params} navigator={navigator} />
      //这里传递了navigator作为props
      if(navigator) {
        navigator.pop()
      }
      }

  render(){
    if(!this.state.load){
        return this.loadData()
    }else {

        return (
          <View style={{flex:1,alignItems:'center',backgroundColor:'rgba(0,0,0,0.3)'}}>
                <View style={{height:44,backgroundColor:'rgba(58,35,200,0.2)',justifyContent:'center',width:Width}}>
                    <Text onPress={this.backHome} style={{fontSize:18,fontWeight:'bold',color:'rgba(200,100,200,0.8)'}}> 返回</Text>
                </View>
                <ListView
                    dataSource={this.state.dataSource}
                    renderRow={this.renderView}
                    contentContainerStyle={styles.list}
                    style={styles.listView}
                />
        </View>
        );
    }
  }

    loadData=()=>{
        return (
            <View style={[{backgroundColor:'rgba(25,125,201,0.3)',alignItems:'center',justifyContent:'center'},styles.flex]}>
            <Text onPress={this.backHome} style={{fontSize:24,color:'blue'}}>我是主页面</Text>
            <Text style={{color:'white'}}>正在疯狂加载数据中....</Text>
            </View>
        );
    }
    renderView(data){

    return(


        <View style={[{backgroundColor:'rgba(25,125,201,0.3)',justifyContent:'center',width:100,height:100,borderWidth:2,borderColor:'white',borderRadius:10,margin:2}]}>

             <View style={[styles.movieContainer,{flexDirection:'column',alignItems:'center'}]}>
                <Image
                    source={{uri:data.posters.thumbnail}}
                    style={styles.img}
                />
                <View style={{flexDirection:'column',alignItems:'center',width:200}}>
                    <Text>电影年份{data.year}</Text>
                </View>
             </View>
        </View>
    );
    }

    componentDidMount() {
        this.fetchData();
    }

    fetchData(){
        fetch(REQUEST_URL).then((r)=>r.json()).then((rd)=>{
                //这里我之前是想记录第一个元素,现在暂时放在这里,注意,这个千万别放在设置状态下面,不然会导致更新ui的时候desMovie为null
                desMovie = rd.movies[0];
                this.setState({
                    dataSource:this.state.dataSource.cloneWithRows(rd.movies),
                    load:true,
                });
        }).done()
    }


}


const styles = StyleSheet.create({

    movieContainer:{
        flexDirection:'row',
    },
    img:{
        width:60,
        height:60,


    },
    flex:{
        flex:1,
    },
    list: {
        justifyContent: 'flex-start',
        flexDirection: 'row',
        flexWrap: 'wrap',
    },
    listView: {
        marginTop: 20,
        marginBottom:20,
    },

});
