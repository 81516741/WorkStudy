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




export default class HomeUI extends Component{

    constructor(props) {
        super(props);//这一句不能省略，照抄即可
        this.state = {
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


    componentWillMount() {
        this.dsfetchData();
    }

    render(){

        return(
            <ListView
                dataSource={this.state.dataSource}
                renderRow={(rowData) => <Text>{rowData}</Text>}
                style={styles.listView}
                />
        );

    }







    dsfetchData(){
        this.setState({
            dataSource: this.state.dataSource.cloneWithRows(['row 1', 'row 2','row 3','row 4','row 5','row 6','row 7','row 8']),
        });
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

