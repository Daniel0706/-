//
//  NSString+Helper.h
//  CRWB
//
//  Created by CR-IOS on 16/3/7.
//  Copyright © 2016年 CR-IOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

+ (BOOL)checkPhoneNumber:(NSString *)phoneStr;//检查手机号码是否正确输入

+ (BOOL)checkTextFieldIsNil:(NSString *)textStr;//检查用户名是否输入正确

//+ (BOOL)checkCodeTextFieldIsTrue:(NSString *)codeTextStr WithPhoneStr:(NSString *)phoneStr;

+ (BOOL)checkCodeTextFieldIsNil:(NSString *)codeStr;

+ (BOOL)checkPasswordTextFieldIsTrue:(NSString *)password;

+ (BOOL)validateEmail:(NSString *)email;

+ (CGFloat) calculateStringHightWithString:(NSString *)str;

+ (CGFloat) calculateStringwidthWithString:(NSString *)str;

+ (CGFloat) calculateStringHightWithString:(NSString *)str WithCGRect:(CGSize) size WithFont:(UIFont *)font;

+ (CGFloat) calculateStringwidthWithString:(NSString *)str WithCGRect:(CGSize) size WithFont:(UIFont *)font;

+ (CGSize)sizeForText:(NSString *)text withMaxWidth:(CGFloat)maxWidth lineSpacing:(CGFloat)lineSpacing fontSize:(CGFloat)fontSize;

+ (CGSize)sizeForText:(NSString *)text withMaxWidth:(CGFloat)maxWidth withMaxHight:(CGFloat)maxHight lineSpacing:(CGFloat)lineSpacing fontSize:(CGFloat)fontSize;

+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

+ (NSString *)filterHTML:(NSString *)html;

//+ (NSString *)getUserNameFromeLocalData;
// 时间字符串转NSDate
+ (NSDate *) nsstringTransformToNSDataStr:(NSString *)dateStr;
+ (NSDate *) nsstringTransformToNSTimeStr:(NSString *)dateStr;
// NSDate转时间戳
+ (NSString *)nsdateTransformToTimestamp :(NSDate *)date;
//时间转换
+ (NSString *)conversationTime:(long long)time;

// NSdiction转NSString
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
+ (NSString *)ReplacingNewLineAndWhitespaceCharactersFromJson:(NSString *)dataStr;
// 即时通讯时间转换
+ (NSString *) changeToStringWithTimeStr:(NSString *)timeStr;
+ (NSString *) conversationtimeWithMessageSubmitterTime:(NSString *)submitTimeStr;
+  (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+(NSString *)conversationTimeWithRegularFormer:(long long)time;
+(NSString *)change13BitsTimeStrTo10BitsDateString:(NSString *)timeStr;

#pragma mark --- 随机生成32位字符串
+(NSString *)ret32bitString;

#pragma mark --- 型号
+ (NSString *)changeDeviceModelPriceLevelToStr:(NSString *)level;
+ (NSString *)changeDeviceModelTypeToStr:(NSString *)type;
+ (NSString *)changeDeviceModelDeviceSystemToStr:(NSString *)system;

+ (NSString *)changeDataSizeWithFolatValue:(float)value;

#pragma mark --- 申报类型选择
+ (NSString *)changeReviewTypeEnumToReviewString:(NSString *)typeEnum;
#pragma mark --- 申报列表进度
+ (NSInteger )changeReviewStatusToTypeEnumTo:(NSString *)typeEnum;
#pragma mark --- 申报类型转换
+ (NSInteger )changeReviewTypeToTypeEnum:(NSString *)typeEnum;

+ (NSString *)changeEnumTypeToTypeString:(NSString *)typeEnum;

+ (NSString *)changeEnumResultToResultString:(NSString *)resultEnum;

+ (NSString *)conversationTimeLongToTimeStr:(NSString *)timeLong;
@end
