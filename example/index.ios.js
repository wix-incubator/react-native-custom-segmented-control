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
  View,
  Dimensions,
  UIManager
} from 'react-native';

import {CustomSegmentedControl} from 'react-native-custom-segmented-control'
var {height, width} = Dimensions.get('window');


class example extends Component {
  render() {
    return (
      <View style={styles.container}>


        <CustomSegmentedControl style={{
                                        width: width,
                                        height:40,
                                        backgroundColor: 'transparent',
                                        marginTop: 20
                                        }}
                                values={['ORDERS','HOTELS' ]}
                                tintColor={"#ff0000"}
                                selected={0}
                                segmentedStyle={{
                                                 lineSelectedHeight: 1.5,
                                                 fontSize:17,
                                                 segmentBackgroundColor: 'purple',
                                                 segmentTextColor: 'green',
                                                 segmentFontFamily: 'Cochin'
                                                 }}
                                animationDuration={0.2}

                                onSelectedWillChange={(event)=> {
                                  //console.warn('will' + event.nativeEvent.selected);
                                }}
                                onSelectedDidChange={(event)=> {
                                  //console.warn('did' + event.nativeEvent.selected);
                                }}

        />

        <CustomSegmentedControl style={{width: width, height:40, backgroundColor: 'white', marginTop: 40}}
                                values={['ORDERS','HOTELS', 'OPTIONS']}
                                tintColor={"black"}
                                lineSelectedHeight={1.5}/>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'flex-start',
    alignItems: 'center',
    backgroundColor: 'white'
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

AppRegistry.registerComponent('example', () => example);
