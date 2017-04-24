//
//  CustomSegmentedControlManager.m
//  CustomSegmentedControl
//
//  Created by Ran Greenberg on 15/05/2016.
//  Copyright © 2016 Wix. All rights reserved.
//

#import "CustomSegmentedControlManager.h"
#if __has_include(<React/RCTBridgeModule.h>)
#import <React/UIView+React.h>
#else
#import "UIView+React.h"
#endif

#define LINE_SELECTED_MARGIN_TOP                        2

#define DEFAULT_SELECTED_LINE_PADDING_WIDTH             4
#define DEFAULT_SELECTED_LINE_HEIGHT                    2
#define DEFAULT_ANIMATION_DURATION                      0.2
#define DEFAULT_ANIMATION_DAMPING                       0
#define DEFAULT_ANIMATION_DAMPING_INITIAL_VELOCITY      0
#define DEFAULT_FONT_SIZE                               14
#define DEFAULT_LINE_COLOR                              [UIColor blackColor]
#define DEFAULT_SEGMENTED_HIGHLIGHT_COLOR               [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]

#define DEFAULT_SYSTEM_FONT                             @"system-font"
#define DEFAULT_SYSTEM_FONT_BOLD                        @"system-font-bold"

#define STYLE_SELECTED_LINE_HEIGHT                      @"selectedLineHeight"
#define STYLE_SELETCED_LINE_PADDING_WIDTH               @"selectedLinePaddingWidth"
#define STYLE_FONT_SIZE                                 @"fontSize"
#define STYLE_SEGMENT_BACKGROUND_COLOR                  @"segmentBackgroundColor"
#define STYLE_SEGMENT_TEXT_COLOR                        @"segmentTextColor"
#define STYLE_SEGMENT_HIGHLIGHT_TEXT_COLOR              @"segmentHighlightTextColor"
#define STYLE_SELECTED_TEXT_COLOR                       @"selectedTextColor"
#define STYLE_SEGMENT_FONT_FAMILY                       @"segmentFontFamily"
#define STYLE_SELECTED_LINE_COLOR                       @"selectedLineColor"
#define STYLE_SELECTED_LINE_ALIGN                       @"alignSelectedLine"
#define STYLE_SELECTED_LINE_MODE                        @"selectedLineMode"
#define STYLE_SELECTED_LINE_ALIGN                       @"selectedLineAlign"

#define ANIMATION_DAMPING                               @"damping"
#define ANIMATION_DURATION                              @"duration"
#define ANIMATION_TYPE                                  @"animationType"
#define ANIMATION_DAMPING_INITIAL_VELOCITY              @"dampingInitialVelocity"

@implementation RCTConvert(CustomSegmentedSelectedLineAlign)

RCT_ENUM_CONVERTER(CustomSegmentedSelectedLineAlign, (@{
                                                        @"top": @(CustomSegmentedSelectedLineAlignTop),
                                                        @"bottom": @(CustomSegmentedSelectedLineAlignBottom),
                                                        @"text": @(CustomSegmentedSelectedLineAlignText)
                                                        }), CustomSegmentedSelectedLineAlignText, integerValue)

@end

@implementation RCTConvert(CustomSegmentedSelectedLineMode)

RCT_ENUM_CONVERTER(CustomSegmentedSelectedLineMode, (@{
                                                       @"text": @(CustomSegmentedSelectedLineModeText),
                                                       @"full": @(CustomSegmentedSelectedLineModeFull)
                                                       }), CustomSegmentedSelectedLineModeText, integerValue)

@end

@implementation RCTConvert(CustomSegmentedSelectedAnimationType)

RCT_ENUM_CONVERTER(CustomSegmentedSelectedAnimationType, (@{
                                                            @"default": @(CustomSegmentedSelectedAnimationTypeDefault),
                                                            @"middle-line": @(CustomSegmentedSelectedAnimationTypeMiddleLine),
                                                            @"close-and-open": @(CustomSegmentedSelectedAnimationTypeCloseAndAndOpen),
                                                            @"relative-open": @(CustomSegmentedSelectedRelativeOpen)
                                                            }), CustomSegmentedSelectedAnimationTypeDefault, integerValue)

@end



@interface CustomSegmentedControl : UIView

@property (nonatomic, strong) NSMutableArray<UIButton*> *buttons;
@property (nonatomic, strong) NSMutableArray<UIView*> *lines;

