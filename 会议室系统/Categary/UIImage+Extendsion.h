//
//  UIImage+Extendsion.h
//  shareDemo
//
//  Created by 刘春侠 on 15/11/23.
//  Copyright © 2015年 刘春侠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extendsion)
/**
 *  自由拉伸一张图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
/**
 *  根据颜色和大小获取Image
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  根据图片和颜色返回一张加深颜色以后的图片
 */
+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor;
/**
 *  自由改变Image的大小
 */
- (UIImage *)cropImageWithSize:(CGSize)size;

@end
