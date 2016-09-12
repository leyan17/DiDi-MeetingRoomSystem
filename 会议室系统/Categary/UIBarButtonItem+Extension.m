//
//  UIBarButtonItem+Extension.m
//  meituan
//
//  Created by 刘春侠 on 15/12/2.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"


@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(NSString *)image
                          highImage:(NSString *)highImage {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:image]
                       forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:highImage]
                       forState:UIControlStateHighlighted];
    backBtn.width = backBtn.currentBackgroundImage.size.width;
    backBtn.height = backBtn.currentBackgroundImage.size.height;
    [backBtn addTarget:target  action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}
@end
