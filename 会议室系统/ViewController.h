//
//  ViewController.h
//  会议室系统
//
//  Created by 刘春侠 on 16/9/9.
//  Copyright © 2016年 camelot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate> {
    NSMutableArray *dataArray;
    NSMutableArray *searchResults;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplayController;
    
}



@end

