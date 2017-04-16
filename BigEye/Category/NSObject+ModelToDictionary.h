//
//  NSObject+ModelToDictionary.h
//  CRWB
//
//  Created by CR-IOS on 16/3/11.
//  Copyright © 2016年 CR-IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ModelToDictionary)
/**
 *  模型转字典
 *
 *  @return 字典
 */
- (NSDictionary *)dictionaryFromModel;

/**
 *  带model的数组或字典转字典
 *
 *  @param object 带model的数组或字典转
 *
 *  @return 字典
 */
- (id)idFromObject:(nonnull id)object;
@end
