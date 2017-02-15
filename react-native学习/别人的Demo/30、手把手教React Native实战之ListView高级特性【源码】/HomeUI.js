/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    ScrollView,
    Image,
    ListView,
    TouchableHighlight,
    RecyclerViewBackedScrollView,
    View,
    } from 'react-native';




/**
 * 为了避免骚扰，我们用了一个样例数据来替代Rotten Tomatoes的API
 * 请求，这个样例数据放在React Native的Github库中。
 */
var REQUEST_URL = 'https://raw.githubusercontent.com/facebook/react-native/master/docs/MoviesExample.json';

class HomeUI extends Component{

    constructor(props) {
        super(props);//这一句不能省略，照抄即可
        this.state = {
            loaded:false,
            dataSource:new ListView.DataSource({
                rowHasChanged:(row1,row2)=> row1 !== row2,
            }),
        };
    }





    render(){
        if (!this.state.loaded) {

            return this.renderLoadingView();

        }

        //从网络上获取了数据的情况
        //var movie = this.state.movies[0];
        //return this.renderMovie(movie);

        return(


                <ListView
                    dataSource={this.state.dataSource}
                    renderRow={this.renderMovie}
                    contentContainerStyle={styles.list}
                    style={styles.listView}
                    />


        );

    }


    renderLoadingView() {
        return (
            <View style={styles.container1}>
                <Text>
                    正在网络上获取电影数据……
                </Text>
            </View>
        );
    }


    _pressText(){
        alert('点击了');
    }

//这是渲染一个电影信息
    //source={{uri: movie.posters.thumbnail}}
    renderMovie(movie) {
        return (
            <View style={styles.container}>
                <Image
                    source={{uri: movie.posters.thumbnail}}
                    style={styles.thumbnail}


                    />


                <Text style={styles.year} onPress={this._pressText}>年份{movie.year}</Text>



            </View>
        );
    }

    componentDidMount() {
        this.fetchData();
    }


    //在React的工作机制下，setState实际上会触发一次重新渲染的流程，此时render函数被触发，发现this.state.movies不再是null

    fetchData() {
        fetch(REQUEST_URL)
            .then((response) => response.json())
            .then((responseData) => {
                this.setState({
                    dataSource: this.state.dataSource.cloneWithRows(responseData.movies),
                    loaded:true,
                });
            })
            .done();
        //调用了done() —— 这样可以抛出异常而不是简单忽略
    }


}


const styles = StyleSheet.create({
    list: {
        justifyContent: 'flex-start',
        flexDirection: 'row',
        flexWrap: 'wrap'
    },
    container: {

        width: 100,
        height: 100,
        backgroundColor: '#F5FCFF',
        margin:5,
        alignItems:'center',
    },
    listView: {
        paddingTop: 20,
        backgroundColor: '#F5FCFF',
    },
    thumbnail: {
        width: 80,
        height: 80,
        borderRadius:16,


    },
    //让rightContainer在父容器中占据Image之外剩下的全部空间。

    container1: {
        flex: 1,
        justifyContent:'center',
        alignItems:'center',
    },
    title: {
        fontSize: 14,
        marginBottom: 8,

    },
    year: {
        fontSize: 14,

    },



});

module.exports=HomeUI;
