/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
    AppRegistry,
} from 'react-native';

import ADView from './ADView'

class LDAD extends Component {
    render() {return (<ADView />)}
}

AppRegistry.registerComponent('LDAD', () => LDAD);
