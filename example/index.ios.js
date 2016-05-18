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
                                        height:38,
                                        backgroundColor: '#7BB0A6',
                                        marginTop: 20,
                                        }}
                                values={['ORDERS','HOTELS' ]}
                                tintColor={"black"}
                                selected={0}
                                segmentedStyle={{
                                                 lineSelectedHeight: 1,
                                                 fontSize:16,
                                                 segmentBackgroundColor: 'transparent',
                                                 segmentTextColor: 'black',
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

        <CustomSegmentedControl style={{width: width, height:40, backgroundColor: 'transparent', marginTop: 40, }}
                                selected={2}
                                segmentedStyle={{
                                                 lineSelectedHeight: 1,
                                                 fontSize:12,
                                                 segmentBackgroundColor: 'transparent',
                                                 segmentTextColor: 'black',
                                                 segmentFontFamily: 'Cochin'
                                                 }}
                                values={['ORDERS','HOTELS', 'OPTIONS']}
                                tintColor={"black"}
                                />

        <CustomSegmentedControl style={{width:width,
                                        height:40,
                                        backgroundColor: '#83D6DE',
                                        //marginTop: 40,
                                        borderRadius: 20,
                                        }}
                                selected={1}
                                segmentedStyle={{
                                                 lineSelectedHeight: 1,
                                                 fontSize:12,
                                                 segmentBackgroundColor: 'transparent',
                                                 segmentTextColor: 'blue',
                                                 segmentFontFamily: 'Cochin'
                                                 }}
                                values={['TOP FREE','TOP PAID', 'TOP GROSSING']}
                                tintColor={"red"}
        />

        <CustomSegmentedControl style={{width: width, height:40, backgroundColor: '#3C3741', marginTop: 40 }}
                                segmentedStyle={{
                                                 lineSelectedHeight: 1,
                                                 fontSize:12,
                                                 segmentBackgroundColor: 'transparent',
                                                 segmentTextColor: '#E0E4CC',
                                                 segmentFontFamily: 'Cochin'
                                                 }}
                                values={['ORDERS','HOTELS', 'OPTIONS','TOP FREE','TOP PAID']}
                                tintColor={"#E0E4CC"}
        />
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
