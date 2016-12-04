/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */
import _ from 'lodash';
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




class example extends Component {

  constructor(props) {
    super(props);
    this.state = {
      segmentedText: [
        ['FIRST','SECOND', 'THIRD'],
        ['ORDERS','HOTELS', 'OPTIONS'],
        ['TOP FREE','TOP PAID', 'TOP GROSSING'],
        ['ORDERS','HOTELS', 'OPTIONS','TOP FREE','TOP PAID'],
        ['ORDERS','HOTELS', 'OPTIONS','TOP FREE','TOP PAID']
      ],
      selectedArray: [0,2,1,4,3]
    };
  }


  render() {
    return (
      <View style={styles.container}>
        <View style={{ height: 300}}>

          <CustomSegmentedControl
            style={{
              flex:1,
              backgroundColor: 'white',
              marginVertical: 8
            }}
            textValues={this.state.segmentedText[0]}
            selected={this.state.selectedArray[0]}
            segmentedStyle={{
              selectedLineHeight: 2,
              fontSize:17,
              fontWeight: 'bold', // bold, italic, regular (default)
              segmentBackgroundColor: 'transparent',
              segmentTextColor: '#7a92a5',
              selectedLineColor: '#00adf5',
              selectedLineAlign: 'bottom', // top/bottom/text
              selectedLineMode: 'text', // full/text
              selectedTextColor: 'black',
              selectedLinePaddingWidth: 30,
              segmentFontFamily: 'system-font-bold'
            }}
            animation={{
              duration: 0.5,
              damping: 0.5,
              animationType: 'relative-open',
              initialDampingVelocity: 1,
              relativeAnimation: true
            }}
            onSelectedWillChange={(event)=> {
            }}
            onSelectedDidChange={(event)=> {
            }}

          />

          <CustomSegmentedControl
            style={{
              flex:1,
              backgroundColor: 'white',
              marginVertical: 8
            }}
            textValues={this.state.segmentedText[0]}
            selected={this.state.selectedArray[0]}
            segmentedStyle={{
              selectedLineHeight: 2,
              fontSize:17,
              fontWeight: 'bold', // bold, italic, regular (default)
              segmentBackgroundColor: '#95a5a6',
              segmentTextColor: '#7a92a5',
              selectedLineColor: '#00adf5',
              selectedLineAlign: 'bottom', // top/bottom/text
              selectedLineMode: 'text', // full/text
              selectedTextColor: 'black',
              selectedLinePaddingWidth: 30,
              segmentFontFamily: 'system-font-bold'
            }}
            animation={{
              duration: 0.4,
              damping: 0.5,
              animationType: 'middle-line',
              initialDampingVelocity: 1,
              relativeAnimation: true
            }}
            onSelectedWillChange={(event)=> {
            }}
            onSelectedDidChange={(event)=> {
            }}

          />

          <CustomSegmentedControl
            style={{flex: 1, backgroundColor: 'transparent'}}
            selected={this.state.selectedArray[1]}
            segmentedStyle={{
              selectedLineHeight: 2,
              fontSize:20,
              segmentBackgroundColor: '#7d5642',
              segmentTextColor: '#cccccc',
              selectedLineColor: '#6d8b4b',
              segmentFontFamily: 'Copperplate',
            }}
            animation={{
              duration: 0.7,
              damping: 0.4,
            }}
            textValues={this.state.segmentedText[1]}
          />

          <CustomSegmentedControl
            style={{flex: 1,
              backgroundColor: '#333333',
              //borderRadius: 6,
              marginVertical: 8,
              //marginHorizontal: 4
            }}
            selected={this.state.selectedArray[2]}
            segmentedStyle={{
              selectedLineHeight: 3,
              fontSize:15,
              segmentBackgroundColor: 'transparent',
              segmentTextColor: '#75c776',
              selectedTextColor: '#4f9f5b',
              selectedLineColor: '#acefac',
              segmentFontFamily: 'Menlo',
              selectedLineAlign: 'bottom',

            }}
            animation={{
              duration: 0.5,
              damping: 0.8
            }}
            textValues={this.state.segmentedText[2]}
          />

          <CustomSegmentedControl
            style={{ flex: 1,backgroundColor: '#3C3741', marginVertical: 8}}
            segmentedStyle={{
              selectedLineHeight: 5,
              fontSize:14,
              segmentBackgroundColor: '#cfc2cf',
              segmentTextColor: '#ffffff',
              selectedLineColor: '#e06ea2',
              selectedLineAlign: 'top',
              segmentFontFamily: 'Verdana',
              selectedLineMode: 'full'

            }}
            selected={this.state.selectedArray[3]}
            animation={{
              duration: 0.4,
              damping: 0.4,
              dampingInitialVelocity:0
            }}
            textValues={this.state.segmentedText[3]}
          />

          <CustomSegmentedControl
            style={{ flex: 1,
              backgroundColor: '#EFE0B1',
              marginVertical: 8,
              marginHorizontal: 4,
            }}
            segmentedStyle={{
              selectedLineHeight: 7,
              fontSize:12,
              segmentBackgroundColor: 'transparent',
              segmentTextColor: '#60646D',
              selectedLineColor: '#953163',
              selectedLineAlign: 'top',
              selectedLineMode: 'full'
            }}
            selected={this.state.selectedArray[4]}
            animation={{
              duration: 0.9,
              damping: 0.4,
              animationType: 'middle-line'
            }}
            textValues={this.state.segmentedText[4]}
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
