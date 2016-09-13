//
//  UIViewController+EmptyShow.h
//  camelot
//
//  Created by 刘春侠 on 15/12/9.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CLTEmptyView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@end
@interface UIViewController (EmptyShow)
- (void)showEmptyWithTip:(NSString *)tip image:(UIImage *)image;
@end

