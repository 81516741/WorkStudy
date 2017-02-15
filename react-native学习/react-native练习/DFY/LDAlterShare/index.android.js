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
  DatePickerAndroid,
  TimePickerAndroid,
  View
} from 'react-native';

class LDAlterShare extends Component {
  constructor(props) {
    super(props);

    this.state = {
      result: 'default',
    };

  }


  componentWillMount() {
    let self = this;
    let theHour = 18;
    let theMinute = 55;
    let is24Hour = false;
    let option = {
      hour: theHour,
      minute: theMinute,
      is24Hour: is24Hour,
    };

    TimePickerAndroid.open(option).then(
      result => {
        if (result.action !== TimePickerAndroid.timeSetAction) {
          self.setState(
            {
              result: '用户没有选择时间',
            }
          );

        } else {
          self.setState(
            {
              result: '用户选择了' + result.hour + '小时' + result.minute + '分钟',
            }
          );

        }


      }
    ).catch(
      error => {
        self.setState(
          {
            result: '出错了:' + error,
          }
        );

      }
      );

  }


  render() {
    return (
      <View style={[styles.flex, styles.center]}>
        <Text style={{ fontSize: 18, color: 'red' }}>返回结果：{this.state.result}</Text>
      </View>
    );
  }
  }


  const styles = StyleSheet.create({
  flex: {
    flex: 1,
  },
  center: {
    justifyContent: 'center',
    alignItems: 'center',
  }

  });


AppRegistry.registerComponent('LDAlterShare', () => LDAlterShare);
