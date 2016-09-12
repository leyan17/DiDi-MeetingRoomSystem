//
//  UIBarButtonItem+Extension.h
//  meituan
//
//  Created by 刘春侠 on 15/12/2.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
