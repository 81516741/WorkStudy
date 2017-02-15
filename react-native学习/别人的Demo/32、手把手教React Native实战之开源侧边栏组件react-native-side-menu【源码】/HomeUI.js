/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    Image,
    TouchableOpacity,
    View,
} from 'react-native';

import SideMenu from 'react-native-side-menu';

import Menu from './Menu.js';//导入 菜单 组件

const uri_image_menu = 'http://image18-c.poco.cn/mypoco/myphoto/20160605/09/17351665220160605093956066.png';

export default class HomeUI extends Component {

    // state = {
    //     isOpen: false,
    //     selectedItem: 'About',
    // };

    constructor(props) {
        super(props);
        this.state = {
            isOpen: false,
            selectedItem: 'About',
        };
    }



    toggle() {
        this.setState({
            isOpen: !this.state.isOpen,
        });
    }

    updateMenuState(isOpen) {
        this.setState({ isOpen: isOpen });
    }

    onMenuItemSelected = (item) => {
        this.setState({
            isOpen: false,
            selectedItem: item,
        });
    }
    
    
    

    render() {
        const menu = <Menu onItemSelected={this.onMenuItemSelected} />;

        return (
            <SideMenu
                menu={menu}
                isOpen={this.state.isOpen}
                onChange={(isOpen) => this.updateMenuState(isOpen) }>
                <View style={styles.container}>
                    <Text style={styles.welcome}>
                        Welcome to React Native!
                    </Text>
                    <Text style={styles.instructions}>
                        To get started, edit index.android.js
                    </Text>
                    <Text style={styles.instructions}>
                        Press Cmd+R to reload, {'\n'}
                        Cmd+Control+Z for dev menu
                    </Text>
                    <Text style={[styles.instructions, { color: 'red' }]}>
                        当前选中的菜单是: {this.state.selectedItem}
                    </Text>
                </View>

                <Button style={styles.button} onPress={() => this.toggle() }>
                    <Image
                        source={{ uri: uri_image_menu, width: 32, height: 32, }} />
                </Button>

            </SideMenu>
        );
    }



}


class Button extends Component {
    handlePress(e) {
        if (this.props.onPress) {
            this.props.onPress(e);
        }
    }

    render() {
        return (
            <TouchableOpacity
                onPress={this.handlePress.bind(this) }
                style={this.props.style}>
                <Text>{this.props.children}</Text>
            </TouchableOpacity>
        );
    }
}


const styles = StyleSheet.create({

    button: {
        position: 'absolute',
        top: 20,
        padding: 10,
    },
    caption: {
        fontSize: 20,
        fontWeight: 'bold',
        alignItems: 'center',
    },
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
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



});



