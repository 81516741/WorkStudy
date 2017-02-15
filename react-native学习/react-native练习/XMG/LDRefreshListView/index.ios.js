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
    Navigator,
    ListView,
    ActivityIndicator,
    View,
    Image,
    TextInput,
} from 'react-native';

class LDRefreshListView extends Component {
    render() {

        let defaultName = 'MainUI';
        let defaultComponent = MainUI;
        return (
            <Navigator
                initialRoute={{ name: defaultName, component: defaultComponent }}
                //配置场景
                configureScene=
                    {
                    (route) => {

                  //这个是页面之间跳转时候的动画，具体有哪些？可以看这个目录下，有源代码的: node_modules/react-native/Libraries/CustomComponents/Navigator/NavigatorSceneConfigs.js

                  return Navigator.SceneConfigs.FloatFromRight;
                }
              }
                renderScene={
    (route, navigator) =>
    {
      let Component = route.component;
      return <Component {...route.params} navigator={navigator} />
    }
  }/>


        );
    }
}



let dataList = ['百度地图', '支付功能 ']


//let  ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});

class MainUI extends Component {

   

    constructor(props) {
        super(props);
        let ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2})
        this.state = {
            dataSource: ds.cloneWithRows(dataList),
            show: true,
        };
    }

    clickBtn = (rowDate)=> {
        const { navigator } = this.props;
        if (rowDate === dataList[0]) {

        } else if (rowDate === dataList[1]) {

        }
        if (navigator) {
            navigator.push({
                name: 'Jump',
                component: Jump,
                params: {
                    string: rowDate
                }
            })
        }
    }

    changeAct = ()=> {
     dataList = dataList.concat(['微信支付']);
        this.setState({
            show: !this.state.show,
            dataSource:this.state.dataSource.cloneWithRows(dataList),
        });

    }

    render() {
        let self = this
        return (
            <View style={[{flex:1},{backgroundColor:'rgba(200,200,200,0.3)'}]}>
                <View style={[styles.center,{backgroundColor:'blue'},{height:44}]}>
                    <Text onPress={this.changeAct}>Demo列表</Text>
                </View>
                <ListView
                    style={[{marginTop:44}]}
                    dataSource={this.state.dataSource}
                    renderRow={(rowData) =>{
                    return(
                    <LDCell ref = 'ddd' show= {self.state.show} data={rowData} btnClick = {this.clickBtn.bind(this,rowData)}/>
                    )
                    }
                    }
                />
            </View>
        );
    }
}

class LDCell extends Component {

    render() {
        let act = []
        if (this.props.show) {
            act.push(
                <ActivityIndicator
                    size="large"
                    color="#aa3300"
                    key='1'
                />
            )
        } else {
            act = []
        }

        return (
            <View style={[styles.center,{backgroundColor:'yellow'},{ marginTop:1}]}>
                {act}
                <Text>这是我的cell!!</Text>
                <Text onPress={this.props.btnClick} style={[{fontSize:20},]}>{this.props.data}</Text>
            </View>
        );
    }
}


class Jump extends Component {
    popBack = ()=> {
        const {navigator} = this.props;
        navigator.pop()
    }

    render() {
        let fanhui = "<"
        return (
            <View style={{backgroundColor:'rgba(45,145,202,0.4)',flex:1}}>

                <View style={[{height:44,backgroundColor:'red',justifyContent:'center'}]}>
                    <Text style={{fontSize:22} } onPress={this.popBack}>{fanhui} 返回</Text>
                </View>
                <Text style={{fontSize:24,backgroundColor:'yellow'}}>
                    {this.props.string}
                </Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    center: {

        justifyContent: 'center',
        alignItems: 'center',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    instructions: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
    },
    marginTop20: {
        marginTop: 20
    }
});

AppRegistry.registerComponent('LDRefreshListView', () => LDRefreshListView);
