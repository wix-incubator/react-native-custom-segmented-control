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
                                          backgroundColor: 'green'
                                          }}
                                  textValues={['ORDERS','HOTELS' ]}
                                  selected={0}
                                  segmentedStyle={{
                                                   lineSelectedHeight: 1.5,
                                                   fontSize:16,
                                                   segmentBackgroundColor: 'transparent',
                                                   segmentTextColor: 'black',
                                                   segmentFontFamily: 'Cochin',
                                                   lineColor: 'black',
                                                   alignSelectedLine: 'bottom', // top/bottom/text
                                                   selectedLineMode: 'full' // full/ text
                                                 }}
                                  animation={{
                                              duration: 0.4,
                                              damping: 0.6
                                              }}
                                  onSelectedWillChange={(event)=> {
                                    //console.warn('will' + event.nativeEvent.selected);
                                  }}
                                  onSelectedDidChange={(event)=> {
                                    //console.warn(111);
                                  }}

          />

          <CustomSegmentedControl style={{flex: 1, backgroundColor: 'transparent'}}
                                  selected={2}
                                  segmentedStyle={{
                                         lineSelectedHeight: 1,
                                         fontSize:12,
                                         segmentBackgroundColor: 'transparent',
                                         segmentTextColor: 'black',
                                         segmentFontFamily: 'Cochin',
                                         lineColor: 'black'
                                         }}
                                  textValues={['ORDERS','HOTELS', 'OPTIONS']}
          />

          <CustomSegmentedControl style={{flex: 1,
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
                                                 segmentFontFamily: 'Cochin',
                                                 lineColor: 'red'
                                                 }}
                                  textValues={['TOP FREE','TOP PAID', 'TOP GROSSING']}
          />

          <CustomSegmentedControl style={{ flex: 1,backgroundColor: '#3C3741'}}
                                  segmentedStyle={{

                                                  lineSelectedHeight: 1,
                                                  fontSize:12,
                                                  segmentBackgroundColor: 'transparent',
                                                  segmentTextColor: '#E0E4CC',
                                                  segmentFontFamily: 'Cochin',
                                                  lineColor: '#E0E4CC'
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
