//
//  SystemConfig.h
//  meituan
//
//  Created by 刘春侠 on 15/11/25.
//  Copyright © 2015年 camelot. All rights reserved.
//

#ifndef SystemConfig_h
#define SystemConfig_h

#define isPlusDevice   ( [UIScreen mainScreen].scale >= 3.0 - FLT_MIN )
#define iOS8Later  [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0


#endif /* SystemConfig_h */
