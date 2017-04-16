//
//  Utils.m
//  MYEnterprise
//
//  Created by ETOP on 15/4/20.
//  Copyright (c) 2015年 ___JS___. All rights reserved.
//

#import "Utils.h"
#import "AppDelegate.h"
//#import "UIProvideToast.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "UIProvideToast.h"
#import "MBProgressHUD.h"


@interface NSString(ContactViewTitle)

- (NSComparisonResult)compareForShowSectionTitle:(NSString *)title;
@end

@implementation NSString(ContactViewTitle)


/******************************************************************************
 函数名称  : compareForShowSectionTitle
 函数描述  : 字符串对比函数,数组排序时使用
 输入参数  : N/A
 输出参数  :
 返回值    :
 作者     : zhangwei
 ******************************************************************************/
- (NSComparisonResult)compareForShowSectionTitle:(NSString *)title
{//第一个跟第二个比较 （类似冒泡)
    if (YES == [self isEqual:@"#"])
    {
        return NSOrderedDescending;
    }
    else if (YES == [title isEqual:@"#"])
    {
        return NSOrderedAscending;
    }
    return [self compare:title];
}
@end

@implementation Utils

+ (void)showToast:(NSString *)aStr
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *rootView = appDelegate.window;
    for (UIView *tmpView in [rootView subviews])
    {
        if ([tmpView isKindOfClass:[UIProvideToast class]])
        {
            [tmpView removeFromSuperview];
        }
    }
    
    UIProvideToast *toast = [[UIProvideToast alloc] init];
    [toast show:aStr];
}

+ (void)showWaitingViewWithText:(NSString *)text onView:(UIView*)onView
{
    if ([MBProgressHUD HUDForView:onView])
    {
        return;
    }
    onView.userInteractionEnabled = NO;
    [[MBProgressHUD showHUDAddedTo:onView animated:YES]setLabelText:text];
}

+ (void)removeWaitingViewOnView:(UIView*)onView
{
    onView.userInteractionEnabled = YES;
    [MBProgressHUD hideAllHUDsForView:onView  animated:NO];
}

BOOL isNumber (char ch)
{
    if (!(ch >= '0' && ch <= '9')) {
        return FALSE;
    }
    return TRUE;
}

+ (BOOL) isValidNumber:(NSString*)value{
    const char *cvalue = [value UTF8String];
    int len = strlen(cvalue);
    for (int i = 0; i < len; i++) {
        if(!isNumber(cvalue[i])){
            return FALSE;
        }
    }
    return TRUE;
}

/******************************************************************************
 函数名称  : md5
 函数描述  : md5加密密码
 输入参数  : userPassword 用户密码
 输出参数  : 加密后的密码
 返回值    : resultString
 备注      :	xu_fengyuan
 ******************************************************************************/
+ (NSString *) md5:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}


+ (CGSize)boundingRectWithSize:(CGSize)size message:(NSString *)msg
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    
    CGSize retSize = [msg boundingRectWithSize:size
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize;
}

+ (CGSize)boundingRectWithSize:(CGSize)size message:(NSString *)msg sysFont:(int)font
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    
    CGSize retSize = [msg boundingRectWithSize:size
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize;
}


#pragma mark - 各种设备屏幕尺寸适配

#define kBaseXCoordinate (320) //4寸设备的屏幕宽
#define kBaseYCoordinate (568) //4寸设备的屏幕高

+ (CGRect)getCommonFrame:(CGRect)sourceFrame
{
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    return CGRectMake(screenWidth * sourceFrame.origin.x / kBaseXCoordinate, screenHeight * sourceFrame.origin.y / kBaseYCoordinate, screenWidth * sourceFrame.size.width / kBaseXCoordinate, screenHeight * sourceFrame.size.height / kBaseYCoordinate);
}


+ (NSString *)getTime:(NSString *)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:time];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
    
}

+ (NSString *)getPointTime:(NSString *)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [formatter dateFromString:time];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    return [formatter stringFromDate:date];
    
}

/******************************************************************************
 函数名称	: isEmailAddress
 函数描述	: 邮箱格式校验
 输入参数	: email
 输出参数	: N/A
 返回值	: BOOL
 作者	: liu_guantong
 ******************************************************************************/
+ (BOOL) isEmailAddress:(NSString*)email
{
    NSString *emailRegex = @"^\\w+((\\-\\w+)|(\\.\\w+))*@[A-Za-z0-9]+((\\.|\\-)[A-Za-z0-9]+)*.[A-Za-z0-9]+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

// 将字典或者数组转化为JSON串
+ (NSString *)toJSONData:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil)
    {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    else
    {
        return nil;
    }
}


+ (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)getStage:(int)type
{
    NSString *returnString = nil;
    switch (type)
    {
        case 1:
            returnString = @"小学";
            break;
            
        case 2:
            returnString = @"中学";
            break;
            
        case 3:
            returnString = @"高中";
            break;
            
        default:
            break;
    }
    return returnString;
}

+ (CGSize)getSize:(NSString *)msg font:(int)font
{
    return [msg sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]}];
}

+ (NSString *)getGradeById:(NSString *)gradeId
{
    NSString *returnString = nil;
    switch ([gradeId intValue])
    {
        case 1:
            returnString = @"小学";
            break;
            
        case 2:
            returnString = @"中学";
            break;
            
        case 3:
            returnString = @"高中";
            break;
            
        default:
            break;
    }
    return returnString;
}


