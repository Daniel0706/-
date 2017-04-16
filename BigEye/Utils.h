//
//  Utils.h
//  MYEnterprise
//
//  Created by ETOP on 15/4/20.
//  Copyright (c) 2015年 ___JS___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSONModel.h"

#define IOS_SDK_VERSION [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]
#define NAVIGATIONBAR_HEIGHT    0

@interface Utils : NSObject

+ (void)showToast:(NSString *)aStr;

+ (void)showWaitingViewWithText:(NSString *)text onView:(UIView*)onView;

+ (void)removeWaitingViewOnView:(UIView*)onView;

+ (BOOL) isValidPhone:(NSString*)value;

+ (NSString *) md5:(NSString *)str;

//公司性质
+ (NSString *)getQuality:(int)quality;

//学历
+ (NSString *)getEdu:(int)eduID;

+ (CGSize)boundingRectWithSize:(CGSize)size message:(NSString *)msg;

+ (NSString *)getTime:(NSString *)time;
+ (NSString *)getPointTime:(NSString *)time;
+ (CGSize)boundingRectWithSize:(CGSize)size message:(NSString *)msg sysFont:(int)font;
+ (BOOL) isEmailAddress:(NSString*)email;
+ (BOOL)validateMobile:(NSString *)mobileNum;
+ (BOOL) isPhone:(NSString *)phone;
+ (BOOL) isTelePhone:(NSString *)telPhone;
+ (NSString *)getStage:(int)type;
+ (CGSize)getSize:(NSString *)msg font:(int)font;
+ (CGRect)getCommonFrame:(CGRect)sourceFrame;
//获取年级
+ (NSString *)getGradeById:(NSString *)gradeId;

+ (NSString *)readDataBase:(NSString *)name;

+ (NSString *)getAppTime:(NSDate *)aDate;
+ (NSString *)toJSONData:(id)theData;
+ (UIImage *)getNormalImage:(UIImage *)image withRect:(CGRect)rect;

+(NSString *)translation:(NSString *)arebic;

+ (void)createSeleInfoDocument:(NSString *)userId;

+ (void)createMarketWithUserId:(NSString *)userId cMarketId:(NSString *)marketId;

//获取周几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

+(JSONModel *) ParseDictionary2JsonModel:(NSDictionary *)result class:(NSString *)destClass;

//阴影效果
+ (void)roundedLayer:(CALayer *)viewLayer
              radius:(float)r
              shadow:(BOOL)s;
@end
