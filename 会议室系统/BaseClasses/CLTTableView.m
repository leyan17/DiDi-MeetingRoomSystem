//
//  CLTTableView.m
//
//
//  Created by 刘春侠 on 15/11/25.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "CLTTableView.h"

@implementation CLTTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self defaultAppearance];
    }
    return self;
}

- (void)defaultAppearance {
    self.rowHeight = 44.0f;
    self.backgroundColor = [UIColor whiteColor];
    self.tableFooterView = [[UIView alloc]init];
}

- (void)awakeFromNib {
    [self defaultAppearance];
}
@end