// props
@property (nonatomic, strong) NSArray<NSString*> *segmentedStrings;
@property (nonatomic) NSInteger selectedItem;
@property (nonatomic, strong) NSDictionary *segmentedStyle;
@property (nonatomic, strong) NSDictionary *animation;

// style props
@property (nonatomic) CGFloat lineSelectedHeight;
@property (nonatomic) CGFloat segmentedFontSize;
@property (nonatomic) CGFloat selectedLinePaddingWidth;
@property (nonatomic, strong) UIColor *segmentBackgroundColor;
@property (nonatomic, strong) UIColor *segmentTextColor;
@property (nonatomic, strong) UIColor *segmentHighlightTextColor;
@property (nonatomic, strong) NSString *segmentFontFamilyName;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic) CustomSegmentedSelectedLineAlign selectedLineAlign;
@property (nonatomic) CustomSegmentedSelectedLineMode selectedLineMode;
@property (nonatomic) CustomSegmentedSelectedAnimationType customAnimationType;

// animation props
@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) CGFloat animationDamping;
@property (nonatomic) CGFloat initialDampingVelocity;

// callbacks props
@property (nonatomic, copy) RCTDirectEventBlock selectedWillChange;
@property (nonatomic, copy) RCTDirectEventBlock selectedDidChange;

@end


@implementation CustomSegmentedControl

-(void)setSegmentedStyle:(NSDictionary *)segmentedStyle {
    _segmentedStyle = segmentedStyle;
    
    // STYLE_LINE_SELECTED_HEIGHT
    id lineSelectedHeight = self.segmentedStyle[STYLE_SELECTED_LINE_HEIGHT];
    if (lineSelectedHeight) {
        self.lineSelectedHeight = [RCTConvert CGFloat:lineSelectedHeight];
    }
    
    // STYLE_LINE_SELECTED_HEIGHT
    id fontSize = self.segmentedStyle[STYLE_FONT_SIZE];
    if (fontSize) {
        self.segmentedFontSize = [RCTConvert CGFloat:fontSize];
    }
    
    // STYLE_SELETCED_LINE_PADDING_WIDTH
    id selectedLinePaddingWidth = self.segmentedStyle[STYLE_SELETCED_LINE_PADDING_WIDTH];
    if (selectedLinePaddingWidth) {
        self.selectedLinePaddingWidth = [RCTConvert CGFloat:selectedLinePaddingWidth];
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
    
    // STYLE_SEGMENT_HIGHLIGHT_TEXT_COLOR
    id segmentHighlightTextColor = self.segmentedStyle[STYLE_SEGMENT_HIGHLIGHT_TEXT_COLOR];
    if (segmentHighlightTextColor) {
        self.segmentHighlightTextColor = [RCTConvert UIColor:segmentHighlightTextColor];
    }
    
    // STYLE_SEGMENT_FONT_FAMILY
    id segmentFontFamily = self.segmentedStyle[STYLE_SEGMENT_FONT_FAMILY];
    if (segmentFontFamily) {
        self.segmentFontFamilyName = segmentFontFamily;
    }
    
    // STYLE_LINE_COLOR
    id lineColor = self.segmentedStyle[STYLE_SELECTED_LINE_COLOR];
    if (lineColor) {
        self.lineColor = [RCTConvert UIColor:lineColor];
    }
    
    // STYLE_LINE_COLOR
    id seletcedTextColor = self.segmentedStyle[STYLE_SELECTED_TEXT_COLOR];
    if (seletcedTextColor) {
        self.selectedTextColor = [RCTConvert UIColor:seletcedTextColor];
    }
    
    // STYLE_LINE_STICK_TO_BOTTOM
    id selectedLineAlign = self.segmentedStyle[STYLE_SELECTED_LINE_ALIGN];
    if (selectedLineAlign) {
        self.selectedLineAlign = [RCTConvert CustomSegmentedSelectedLineAlign:selectedLineAlign];
    }
    
    // STYLE_LINE_STICK_TO_BOTTOM
    id selectedLineMode = self.segmentedStyle[STYLE_SELECTED_LINE_MODE];
    if (selectedLineMode) {
        self.selectedLineMode = [RCTConvert CustomSegmentedSelectedLineMode:selectedLineMode];
    }
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
    
    // ANIMATION_TYPE
    id animationType = self.animation[ANIMATION_TYPE];
    if (animationType) {
        self.customAnimationType = [RCTConvert CustomSegmentedSelectedAnimationType:animationType];
    }
    
    // ANIMATION_DAMPING_INITIAL_VELOCITY
    id animationInitialDampingVelocity = self.animation[ANIMATION_DAMPING_INITIAL_VELOCITY];
    if (animationInitialDampingVelocity) {
        self.initialDampingVelocity = [RCTConvert CGFloat:animationInitialDampingVelocity];
    }
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self){
        self.animationDuration = DEFAULT_ANIMATION_DURATION;
        self.animationDamping = DEFAULT_ANIMATION_DAMPING;
        self.lineSelectedHeight = DEFAULT_SELECTED_LINE_HEIGHT;
        self.segmentedFontSize = DEFAULT_FONT_SIZE;
        self.lineColor = DEFAULT_LINE_COLOR;
        self.selectedTextColor = DEFAULT_LINE_COLOR;
        self.segmentHighlightTextColor = DEFAULT_SEGMENTED_HIGHLIGHT_COLOR;
        self.selectedLinePaddingWidth = DEFAULT_SELECTED_LINE_PADDING_WIDTH;
        self.selectedLineAlign = CustomSegmentedSelectedLineAlignText;
        self.selectedLineMode = CustomSegmentedSelectedLineModeText;
        self.customAnimationType = CustomSegmentedSelectedAnimationTypeDefault;
        
        self.buttons = [[NSMutableArray alloc] init];
        self.lines = [[NSMutableArray alloc] init];
    }
    
    return self;
}


