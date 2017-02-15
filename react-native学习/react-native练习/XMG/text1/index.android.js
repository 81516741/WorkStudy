/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
    AppRegistry,
} from 'react-native';

import App from './Component/app'

class text1 extends Component {
    render() {
        return (
            <App/>
        );
    }
}
AppRegistry.registerComponent('text1', () => text1);
