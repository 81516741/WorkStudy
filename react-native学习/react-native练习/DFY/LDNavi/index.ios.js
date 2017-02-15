/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 * 为什么 ListItem 组件的 params参数传递不到 Detail组件那里去
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  Navigator,
  View
} from 'react-native';

class LDNavi extends Component {
    render() {
        let defaultName = 'ListItem';
        let defaultComponent = ListItem;
        return (
            <Navigator
                initialRoute = {{name:defaultName,component:defaultComponent}}
                configureScene = {
                    (route)=>{
                        return Navigator.SceneConfigs.FloatFromRight;
                     }
                }
                renderScene = {
                     (route,navigator)=>{
                        let Component = route.component;
                        return <Component {...route.params} navigator = {navigator} items={['黑店一号','黑店二号']} />
                    }
                }
            />

            );
    }
}


class ListItem extends Component{

    constructor(props){
        super(props);
        this.state = {
            id:1,
            user:null,
        };
    }
    handleClick(){
        const  {navigator} = this.props;
        const  self = this;
        if(navigator){
            navigator.push({
                name: 'Detail',
                component: Detail,
                params:{
                    id:self.state.id,
                    getUser:function(user){
                      self.setState({
                          user:user
                      })
                    }
                }
            });
        }
    }

    render(){
        let items = this.props.items;
        let itemsViews = [];
        for (let i in items){
            let view = (
                <View key = {i} style={[styles.marginTop20]}>
                    <Text style = {styles.textStyle} onPress ={this.handleClick.bind(this)} >{items[i]}</Text>
                </View>
                );
            itemsViews.push(view);
        }
        if(this.state.user){
            return (
                <View style={[styles.marginTop20,styles.textContainer]}>
                    <Text>用户信息:{JSON.stringify(this.state.user)}</Text>
                </View>

                );

        }else{
            return (
                <View style={[styles.marginTop20,styles.textContainer]}>
                {itemsViews}
                </View>

                );

        }
    }
}

const USER_MODEL =
{
    1:{name:'rongrong',age:18},
    2:{name:'dada',age:18},
}

class Detail extends Component{

    constructor(props) {
        super(props);
        this.state = {
            id:null
        };
    }

    componentDidMount() {
        //这里获取从FirstPageComponent传递过来的参数: id
        this.setState({
            id: this.props.id
        });
    }
    handleClick(){
        let {navigator} = this.props;
        let getUser = this.props.getUser;
        if(getUser){
            let user = USER_MODEL[this.props.id];
            getUser(user);
        }
        if(navigator){
            navigator.pop();
        }
    }
    render(){

        return(
            <View style = {styles.marginTop20}>
                <Text style = {styles.textStyle} onPress ={this.handleClick.bind(this)}>点击我可以回去</Text>
                <Text style = {styles.textStyle} >'id的值为':{this.state.id}</Text>
            </View>
            );
    }
}

const styles = StyleSheet.create({
        flex:{flex:1},
        marginTop20:{
            marginTop:20,
        },
        textContainer:{
          alignItems:'center',

        },
        textStyle:{
            fontSize:18,
            color:'rgb(45,145,208)',
            marginTop:20,
        },
});

AppRegistry.registerComponent('LDNavi', () => LDNavi);
