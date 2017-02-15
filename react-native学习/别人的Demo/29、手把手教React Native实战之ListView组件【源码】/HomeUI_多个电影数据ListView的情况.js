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

//var MOCKED_MOVIES_DATA = [
//    {title: '标题', year: '2015', posters: {thumbnail: 'http://i.imgur.com/UePbdph.jpg'}},
//];


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

    _pressButton() {
        const { navigator } = this.props;
        if(navigator) {
            //很熟悉吧，入栈出栈~ 把当前的页面pop掉，这里就返回到了上一个页面:了
            navigator.pop();
        }
    }

    render(){
        if (!this.state.loaded) {
            //如果movies==null的情况 初始情况  渲染加载视图
            return this.renderLoadingView();
        }

        //从网络上获取了数据的情况
        //var movie = this.state.movies[0];
        //return this.renderMovie(movie);

        return(
            <ListView
                dataSource={this.state.dataSource}
                renderRow={this.renderMovie}
                style={styles.listView}
                />
        );

    }


    renderLoadingView() {
        return (
            <View style={styles.container}>
                <Text>
                    正在网络上获取电影数据……
                </Text>
            </View>
        );
    }



//这是渲染一个电影信息
    renderMovie(movie) {
        return (
            <View style={styles.container}>
                <Image
                    source={{uri: movie.posters.thumbnail}}
                    style={styles.thumbnail}
                    />
                <View style={styles.rightContainer}>
                    <Text style={styles.title}>{movie.title}</Text>
                    <Text style={styles.year}>{movie.year}</Text>

                </View>
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
    container: {
        flex: 1,
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },
    listView: {
        paddingTop: 20,
        backgroundColor: '#F5FCFF',
    },
    thumbnail: {
        width: 53,
        height: 81,

    },
    //让rightContainer在父容器中占据Image之外剩下的全部空间。

    rightContainer: {
        flex: 1,
    },
    title: {
        fontSize: 20,
        marginBottom: 8,
        textAlign: 'center',
    },
    year: {
        textAlign: 'center',
    },



});

module.exports=HomeUI;
