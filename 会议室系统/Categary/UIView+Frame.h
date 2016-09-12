//
//  UIView+Frame.h
//  codeSnip
//
//  Created by 刘春侠 on 15/9/1.
//  Copyright (c) 2015年 刘春侠. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kScreenBounds [UIScreen mainScreen].bounds

@interface UIView (Frame)
@property(nonatomic, assign) CGFloat x;
@property(nonatomic, assign) CGFloat y;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, readonly) CGFloat bottomY;

@property (nonatomic, assign) CGSize size;

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width;

- (void)toCircleView;

- (void)removeAllSubviews;
@end
