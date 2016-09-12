//
//  UIImage+SnapShot.h
//  camelot
//
//  Created by 刘春侠 on 15/12/16.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SnapShot)
/// Uses renderInContext: to get a snapshot of the layer.
+ (UIImage *)clt_imageForLayer:(CALayer *)layer;

/// Uses renderInContext: to get a snapshot of the view layer.
+ (UIImage *)clt_imageForViewLayer:(UIView *)view;

/// Uses drawViewHierarchyInRect: to get a snapshot of the view and adds the view into a window if needed.
+ (UIImage *)clt_imageForView:(UIView *)view;
@end
