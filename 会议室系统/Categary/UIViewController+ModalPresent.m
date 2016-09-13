//
//  UIViewController+ModalPresent.m
//  PickerDemo
//
//  Created by 刘春侠 on 15/12/9.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "UIViewController+ModalPresent.h"

@implementation UIViewController (ModalPresent)
- (void)presentOverCurrentWithViewController:(UIViewController *)viewControllerToPresent
                        modalTransitionStyle:(UIModalTransitionStyle)style
                                    animated:(BOOL)flag
                                  completion:(void (^)(void))completion {
    
    [viewControllerToPresent setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [viewControllerToPresent setModalTransitionStyle:style];
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}
@end
