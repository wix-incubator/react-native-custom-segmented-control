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
//var {height, width} = Dimensions.get('window');


class example extends Component {
  render() {
    return (
      <View style={styles.container}>
        <View style={{ height: 300}}>
          <CustomSegmentedControl style={{
                                          flex:1,
                                          backgroundColor: '#D4D4D4',
                                          marginVertical: 8
                                        }}
                                  textValues={['ORDERS','HOTELS' ]}
                                  selected={0}
                                  segmentedStyle={{
                                                   lineSelectedHeight: 1.5,
                                                   fontSize:17,
                                                   segmentBackgroundColor: 'transparent',
                                                   segmentTextColor: 'black',
                                                   lineColor: 'black',
                                                   selectedLineAlign: 'bottom', // top/bottom/text
                                                   selectedLineMode: 'full' // full/text
                                                 }}
                                  animation={{
                                              duration: 0.6,
                                              damping: 0.7
                                              }}
                                  onSelectedWillChange={(event)=> {
                                  }}
                                  onSelectedDidChange={(event)=> {
                                  }}

          />

          <CustomSegmentedControl style={{flex: 1, backgroundColor: '#2C82C9'}}
                                  selected={2}
                                  segmentedStyle={{
                                         lineSelectedHeight: 2,
                                         fontSize:20,
                                         segmentBackgroundColor: 'transparent',
                                         segmentTextColor: 'black',
                                         segmentFontFamily: 'Copperplate',
                                         lineColor: '#8A2D3C',
                                         }}
                                  animation={{
                                              duration: 0.7,
                                              damping: 0.2
                                              }}
                                  textValues={['ORDERS','HOTELS', 'OPTIONS']}
          />

          <CustomSegmentedControl style={{flex: 1,
                                          backgroundColor: '#83D6DE',
                                          borderRadius: 20,
                                          marginVertical: 8,
                                          marginHorizontal: 4
                                         }}
                                  selected={1}
                                  segmentedStyle={{
                                                 lineSelectedHeight: 1,
                                                 fontSize:15,
                                                 segmentBackgroundColor: 'transparent',
                                                 segmentTextColor: 'blue',
                                                 segmentFontFamily: 'Menlo',
                                                 lineColor: 'red'
                                                 }}
                                  animation={{
                                              duration: 0.3,
                                              damping: 0.8
                                              }}
                                  textValues={['TOP FREE','TOP PAID', 'TOP GROSSING']}
          />

          <CustomSegmentedControl style={{ flex: 1,backgroundColor: '#3C3741', marginVertical: 8}}
                                  segmentedStyle={{
                                                  lineSelectedHeight: 3,
                                                  fontSize:12,
                                                  segmentBackgroundColor: 'transparent',
                                                  segmentTextColor: '#E0E4CC',
                                                  segmentFontFamily: 'Verdana',
                                                  lineColor: '#EB9532',
                                                 selectedLineAlign: 'top'
                                                 }}
                                  animation={{
                                              duration: 0.3,
                                              damping: 0.4
                                              }}
                                  textValues={['ORDERS','HOTELS', 'OPTIONS','TOP FREE','TOP PAID']}
          />

          <CustomSegmentedControl style={{ flex: 1,
                                           backgroundColor: '#EFE0B1',
                                           marginVertical: 8,
                                           marginHorizontal: 4,
                                        }}
                                  segmentedStyle={{
                                                  lineSelectedHeight: 3,
                                                  fontSize:12,
                                                  segmentBackgroundColor: 'transparent',
                                                  segmentTextColor: '#60646D',
                                                  lineColor: '#953163',
                                                  selectedLineAlign: 'top',
                                                  selectedLineMode: 'full'
                                                 }}
                                  animation={{
                                              duration: 0.5,
                                              damping: 0.6
                                              }}
                                  textValues={['ORDERS','HOTELS', 'OPTIONS','TOP FREE','TOP PAID']}
          />

        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 20,
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