-(UIFont*)buttonTitleFont {
    UIFont *btnFont = [UIFont systemFontOfSize:self.segmentedFontSize];
    if (self.segmentFontFamilyName) {
        if ([self.segmentFontFamilyName isEqualToString:DEFAULT_SYSTEM_FONT_BOLD]) {
            return [UIFont boldSystemFontOfSize:self.segmentedFontSize];
        }
        
        UIFont *tmpFont = [UIFont fontWithName:self.segmentFontFamilyName size:self.segmentedFontSize];
        btnFont = (tmpFont) ? tmpFont : btnFont;
    }
    return btnFont;
}


-(void)reactSetFrame:(CGRect)frame {
    [super reactSetFrame:frame];
    
    if (self.segmentedStrings && self.segmentedStrings.count > 0) {
        CGFloat buttonWidth = self.bounds.size.width / self.segmentedStrings.count;
        
        UIFont *btnFont = [self buttonTitleFont];
        
        for (int i=0; i < self.segmentedStrings.count; i++) {
            
            CGFloat buttonX = buttonWidth * i;
            UIButton *btn = (self.buttons.count > i) ? self.buttons[i] : nil;
            CGRect btnNewFrame = CGRectMake(buttonX, self.bounds.origin.y, buttonWidth, self.bounds.size.height);
            
            if (!btn ) {
                btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [self.buttons addObject:btn];
            }
            
            UIView *line = (self.lines.count > i) ? self.lines[i] : nil;
            if (!line) {
                line = [[UIView alloc] init];
                [self.lines addObject:line];
            }
            else  {
                btn.frame = btnNewFrame;
                CGRect lineFrame = btn.frame;
                CGSize btnTitleSize = [btn.titleLabel.text sizeWithFont:btn.titleLabel.font];
                lineFrame.origin.x = btn.center.x - (lineFrame.size.width/2) ;
                lineFrame.origin.y = btn.titleLabel.frame.origin.y + (btnTitleSize.height/2) + 2;
                line.frame = lineFrame;
                continue;
            }
            
            btn.frame = btnNewFrame;
            [btn setTitle:self.segmentedStrings[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [btn.titleLabel setFont:btnFont];
            btn.backgroundColor = self.segmentBackgroundColor;
            [btn setTitleColor:self.segmentTextColor forState:UIControlStateNormal];
            [btn setTitleColor:self.segmentHighlightTextColor forState:UIControlStateHighlighted];
            
            [self addSubview:btn];
            
            CGRect lineFrame = [self lineFrameForbutton:btn];
            if (self.selectedItem != i) {
                lineFrame.size.width = 0;
            }
            
            if (self.selectedItem == i) {
                [btn setTitleColor:self.selectedTextColor forState:UIControlStateNormal];
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


-(CGRect)lineFrameForbutton:(UIButton*)btn {
    CGRect lineFrame = btn.frame;
    lineFrame.size.height = self.lineSelectedHeight;
    CGSize btnTitleSize = [btn.titleLabel.text sizeWithFont:btn.titleLabel.font];
    lineFrame.size.width = (self.selectedLineMode == CustomSegmentedSelectedLineModeText) ? btnTitleSize.width + self.selectedLinePaddingWidth*2 : btn.bounds.size.width;
    lineFrame.origin.x = btn.center.x - (lineFrame.size.width/2) ;
    
    switch (self.selectedLineAlign) {
        case CustomSegmentedSelectedLineAlignTop:
            lineFrame.origin.y = 0;
            break;
            
        case CustomSegmentedSelectedLineAlignText:
            lineFrame.origin.y = btn.titleLabel.frame.origin.y + (btnTitleSize.height/2) + self.selectedLinePaddingWidth;
            break;
            
        case CustomSegmentedSelectedLineAlignBottom:
            lineFrame.origin.y = btn.bounds.origin.y + btn.bounds.size.height - lineFrame.size.height;
            break;
        default:
            break;
    }
    
    return lineFrame;
}


-(void)buttonSelected:(UIButton*)buttonPressed animated:(BOOL)animated {
    NSInteger previousSelectedItem = self.selectedItem;
    _selectedItem = [self.buttons indexOfObject:buttonPressed];
    
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
            lineFrame.size.width = (self.selectedLineMode == CustomSegmentedSelectedLineModeText) ? btnTitleSize.width + self.selectedLinePaddingWidth*2 : buttonPressed.bounds.size.width;
        }
        
        line.center = CGPointMake(button.center.x, line.center.y);
        
        CGPoint center = button.center;
        center.y = line.center.y;
        
        UIColor *buttonTextColor = (button == buttonPressed) ? self.selectedTextColor : self.segmentTextColor;
        CGFloat duration = (button == buttonPressed) ? self.animationDuration : 0;
        CGFloat damping = (button == buttonPressed) ? self.animationDamping : 0;
        
        if (!animated) {
            line.frame = lineFrame;
            if (self.customAnimationType != CustomSegmentedSelectedRelativeOpen) {
                line.center = center;
            }
            [button setTitleColor:buttonTextColor forState:UIControlStateNormal];
        }
        else {
            
            switch (self.customAnimationType) {
                    
                case CustomSegmentedSelectedAnimationTypeCloseAndAndOpen:
                {
                    
                    [self doTransitionAnimation:line
                                   lineNewFrame:lineFrame
                                       duration:self.animationDuration
                                        damping:self.animationDamping
                                         button:button
                                  buttonPressed:buttonPressed
                                buttonTextColor:buttonTextColor
                          initialSpringVelocity:self.initialDampingVelocity];
                }
                    break;
                    
                case CustomSegmentedSelectedAnimationTypeMiddleLine:
                {
                    if (button == buttonPressed) {
                        
                        CGRect tmpFrame = lineFrame;
                        tmpFrame.size.width = tmpFrame.size.width*0.9;
                        line.frame = tmpFrame;
                        line.center = center;
                    }
                    
                    [self doTransitionAnimation:line
                                   lineNewFrame:lineFrame
                                       duration:duration
                                        damping:damping
                                         button:button buttonPressed:buttonPressed
                                buttonTextColor:buttonTextColor
                          initialSpringVelocity:self.initialDampingVelocity];
                    
                }
                    break;
                    
                case CustomSegmentedSelectedRelativeOpen:
                {
                    if (button == buttonPressed) {
                        CGRect tmpFrame = lineFrame;
                        tmpFrame.size.width *= 0.2;
                        if (self.selectedItem > previousSelectedItem) {
                            
                            tmpFrame.origin.x = (buttonPressed.frame.size.width - lineFrame.size.width)/2 + buttonPressed.frame.origin.x;
                            
                        }
                        else {
                            tmpFrame.origin.x = buttonPressed.frame.origin.x + buttonPressed.bounds.size.width - tmpFrame.size.width - (buttonPressed.bounds.size.width - lineFrame.size.width)/2;
                        }
                        line.frame = tmpFrame;
                    }
                    
                    
                    [self doRelativeOpenAnimation:line
                                     lineNewFrame:lineFrame
                                         duration:duration
                                          damping:0
                                           button:button buttonPressed:buttonPressed
                                  buttonTextColor:buttonTextColor
                            initialSpringVelocity:self.initialDampingVelocity];
                }
                    break;
                    
                default:
                {
                    
                    [self doTransitionAnimation:line
                                   lineNewFrame:lineFrame
                                       duration:duration
                                        damping:damping
                                         button:button
                                  buttonPressed:buttonPressed
                                buttonTextColor:buttonTextColor
                          initialSpringVelocity:self.initialDampingVelocity];
                }
                    break;
            }
        }
    }
}


-(void)buttonSelected:(UIButton*)buttonPressed {
    [self buttonSelected:buttonPressed animated:YES];
}


-(void)doTransitionAnimation:(UIView*)line
                lineNewFrame:(CGRect)lineFrame
                    duration:(CGFloat)duration
                     damping:(CGFloat)damping
                      button:(UIButton*)button
               buttonPressed:(UIButton*)buttonPressed
             buttonTextColor:(UIColor*)buttonTextColor
       initialSpringVelocity:(CGFloat)velocity {
    
    CGPoint center = button.center;
    center.y = line.center.y;
    
    if (duration == 0.0) {
        line.frame = lineFrame;
        line.center = center;
        [button setTitleColor:buttonTextColor forState:UIControlStateNormal];
        if (_selectedDidChange && ([self.buttons indexOfObject:button] == (self.buttons.count - 1))) {
            _selectedDidChange(@{@"selected" : [NSNumber numberWithInteger:self.selectedItem], @"finished" : [NSNumber numberWithBool:YES]});
        }
    }
    else {
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:0 animations:^{
            
            line.frame = lineFrame;
            line.center = center;
            [button setTitleColor:buttonTextColor forState:UIControlStateNormal];
            
        } completion:^(BOOL finished) {
            if (_selectedDidChange && ([self.buttons indexOfObject:button] == (self.buttons.count - 1))) {
                _selectedDidChange(@{@"selected" : [NSNumber numberWithInteger:self.selectedItem], @"finished" : [NSNumber numberWithBool:finished]});
            }
        }];
    }
}

-(void)doRelativeOpenAnimation:(UIView*)line
                  lineNewFrame:(CGRect)lineFrame
                      duration:(CGFloat)duration
                       damping:(CGFloat)damping
                        button:(UIButton*)button
                 buttonPressed:(UIButton*)buttonPressed
               buttonTextColor:(UIColor*)buttonTextColor
         initialSpringVelocity:(CGFloat)velocity {
    
    if (duration == 0.0) {
        line.frame = lineFrame;
        [button setTitleColor:buttonTextColor forState:UIControlStateNormal];
        if (_selectedDidChange && ([self.buttons indexOfObject:button] == (self.buttons.count - 1))) {
            _selectedDidChange(@{@"selected" : [NSNumber numberWithInteger:self.selectedItem], @"finished" : [NSNumber numberWithBool:YES]});
        }
    }
    else {
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionNone animations:^{
            
            line.frame = lineFrame;
            [button setTitleColor:buttonTextColor forState:UIControlStateNormal];
            
        } completion:^(BOOL finished) {
            if (_selectedDidChange && ([self.buttons indexOfObject:button] == (self.buttons.count - 1))) {
                _selectedDidChange(@{@"selected" : [NSNumber numberWithInteger:self.selectedItem], @"finished" : [NSNumber numberWithBool:finished]});
            }
        }];
    }
}


-(void)setSelectedItem:(NSInteger)selectedItem {
    if (self.buttons.count > selectedItem && selectedItem >= 0) {
        UIButton *selectedButton = self.buttons[selectedItem];
        [self buttonSelected:selectedButton animated:NO];
    }
    else {
        // should be called only if the segmentedStrings (JS: textValues) array
        // havn't been set yet, to avoid missing setSelected
        _selectedItem = selectedItem;
    }
}


@end


@implementation CustomSegmentedControlManager


RCT_EXPORT_MODULE()


- (UIView *)view {
    return [CustomSegmentedControl new];
}


RCT_EXPORT_VIEW_PROPERTY(enabled, BOOL)

// props
RCT_REMAP_VIEW_PROPERTY(textValues, segmentedStrings, NSArray)
RCT_REMAP_VIEW_PROPERTY(selected, selectedItem, NSInteger)
RCT_REMAP_VIEW_PROPERTY(segmentedStyle, segmentedStyle, NSDictionary)
RCT_REMAP_VIEW_PROPERTY(animation, animation, NSDictionary)

// callback props
RCT_REMAP_VIEW_PROPERTY(onSelectedWillChange, selectedWillChange, RCTDirectEventBlock)
RCT_REMAP_VIEW_PROPERTY(onSelectedDidChange, selectedDidChange, RCTDirectEventBlock)


@end
