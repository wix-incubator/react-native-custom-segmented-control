//
//  CustomSegmentedControlManager.h
//  CustomSegmentedControl
//
//  Created by Ran Greenberg on 15/05/2016.
//  Copyright © 2016 Wix. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<React/RCTViewManager.h>)
#import <React/RCTViewManager.h>
#import <React/RCTConvert.h>
#else
#import "RCTViewManager.h"
#import "RCTConvert.h"
#endif



typedef NS_ENUM(NSInteger, CustomSegmentedSelectedLineAlign) {
    CustomSegmentedSelectedLineAlignTop,
    CustomSegmentedSelectedLineAlignBottom,
    CustomSegmentedSelectedLineAlignText
};

typedef NS_ENUM(NSInteger, CustomSegmentedSelectedLineMode) {
    CustomSegmentedSelectedLineModeFull,
    CustomSegmentedSelectedLineModeText
};

typedef NS_ENUM(NSInteger, CustomSegmentedSelectedAnimationType) {
    CustomSegmentedSelectedAnimationTypeDefault,
    CustomSegmentedSelectedAnimationTypeMiddleLine,
    CustomSegmentedSelectedAnimationTypeCloseAndAndOpen,
    CustomSegmentedSelectedRelativeOpen
};

@interface RCTConvert(CustomSegmentedSelectedLineAlign)

+ (CustomSegmentedSelectedLineAlign)CustomSegmentedSelectedLineAlign:(id)json;

@end

@interface RCTConvert(CustomSegmentedSelectedLineMode)

+ (CustomSegmentedSelectedLineMode)CustomSegmentedSelectedLineMode:(id)json;

@end

@interface RCTConvert(CustomSegmentedSelectedAnimationType)

+ (CustomSegmentedSelectedAnimationType)CustomSegmentedSelectedAnimationType:(id)json;

@end

@interface CustomSegmentedControlManager : RCTViewManager

@end
