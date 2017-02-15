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
    View,
    } from 'react-native';




/**
 * 为了避免骚扰，我们用了一个样例数据来替代Rotten Tomatoes的API
 * 请求，这个样例数据放在React Native的Github库中。
 */
var REQUEST_URL = 'https://raw.githubusercontent.com/facebook/react-native/master/docs/MoviesExample.json';

export default class HomeUI extends Component{

    constructor(props) {
        super(props);//这一句不能省略，照抄即可
        this.state = {
            movies: null,  //这里放你自己定义的state变量及初始值
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
        if (!this.state.movies) {
            //如果movies==null的情况 初始情况  渲染加载视图
            return this.renderLoadingView();
        }

        //从网络上获取了数据的情况
        var movie = this.state.movies[0];
        return this.renderMovie(movie);

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
                    <Text style={styles.title}>标题：{movie.title}</Text>
                    <Text style={styles.year}>{movie.year}年</Text>

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
                    movies: responseData.movies,
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

