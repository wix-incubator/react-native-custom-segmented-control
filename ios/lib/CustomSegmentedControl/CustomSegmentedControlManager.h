//
//  CustomSegmentedControlManager.h
//  CustomSegmentedControl
//
//  Created by Ran Greenberg on 15/05/2016.
//  Copyright © 2016 Wix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTViewManager.h"
#import "RCTConvert.h"



typedef NS_ENUM(NSInteger, CustomSegmentedSelectedLineAlign) {
    CustomSegmentedSelectedLineAlignTop,
    CustomSegmentedSelectedLineAlignBottom,
    CustomSegmentedSelectedLineAlignText
};

typedef NS_ENUM(NSInteger, CustomSegmentedSelectedLineMode) {
    CustomSegmentedSelectedLineModeFull,
    CustomSegmentedSelectedLineModeText
};

@interface RCTConvert(CustomSegmentedSelectedLineAlign)

+ (CustomSegmentedSelectedLineAlign)CustomSegmentedSelectedLineAlign:(id)json;

@end

@interface RCTConvert(CustomSegmentedSelectedLineMode)

+ (CustomSegmentedSelectedLineMode)CustomSegmentedSelectedLineMode:(id)json;

@end

@interface CustomSegmentedControlManager : RCTViewManager

@end
