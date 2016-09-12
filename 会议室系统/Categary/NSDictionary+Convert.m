//
//  NSDictionary+Convert.m
//  meituan
//
//  Created by 刘春侠 on 15/11/25.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "NSDictionary+Convert.h"

@implementation NSDictionary (Convert)
- (NSString *)toString {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    if (error) {
        NSLog(@"json serialized fail ! %@",[error localizedDescription]);
        return nil;
    }
    return [[NSString alloc]initWithData:data
                                encoding:NSUTF8StringEncoding
            ];
}
@end
