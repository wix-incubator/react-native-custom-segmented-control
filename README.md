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
                              	// Will WOOHOO
                              }}
                              onSelectedDidChange={(event)=> {
                                 // Did WOOHOO
                              }}

        />
```