+ (NSString *)readDataBase:(NSString *)name
{
    BOOL isSuccess;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = [paths objectAtIndex:0];
    NSString *writeDBpath = [document stringByAppendingPathComponent:name];
    BOOL isContains = [fileManager fileExistsAtPath:writeDBpath];
    if (!isContains)
    {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
        isContains = [fileManager fileExistsAtPath:defaultDBPath];
        isSuccess = [fileManager copyItemAtPath:defaultDBPath toPath:writeDBpath error:&error];
        if (!isSuccess)
        {
            NSLog(@"%@",[error localizedDescription]);
        }
    }
    return writeDBpath;
}


+ (NSString *)getAppTime:(NSDate *)aDate
{
    NSString *returnString = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyyMMddHHmmss"];
//    NSDate *aDate = [formatter dateFromString:time];
    NSDate *now = [NSDate date];
    
    // 24*3600
    
    int seconds = [aDate timeIntervalSince1970] + [[NSTimeZone systemTimeZone] secondsFromGMT];
    int ymdSeconds = seconds - seconds % (24*3600);
    
    int todaySeconds = [[NSDate date] timeIntervalSince1970] + [[NSTimeZone systemTimeZone] secondsFromGMT];
    int todayYMDSeconds = todaySeconds - todaySeconds % (24*3600);
    int yesterdayYMDSeconds = todayYMDSeconds - 24*3600;
    if(yesterdayYMDSeconds == ymdSeconds)
    {
        [formatter setDateFormat:@"HH:mm"];
        NSString *sTime = [formatter stringFromDate:aDate];
        returnString = [NSString stringWithFormat:@"%@ %@",@"昨天",sTime];
        return returnString;
    }
    
    
    long long count = [now timeIntervalSinceDate:aDate];
    if (count < 60)
    {
        returnString = @"刚刚";
    }
    else if (count < 3600)
    {
        long long index = count/60;
        returnString = [NSString stringWithFormat:@"%lld分钟前",index];
    }
    else if (count > 3600 && count < 3600 * 24)
    {
        [formatter setDateFormat:@"HH:mm"];
        NSString *sTime = [formatter stringFromDate:aDate];
        returnString = sTime;
    }
    else if (count > 3600 * 24 && count < 3600 * 24 * 30)
    {
        [formatter setDateFormat:@"MM-dd HH:mm"];
        NSString *sTime = [formatter stringFromDate:aDate];
        returnString = sTime;
    }
    else  if (count > 3600 * 24 * 30 && count < 3600 * 24 * 30*12)
    {
        [formatter setDateFormat:@"MM-dd HH:mm"];
        NSString *sTime = [formatter stringFromDate:aDate];
        returnString = sTime;
    }
    else
    {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *sTime = [formatter stringFromDate:aDate];
        returnString = sTime;
    }
    return returnString;
}

+ (UIImage *)getNormalImage:(UIImage *)image withRect:(CGRect)rect
{
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}


+(NSString *)translation:(NSString *)arebic
{
    NSString *str = arebic;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    
    NSString *sumStr = [sums  componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
    if ([chinese length] >= 2)
    {
        NSString *first = [chinese substringToIndex:1];
        NSString *second = [chinese substringWithRange:NSMakeRange(1,1)];
        NSLog(@"%@,%@",first,second);
        if ([first isEqualToString:@"一"] && [second isEqualToString:@"十"])
        {
            chinese = [chinese substringFromIndex:1];
        }
    }
    
    NSLog(@"%@",str);
    NSLog(@"%@",chinese);
    return chinese;
}


//新建文件文件夹
+ (void)createSeleInfoDocument:(NSString *)userId
{
    //获取Documents文件夹目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentPath = [path objectAtIndex:0];
    //指定新建文件夹路径
    NSString *infoDocPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"self_%@",userId]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:infoDocPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:infoDocPath withIntermediateDirectories:NO attributes:nil error:nil];
        [self createMarketWithUserId:userId cMarketId:@"111"];
    }
}



//获取路路径
+ (void)createMarketWithUserId:(NSString *)userId cMarketId:(NSString *)marketId
{
    //获取Documents文件夹目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentPath = [path objectAtIndex:0];
    //指定新建文件夹路径
    NSString *marketPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"self_%@/mark_%@",userId,marketId]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:marketPath])
    {
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:marketPath withIntermediateDirectories:NO attributes:nil error:nil];
        NSString *mapPath = [marketPath stringByAppendingPathComponent:@"MapPath"];
        if (success)
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:mapPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
    }
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sunday", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}


+(JSONModel *) ParseDictionary2JsonModel:(NSDictionary *)result class:(NSString *)destClass {
    int errorCode = [result[@"errorCode"] intValue];
    if (errorCode == 0) {
        NSError *convertError =nil;
        Class aClass = NSClassFromString(destClass);
        
        JSONModel *destModel=[[aClass alloc]initWithDictionary:result error:&convertError];
        if (convertError) {
        }
        else
        {
            return destModel;
        }
    }
    else {
    }
    return nil;
}

+ (void)roundedLayer:(CALayer *)viewLayer
              radius:(float)r
              shadow:(BOOL)s
{
    [viewLayer setMasksToBounds:YES];
    [viewLayer setCornerRadius:r];
    [viewLayer setBorderColor:[RGB(180, 180, 180) CGColor]];
    [viewLayer setBorderWidth:1.0f];
    if(s)
    {
        [viewLayer setShadowColor:[UIColor lightGrayColor].CGColor];
        [viewLayer setShadowOffset:CGSizeMake(3, 3)];
        [viewLayer setShadowOpacity:0.8];
        [viewLayer setShadowRadius:10];
    }
    return;
}

@end
