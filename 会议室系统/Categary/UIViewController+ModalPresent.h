//
//  UIViewController+ModalPresent.h
//  PickerDemo
//
//  Created by 刘春侠 on 15/12/9.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ModalPresent)
- (void)presentOverCurrentWithViewController:(UIViewController *)viewControllerToPresent
                        modalTransitionStyle:(UIModalTransitionStyle)style
                                    animated:(BOOL)flag
                                  completion:(void (^)(void))completion;
@end
