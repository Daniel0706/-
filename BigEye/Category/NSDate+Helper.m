//
//  NSDate+Helper.m
//  CRWB
//
//  Created by CR-IOS on 2016/9/29.
//  Copyright © 2016年 CR-IOS. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)
+(NSDate*)dateFromLongLong:(long long)msSince1970{
    return [NSDate dateWithTimeIntervalSince1970:msSince1970 / 1000];
}
@end
