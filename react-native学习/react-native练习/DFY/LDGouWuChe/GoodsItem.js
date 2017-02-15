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
  Image,
    TouchableOpacity,
  View
} from 'react-native';

import Dimensions from 'Dimensions';

const Width = Dimensions.get('window').width;
const Height = Dimensions.get('window').height;

export default class GoodsItem extends Component{

    static defaultProps = {
        url: 'https:',
        title: '',
    };  // 注意这里有分号
    static propTypes = {
        url: React.PropTypes.string.isRequired,
        title: React.PropTypes.string.isRequired,
    };  // 注意这里有分号

    constructor(props){
        super(props);
        this.state = {
            url: 'https://gss0.bdstatic.com/5eR1dDebRNRTm2_p8IuM_a/res/img/richanglogo168_24.png',
            title: '默认标题',
        };
    };

    onClick(){
        alert('点击了');

    };

    render(){
        return(
            <View style = {[styles.size,styles.center,styles.flex]}>
                <View style={[styles.fill_margin5,styles.center]}>
                    <View style = {[styles.fill]}>
                        <TouchableOpacity
                        onPress={this.props.press}>
                            <Image resizeMode='contain'
                            style={styles.img}
                            source={{ uri: this.props.url }}
                            >
                            </Image>
                        </TouchableOpacity>
                    </View>
                    <View style = {[styles.item_text,styles.center]}>
                        <Text>{this.props.title}</Text>
                    </View>
                </View>
            </View>

            );
    }
}

const styles = StyleSheet.create({
    flex:{
      flex:1,
    },
    size:{
        width:Width * 0.4,
        height:Width * 0.4,
        margin:Width * 0.05,
        backgroundColor:'rgba(45,245,202,0.2)'
    },
    center:{
        alignItems:'center',
        justifyContent:'center',
    },
    textRed:{
        backgroundColor:'red',
                },
    textGray:{
        backgroundColor:'gray'
    },
    fill_margin5:{
        flex:1,
        alignSelf:'stretch',
        margin:5,
    },
    fill:{
        flex:1,
        alignSelf:'stretch',
    },
    img:{
        height:Width * 0.4 - 10 - 30,
    },
    item_text:{
        height:30,
        backgroundColor:'rgba(25,123,35,0.6)',
        width:Width * 0.4,
        marginBottom:-5,
    },

});

