//
//  CustumSegmentedButton.m
//  CustomSegmentedControl
//
//  Created by Ran Greenberg on 16/05/2016.
//  Copyright © 2016 Wix. All rights reserved.
//

#import "CustumSegmentedButton.h"

@interface CustumSegmentedButton (UIButton)

@property (nonatomic, strong) UIView *lineView;

@end


@implementation CustumSegmentedButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
//        CGSize btnTitleSize = [button.titleLabel.text sizeWithFont:button.titleLabel.font];
//        self.lineView =
    }
    
    return self;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    
    CGSize btnTitleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
//    CGRect
//    
//    self.lineView
}

@end
