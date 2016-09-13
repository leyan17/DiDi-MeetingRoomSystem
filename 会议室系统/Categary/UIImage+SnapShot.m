//
//  UIImage+SnapShot.m
//  camelot
//
//  Created by 刘春侠 on 15/12/16.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "UIImage+SnapShot.h"

@implementation UIImage (SnapShot)
+ (UIImage *)clt_imageForLayer:(CALayer *)layer
{
    CGRect bounds = layer.bounds;
    NSAssert1(CGRectGetWidth(bounds), @"Zero width for layer %@", layer);
    NSAssert1(CGRectGetHeight(bounds), @"Zero height for layer %@", layer);
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSAssert1(context, @"Could not generate context for layer %@", layer);
    CGContextSaveGState(context);
    [layer layoutIfNeeded];
    [layer renderInContext:context];
    CGContextRestoreGState(context);
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

+ (UIImage *)clt_imageForViewLayer:(UIView *)view
{
    [view layoutIfNeeded];
    return [self clt_imageForLayer:view.layer];
}

+ (UIImage *)clt_imageForView:(UIView *)view
{
    CGRect bounds = view.bounds;
    NSAssert1(CGRectGetWidth(bounds), @"Zero width for view %@", view);
    NSAssert1(CGRectGetHeight(bounds), @"Zero height for view %@", view);
    
    UIWindow *window = view.window;
    if (window == nil) {
        window = [[UIWindow alloc] initWithFrame:bounds];
        [window addSubview:view];
        [window makeKeyAndVisible];
    }
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, 0);
    [view layoutIfNeeded];
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}
@end
