//
//  UIViewController+EmptyShow.m
//  camelot
//
//  Created by 刘春侠 on 15/12/9.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "UIViewController+EmptyShow.h"
#import <objc/runtime.h>
static void * emptyKey ;
@implementation UIViewController (EmptyShow)
- (void)showEmptyWithTip:(NSString *)tip image:(UIImage *)image {
    CLTEmptyView *empty = [self emptyView];
    if (!empty) {
        empty = [[[NSBundle mainBundle]loadNibNamed:@"EmptyView"
                                              owner:nil
                                            options:nil ] lastObject];
        [self setEmptyView:empty];
        [empty.titleLabel setText:tip];
        [empty.titleLabel sizeToFit];
        if (image) {
            [empty.Image setImage:image];
        }
    }
    empty.frame = CGRectMake(0, 0, 300, 300);
    empty.center = self.view.center;
    [self.view insertSubview:empty atIndex:0];
}

- (CLTEmptyView *)emptyView {
    return  objc_getAssociatedObject(self, &emptyKey);
}

- (void)removeEmptyView {
    [[self emptyView] removeFromSuperview];
}

- (void)setEmptyView:(CLTEmptyView *)emptyView {
    objc_setAssociatedObject(self, &emptyKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
@implementation CLTEmptyView



@end