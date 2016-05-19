//
//  CustomSegmentedControlManager.m
//  CustomSegmentedControl
//
//  Created by Ran Greenberg on 15/05/2016.
//  Copyright © 2016 Wix. All rights reserved.
//

#import "CustomSegmentedControlManager.h"
#import "UIView+React.h"

#define LINE_SELECTED_EXTRA_PADDING_WIDTH       4
#define LINE_SELECTED_MARGIN_TOP                2

#define DEFAULT_LINE_SELECTED_HEIGHT            2
#define DEFAULT_ANIMATION_DURATION              0.2
#define DEFAULT_ANIMATION_DAMPING               0
#define DEFAULT_FONT_SIZE                       14
#define DEFAULT_LINE_COLOR                      [UIColor blackColor]

#define STYLE_LINE_SELECTED_HEIGHT              @"lineSelectedHeight"
#define STYLE_FONT_SIZE                         @"fontSize"
#define STYLE_SEGMENT_BACKGROUND_COLOR          @"segmentBackgroundColor"
#define STYLE_SEGMENT_TEXT_COLOR                @"segmentTextColor"
#define STYLE_LINE_COLOR                        @"lineColor"
#define STYLE_SELECTED_LINE_ALIGN               @"alignSelectedLine"

#define ANIMATION_DAMPING                       @"damping"
#define ANIMATION_DURATION                      @"duration"


//@implementation RCTConvert(CustomSegmentedSelectedLine)

//RCT_ENUM_CONVERTER(CustomSegmentedSelectedLine, (@{
//                                        @"top": @(CustomSegmentedSelectedLineAlignTop),
//                                        @"bottom": @(CustomSegmentedSelectedLineAlignBottom),
//                                        @"text": @(CustomSegmentedSelectedLineAlignText)
//                                        }), CustomSegmentedSelectedLineAlignText, integerValue)
//
//@end


@interface CustomSegmentedControl : UIView

@property (nonatomic, strong) NSArray<NSString*> *segmentedStrings;
@property (nonatomic, strong) NSMutableArray<UIButton*> *buttons;
@property (nonatomic, strong) NSMutableArray<UIView*> *lines;
@property (nonatomic) NSInteger selectedItem;

// style
@property (nonatomic) CGFloat lineSelectedHeight;
@property (nonatomic) CGFloat segmentedFontSize;
@property (nonatomic, strong) UIColor *segmentBackgroundColor;
@property (nonatomic, strong) UIColor *segmentTextColor;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic) BOOL stickToBottom;

// animation
@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) CGFloat animationDamping;

// callbacks
@property (nonatomic, copy) RCTDirectEventBlock selectedWillChange;
@property (nonatomic, copy) RCTDirectEventBlock selectedDidChange;

@property (nonatomic, strong) NSDictionary *segmentedStyle;
@property (nonatomic, strong) NSDictionary *animation;

@end


@implementation CustomSegmentedControl

-(void)setSegmentedStyle:(NSDictionary *)segmentedStyle {
    _segmentedStyle = segmentedStyle;
    
    // STYLE_LINE_SELECTED_HEIGHT
    id lineSelectedHeight = self.segmentedStyle[STYLE_LINE_SELECTED_HEIGHT];
    if (lineSelectedHeight) {
        self.lineSelectedHeight = [RCTConvert CGFloat:lineSelectedHeight];
    }
    
    
    // STYLE_LINE_SELECTED_HEIGHT
    id fontSize = self.segmentedStyle[STYLE_FONT_SIZE];
    if (fontSize) {
        self.segmentedFontSize = [RCTConvert CGFloat:fontSize];
    }
    
    // STYLE_LINE_SELECTED_HEIGHT
    id segmentBackgroundColor = self.segmentedStyle[STYLE_SEGMENT_BACKGROUND_COLOR];
    if (segmentBackgroundColor) {
        self.segmentBackgroundColor = [RCTConvert UIColor:segmentBackgroundColor];
    }
    
    // STYLE_SEGMENT_TEXT_COLOR
    id segmentTextColor = self.segmentedStyle[STYLE_SEGMENT_TEXT_COLOR];
    if (segmentTextColor) {
        self.segmentTextColor = [RCTConvert UIColor:segmentTextColor];
    }
    
    // STYLE_LINE_COLOR
    id lineColor = self.segmentedStyle[STYLE_LINE_COLOR];
    if (lineColor) {
        self.lineColor = [RCTConvert UIColor:lineColor];
    }
    
//    // STYLE_LINE_STICK_TO_BOTTOM
//    id stickToBottom = self.segmentedStyle[STYLE_LINE_STICK_TO_BOTTOM];
//    if (stickToBottom) {
//        self.stickToBottom = [RCTConvert BOOL:stickToBottom];
//    }
}


-(void)setAnimation:(NSDictionary *)animation {
    _animation = animation;
    
    // ANIMATION_DURATION
    id animationDuration = self.animation[ANIMATION_DURATION];
    if (animationDuration) {
        self.animationDuration = [RCTConvert CGFloat:animationDuration];
    }
    
    // ANIMATION_DAMPING
    id animationDamping = self.animation[ANIMATION_DAMPING];
    if (animationDamping) {
        self.animationDamping = [RCTConvert CGFloat:animationDamping];
    }
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self){
        self.animationDuration = DEFAULT_ANIMATION_DURATION;
        self.animationDamping = DEFAULT_ANIMATION_DAMPING;
        self.lineSelectedHeight = DEFAULT_LINE_SELECTED_HEIGHT;
        self.segmentedFontSize = DEFAULT_FONT_SIZE;
        self.lineColor = DEFAULT_LINE_COLOR;
        self.stickToBottom = NO;
        
        self.buttons = [[NSMutableArray alloc] init];
        self.lines = [[NSMutableArray alloc] init];
    }
    
    return self;
}


