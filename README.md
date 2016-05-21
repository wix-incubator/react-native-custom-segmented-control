# react-native-custom-segmented-control
Native UI component for Segmented Control with custom style


## Installation

- Install using `npm`:

	```
	npm i react-native-custom-segmented-control
	```

- Locate the module lib folder in your node modules:
	`PROJECT_DIR/node_modules/react-native-custom-segmented-control/lib`.

- Drag the `CustomSegmentedControl.xcodeproj` project file into your project

- Add `libCustomSegmentedControl.a` to your target's **Linked Frameworks and Libraries**.

## How To Use
Require the native component:

```js
import {CustomSegmentedControl} from 'react-native-custom-segmented-control'
```

Now use it in your jsx inside your `View`:

```jsx
<CustomSegmentedControl style={{
                                          flex:1,
                                          backgroundColor: 'transparent'
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
                                                   selectedLineAlign: 'bottom', // top/bottom/text
                                                   selectedLineMode: 'text' // full/text
                                                 }}
                                  animation={{
                                              duration: 0.4,
                                              damping: 0.6
                                              }}
                                  onSelectedWillChange={(event)=> {
                                  }}
                                  onSelectedDidChange={(event)=> {
                                  }}

          />
```

##Properties

Attribute | Description
-------- | -----------
textValues | [Array] Array of strings which will be presented on the segmented control
selected | [int] The selected segment
onSelectedWillChange | [function] callback function will be called **before** the selected animation will take place
onSelectedDidChange | [function] callback function will be called **after** the selected animation will take place
animation | [Object] see animation properties
segmentedStyle | [Object] see segmentedStyle properties

                                                 
##Style Properties
Attribute | Description
--------- | -----------
lineSelectedHeight | [float] The selected line height. Default is 2
fontSize | [float] The segmented control text font size. Default is 14
segmentBackgroundColor | [Color] The segmented control background color. Default is `'black'`
segmentTextColor | [Color] The segmented control text color. Default is system default (blue)
segmentFontFamily | [Font] The segmented control font. Default is system default
lineColor | [Color] The selected line color. Default is 'black'
selectedLineAlign | [`'top'`/`'bottom'`/`'text'`] The selected line vertical alignment. Defualt is `'text'`
selectedLineMode | [`'full'`/`'text'`] The selected line mode. For determine if the line will be text width of full button width. Default is `'text'` 
 
 ##Animation Properties
Attribute | Description
--------- | -----------
duration | [float] The animation duration. Default is 0.2 sec
damping | [float] The damping ratio for the spring animation. Default is 0 (no damping)
