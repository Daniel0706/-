//
//  NSBundle+HTML.m
//  JingJiangLife
//
//  Created by wang xuefeng on 13-5-27.
//  Copyright (c) 2013年 VG. All rights reserved.
//

#import "NSBundle+HTML.h"

@implementation NSBundle (HTML)


+ (NSString*)htmlFromFileName:(NSString*)fileName params:(NSDictionary*)dic
{
    
    
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    

    resourcePath = [NSString stringWithFormat:@"%@/%@" , resourcePath , fileName];
    NSError * error = nil;
    __block NSMutableString * body = [NSMutableString stringWithContentsOfFile:resourcePath
                                                              encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
    {
        NSLog(@"%@" , error);
        return nil;
    }
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSString * keyStr = [NSString stringWithFormat:@"${%@}" , key];
        
        [body replaceOccurrencesOfString:keyStr
                              withString:(NSString *)obj
                                 options:NSCaseInsensitiveSearch
                                   range:NSMakeRange(0, [body length])];
        
    }];
    
    return body;
    
}

@end