-(void)reactSetFrame:(CGRect)frame {
    [super reactSetFrame:frame];
    
    if (self.segmentedStrings && self.segmentedStrings.count > 0) {
        CGFloat buttonWidth = self.bounds.size.width / self.segmentedStrings.count;
        
        for (int i=0; i < self.segmentedStrings.count; i++) {
            
            CGFloat buttonX = buttonWidth * i;
            UIButton *btn = (self.buttons.count > i) ? self.buttons[i] : nil;
            
            if (!btn ) {
                btn = [UIButton buttonWithType:UIButtonTypeSystem];
                [self.buttons addObject:btn];
            }
            
            UIView *line = (self.lines.count > i) ? self.lines[i] : nil;
            if (!line) {
                line = [[UIView alloc] init];
                [self.lines addObject:line];
            } else  {
                btn.frame = CGRectMake(buttonX, self.bounds.origin.y, buttonWidth, self.bounds.size.height);
                
                CGRect lineFrame = btn.frame;
                CGSize btnTitleSize = [btn.titleLabel.text sizeWithFont:btn.titleLabel.font];
                lineFrame.origin.x = btn.center.x - (lineFrame.size.width/2) ;
                lineFrame.origin.y = btn.titleLabel.frame.origin.y + (btnTitleSize.height/2) + 2;
                line.frame = lineFrame;
                continue;
            }
            
            btn.frame = CGRectMake(buttonX, self.bounds.origin.y, buttonWidth, self.bounds.size.height);
            [btn setTitle:self.segmentedStrings[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:self.segmentedFontSize]];
            btn.backgroundColor = self.segmentBackgroundColor;
            [btn setTitleColor:self.segmentTextColor forState:UIControlStateNormal];
            
            [self addSubview:btn];
            
            CGRect lineFrame = btn.frame;
            lineFrame.size.height = self.lineSelectedHeight;
            CGSize btnTitleSize = [btn.titleLabel.text sizeWithFont:btn.titleLabel.font];
            lineFrame.size.width = btnTitleSize.width + LINE_SELECTED_EXTRA_PADDING_WIDTH;
            lineFrame.origin.x = btn.center.x - (lineFrame.size.width/2) ;
            lineFrame.origin.y = btn.titleLabel.frame.origin.y + (btnTitleSize.height/2) + LINE_SELECTED_MARGIN_TOP;
            
            if (self.selectedItem != i) {
                lineFrame.size.width = 0;
            }
            
            line.frame = lineFrame;
            line.backgroundColor = self.lineColor;
            line.layer.cornerRadius = line.bounds.size.height/2;
            [self addSubview:line];
        }
        
        for (UIView *line in self.lines) {
            [self bringSubviewToFront:line];
        }
    }
}


-(void)buttonSelected:(UIButton*)buttonPressed {
    NSInteger previousSelectedItem = self.selectedItem;
    self.selectedItem = [self.buttons indexOfObject:buttonPressed];
    
    if (previousSelectedItem == self.selectedItem) {
        return;
    }
    
    if (_selectedWillChange) {
        _selectedWillChange(@{@"selected" : @(self.selectedItem)});
    }
    
    for (int i=0; i<self.buttons.count; i++) {
        UIButton *button = self.buttons[i];
        UIView *line = self.lines[i];
        
        CGRect lineFrame = line.frame;
        if (self.selectedItem != i) {
            lineFrame.size.width = 0;
        }
        else {
            CGSize btnTitleSize = [buttonPressed.titleLabel.text sizeWithFont:buttonPressed.titleLabel.font];
            lineFrame.size.width = btnTitleSize.width;
        }
        
        line.center = CGPointMake(button.center.x, line.center.y);
        
        CGPoint center = button.center;
        center.y = line.center.y;
        
        CGFloat damping = (button == buttonPressed) ? self.animationDamping : 0;
        
        [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:damping initialSpringVelocity:0 options:0 animations:^{
            
            line.frame = lineFrame;
            line.center = center;
            
        } completion:^(BOOL finished) {
            if (_selectedDidChange && button == buttonPressed) {
                _selectedDidChange(@{@"selected" : [NSNumber numberWithInteger:self.selectedItem], @"finished" : [NSNumber numberWithBool:finished]});
            }
        }];
    }
}


@end


@implementation CustomSegmentedControlManager


RCT_EXPORT_MODULE()


- (UIView *)view {
    return [CustomSegmentedControl new];
}


RCT_EXPORT_VIEW_PROPERTY(enabled, BOOL)

RCT_REMAP_VIEW_PROPERTY(textValues, segmentedStrings, NSArray)
RCT_REMAP_VIEW_PROPERTY(selected, selectedItem, NSInteger)
RCT_REMAP_VIEW_PROPERTY(segmentedStyle, segmentedStyle, NSDictionary)
RCT_REMAP_VIEW_PROPERTY(animation, animation, NSDictionary)

RCT_REMAP_VIEW_PROPERTY(onSelectedWillChange, selectedWillChange, RCTDirectEventBlock)
RCT_REMAP_VIEW_PROPERTY(onSelectedDidChange, selectedDidChange, RCTDirectEventBlock)


@end
