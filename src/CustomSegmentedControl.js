import * as _ from 'lodash';
import React, {Component} from 'react';
import {
	requireNativeComponent,
	processColor
} from 'react-native';

const NativeCustomSegmentedControl = requireNativeComponent('CustomSegmentedControl', null);

export default class CustomSegmentedControl extends Component {
	render() {
		const transformedProps = {...this.props};
		_.update(transformedProps, 'segmentedStyle.segmentBackgroundColor', (c) => processColor(c));
		_.update(transformedProps, 'segmentedStyle.segmentTextColor', (c) => processColor(c));
		_.update(transformedProps, 'segmentedStyle.selectedLineColor', (c) => processColor(c));
		_.update(transformedProps, 'segmentedStyle.selectedTextColor', (c) => processColor(c));
		_.update(transformedProps, 'segmentedStyle.segmentHighlightTextColor', (c) => processColor(c));
		return <NativeCustomSegmentedControl {...transformedProps}/>
	}
}
