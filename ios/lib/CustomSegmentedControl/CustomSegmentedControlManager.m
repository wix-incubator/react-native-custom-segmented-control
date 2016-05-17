//
//  CustomSegmentedControlManager.m
//  CustomSegmentedControl
//
//  Created by Ran Greenberg on 15/05/2016.
//  Copyright © 2016 Wix. All rights reserved.
//

#import "CustomSegmentedControlManager.h"
#import "UIView+React.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define LINE_VIEW_TAG                           100
#define LINE_SELECTED_EXTRA_PADDING             4
#define DEFAULT_LINE_SELECTED_HEIGHT            2
#define DEFAULT_ANIMATION_DURATION              0.2
#define DEFAULT_FONT_SIZE                       14

#define STYLE_LINE_SELECTED_HEIGHT              @"lineSelectedHeight"
#define STYLE_FONT_SIZE                         @"fontSize"
#define STYLE_SEGMENT_BACKGROUND_COLOR          @"segmentBackgroundColor"
#define STYLE_SEGMENT_TEXT_COLOR                @"segmentTextColor"



@interface CustomSegmentedControl : UIControl

@property (nonatomic, strong) NSArray<NSString*> *segmentedStrings;
@property (nonatomic, strong) NSMutableArray<UIButton*> *buttons;
@property (nonatomic, strong) NSMutableArray<UIView*> *lines;
@property (nonatomic) NSInteger selectedItem;

// style
@property (nonatomic) CGFloat lineSelectedHeight;
@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) CGFloat segmentedFontSize;
@property (nonatomic, strong) UIColor *segmentBackgroundColor;
@property (nonatomic, strong) UIColor *segmentTextColor;

// callbacks
@property (nonatomic, copy) RCTDirectEventBlock selectedWillChange;
@property (nonatomic, copy) RCTDirectEventBlock selectedDidChange;
@property (nonatomic, strong) NSDictionary *segmentedStyle;

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
    
    
}

-(NSMutableArray<UIButton *> *)buttons {
    if (!_buttons) _buttons = [[NSMutableArray alloc] init];
    return _buttons;
}

-(NSMutableArray<UIButton *> *)lines {
    if (!_lines) _lines = [[NSMutableArray alloc] init];
    return _lines;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.animationDuration = DEFAULT_ANIMATION_DURATION;
        self.lineSelectedHeight = DEFAULT_LINE_SELECTED_HEIGHT;
        self.segmentedFontSize = DEFAULT_FONT_SIZE;
        self.segmentTextColor = 
    }
    
    return self;
}

-(void)setSegmentedStrings:(NSArray *)strings {
    _segmentedStrings = strings;
}

- (void)reactSetFrame:(CGRect)frame {
    [super reactSetFrame:frame];
    
    CGFloat borderWidth = 1;
    
    if (self.segmentedStrings && self.segmentedStrings.count > 0) {
        CGFloat buttonWidth = self.bounds.size.width / self.segmentedStrings.count;
        
        for (int i=0; i < self.segmentedStrings.count; i++) {
            
            UIButton *btn = (self.buttons.count > i) ? self.buttons[i] : nil;
            if (!btn ) {
                btn = [UIButton buttonWithType:UIButtonTypeSystem];
                [self.buttons addObject:btn];
            } else continue;
            
            UIView *line = (self.lines.count > i) ? self.lines[i] : nil;
            if (!line) {
                line = [[UIView alloc] init];
                [self.lines addObject:line];
            } else continue;
            
            CGFloat buttonX = buttonWidth * i;
            btn.frame = CGRectMake(buttonX, self.bounds.origin.y, buttonWidth, self.bounds.size.height);
            [btn setTitle:self.segmentedStrings[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:self.segmentedFontSize]];
            btn.backgroundColor = self.segmentBackgroundColor;
            [btn setTitleColor:self.segmentTextColor forState:UIControlStateNormal];

            [self addSubview:btn];
            
            CGRect lineFrame = btn.frame;
            lineFrame.size.height = self.lineSelectedHeight <= 0 ? DEFAULT_LINE_SELECTED_HEIGHT: self.lineSelectedHeight;
            CGSize btnTitleSize = [btn.titleLabel.text sizeWithFont:btn.titleLabel.font];
            lineFrame.size.width = btnTitleSize.width + LINE_SELECTED_EXTRA_PADDING;
            lineFrame.origin.x = btn.center.x - (lineFrame.size.width/2) ;
            lineFrame.origin.y = btn.titleLabel.frame.origin.y + (btnTitleSize.height/2) + 2;
            
            if (self.selectedItem != i) {
                lineFrame.size.width = 0;
            }
            
            line.frame = lineFrame;
            line.backgroundColor = self.tintColor;
            line.layer.cornerRadius = line.bounds.size.height/2;
        }
        
        for (UIView *line in self.lines) {
            [self addSubview:line];
        }
    }
}


-(void)buttonSelected:(UIButton*)buttonPressed {
    NSInteger previousSelectedItem = self.selectedItem;
    self.selectedItem = [self.buttons indexOfObject:buttonPressed];
    
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
        self.animationDuration = self.animationDuration <= 0 ? DEFAULT_ANIMATION_DURATION : self.animationDuration;
        
        if (previousSelectedItem == self.selectedItem) {
            return;
        }
        
        if (_selectedWillChange && button == buttonPressed) {
            _selectedWillChange(@{@"selected" : @(self.selectedItem)});
        }
        
        [UIView animateWithDuration:self.animationDuration animations:^{
            line.frame = lineFrame;
            line.center = center;
            
        } completion:^(BOOL finished) {
            if (finished) {
                
                if (_selectedDidChange && button == buttonPressed) {
                    _selectedDidChange(@{@"selected" : [NSNumber numberWithInteger:self.selectedItem]});
                }
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
RCT_EXPORT_VIEW_PROPERTY(tintColor, UIColor)

RCT_REMAP_VIEW_PROPERTY(animationDuration, animationDuration, CGFloat)
RCT_REMAP_VIEW_PROPERTY(values, segmentedStrings, NSArray)
RCT_REMAP_VIEW_PROPERTY(selected, selectedItem, NSInteger)
RCT_REMAP_VIEW_PROPERTY(segmentedStyle, segmentedStyle, NSDictionary)

RCT_REMAP_VIEW_PROPERTY(onSelectedWillChange, selectedWillChange, RCTDirectEventBlock)
RCT_REMAP_VIEW_PROPERTY(onSelectedDidChange, selectedDidChange, RCTDirectEventBlock)




@end
