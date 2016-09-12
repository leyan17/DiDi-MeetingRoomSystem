//
//  UIView+Frame.m
//  codeSnip
//
//  Created by 刘春侠 on 15/9/1.
//  Copyright (c) 2015年 刘春侠. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setX:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame =rect;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame =rect;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect rect  = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect rect  = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.masksToBounds = YES;
}

- (CGFloat)bottomY {
    return self.y + self.height;
}

- (void)toCircleView {
    self.layer.cornerRadius = self.width / 2.0;
    self.layer.masksToBounds = YES;
}

- (void)removeAllSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

-(void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(CGSize)size {
    return self.frame.size;
}

@end
