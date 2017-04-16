//
//  NSString+Helper.m
//  CRWB
//
//  Created by CR-IOS on 16/3/7.
//  Copyright © 2016年 CR-IOS. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

+(BOOL)checkPhoneNumber:(NSString *)phoneStr
{
    
    if ([phoneStr length] == 0  ) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号码不能给空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
    }
    
    NSString *regex = @"^[1][3578][0-9]{9}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:phoneStr];
    
    if (!isMatch) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
    }
    
    return YES;
}
+ (BOOL)checkTextFieldIsNil:(NSString *)textStr{

    if ([textStr length] <= 20 && [textStr length] >=4) {
        return YES;
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入4~20位英文字符、数字、或下划线" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
}
+ (BOOL)checkCodeTextFieldIsNil:(NSString *)codeStr{
    if ( [codeStr length]==6) {
        return YES;
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入六位数字验证码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }

}
+ (BOOL)checkPasswordTextFieldIsTrue:(NSString *)password{
    if ([password length] >=6 &&[password length]<=16) {
        return YES;
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入6-16位密码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }

}
+(BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_-])+\\.([a-zA-Z0-9_-])+";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//+ (NSString *)getUserNameFromeLocalData{
//    LocalData *localData = [LocalData shareInstance];
//    
//    return localData.name;
//}
//+ (BOOL)checkCodeTextFieldIsTrue:(NSString *)codeTextStr WithPhoneStr:(NSString *)phoneStr{
//    NSString *codeStrUrl = [NSString stringWithFormat:@"%@register/toValCode",MAIN_URL];
//
//
//}
//+ (BOOL)checkPhoneNumberIsExist:(NSString *)phoneStr{
//    NSString *checkPhoneStr = [NSString stringWithFormat:@"%@register/existEmailPhone",MAIN_URL];
//    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
//    NSDictionary *parameterDic = @{@"subject":phoneStr};
//    [sessionManager GET:checkPhoneStr parameters:parameterDic progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//       
//        
//    }];
//
//}
//时间字符串转NSDate
+ (NSDate *) nsstringTransformToNSDataStr:(NSString *)dateStr{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formater dateFromString:dateStr];
    return date;
}
+ (NSDate *) nsstringTransformToNSTimeStr:(NSString *)dateStr{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setTimeZone:[NSTimeZone localTimeZone]];
    [formater setDateFormat:@"HH:mm"];
    NSDate *date = [formater dateFromString:dateStr];
    return date;
}
+ (NSString *)nsdateTransformToTimestamp :(NSDate *)date{
    NSString *timeStamp;
   timeStamp = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    return timeStamp;
}
+ (CGFloat) calculateStringHightWithString:(NSString *)str{
    UIFont *titleFont = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeMake(ScreenWidth - 20, 800);
    NSDictionary *textDic = [NSDictionary dictionaryWithObjectsAndKeys:titleFont,NSFontAttributeName,nil];
    size = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil].size;
    return size.height;
}
+ (CGFloat) calculateStringwidthWithString:(NSString *)str{

    UIFont *titleFont = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeMake(ScreenWidth - 20, 200);
    NSDictionary *textDic = [NSDictionary dictionaryWithObjectsAndKeys:titleFont,NSFontAttributeName,nil];
    size = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil].size;
    return size.width;

}
+ (CGFloat) calculateStringHightWithString:(NSString *)str WithCGRect:(CGSize) size WithFont:(UIFont *)font{
//    UIFont *titleFont = [UIFont systemFontOfSize:font];
       NSDictionary *textDic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    size = [str boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:textDic context:nil].size;
    return size.height;
}
+ (CGFloat) calculateStringwidthWithString:(NSString *)str WithCGRect:(CGSize) size WithFont:(UIFont *)font{
    
    NSDictionary *textDic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize rect = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:textDic context:nil].size;
    return rect.width;
}

+ (CGSize)sizeForText:(NSString *)text withMaxWidth:(CGFloat)maxWidth lineSpacing:(CGFloat)lineSpacing fontSize:(CGFloat)fontSize{
    NSMutableDictionary * attrDict = [[NSMutableDictionary alloc] init];
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    style.lineBreakMode = NSLineBreakByWordWrapping;
    [attrDict setObject:[UIFont systemFontOfSize:fontSize]  forKey:NSFontAttributeName];
    [attrDict setObject:style forKey:NSParagraphStyleAttributeName];
    CGSize strSize = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return strSize;

}
+ (CGSize)sizeForText:(NSString *)text withMaxWidth:(CGFloat)maxWidth withMaxHight:(CGFloat)maxHight lineSpacing:(CGFloat)lineSpacing fontSize:(CGFloat)fontSize{
    NSMutableDictionary * attrDict = [[NSMutableDictionary alloc] init];
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    style.lineBreakMode = NSLineBreakByWordWrapping;
    [attrDict setObject:[UIFont systemFontOfSize:fontSize]  forKey:NSFontAttributeName];
    [attrDict setObject:style forKey:NSParagraphStyleAttributeName];
    CGSize strSize = [text boundingRectWithSize:CGSizeMake(maxWidth, maxHight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return strSize;
    
}
// 解决UITextView 文字内容显示不全
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailTextView.font = [UIFont systemFontOfSize:fontSize];
    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    return deSize.height;
}
+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

+ (NSString *) changeToStringWithTimeStr:(NSString *)timeStr{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSDate *creatDate = [formatter dateFromString:timeStr];
    /* 时间戳字符串 */
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[creatDate timeIntervalSince1970]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:creatDate];
    NSInteger creatYear = comps.year;
    NSInteger creatMonth = comps.month;
    NSInteger creatDay = comps.day;
    NSDate *currentDate = [NSDate date];
    NSDateComponents *sendComs = [calendar components:unitFlags fromDate:currentDate];
    NSInteger currentYear  = sendComs.year;
    NSInteger currentMonth = sendComs.month;
    NSInteger currentDay   =  sendComs.day;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    if (creatYear == currentYear) {
        /* 今年的对话 */
        if (creatMonth == currentMonth && creatDay == currentDay) {
            /* 当天 */
            fmt.dateFormat = @"HH:mm"; /* 当天 */
        }else{
            fmt.dateFormat = @"MM/dd HH:mm"; /* 当年 */
        }
    }else{
        /* 不是当年的对话 */
        fmt.dateFormat = @"yyyy/MM/dd HH:mm";
    }
    return [fmt stringFromDate:creatDate];
}
+ (NSString *) conversationtimeWithMessageSubmitterTime:(NSString *)submitTimeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSDate *creatDate = [formatter dateFromString:submitTimeStr];
    /* 时间戳字符串 */
    //    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[creatDate timeIntervalSince1970]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:creatDate];
    NSInteger creatYear = comps.year;
    NSInteger creatMonth = comps.month;
    NSInteger creatDay = comps.day;
    NSDate *currentDate = [NSDate date];
    NSDateComponents *sendComs = [calendar components:unitFlags fromDate:currentDate];
    NSInteger currentYear  = sendComs.year;
    NSInteger currentMonth = sendComs.month;
    NSInteger currentDay   =  sendComs.day;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    if (creatYear == currentYear) {
        /* 今年的对话 */
        if (creatMonth == currentMonth && creatDay == currentDay) {
            /* 当天 */
            fmt.dateFormat = @"HH:mm"; /* 当天 */
        }else{
            fmt.dateFormat = @"MM/dd"; /* 当年 */
        }
    }else{
        /* 不是当年的对话 */
        fmt.dateFormat = @"yyyy/MM/dd";
    }
    return [fmt stringFromDate:creatDate];

}
//时间的转换
+(NSString *)conversationTime:(long long)time
{
    //今天11:20
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:currentDate];
    NSInteger currentYear = comps.year;
    NSInteger currentMonth = comps.month;
    NSInteger currentDay = comps.day;
    
    NSDate *sendDate = [NSDate dateWithTimeIntervalSince1970:time/1000];
    NSDateComponents *sendComs = [calendar components:unitFlags fromDate:sendDate];
    
    NSInteger sendYear = sendComs.year;
    NSInteger sendMonth = sendComs.month;
    NSInteger sendDay = sendComs.day;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    if (sendYear == currentYear) {
        /* 今年的对话 */
        if (sendMonth == currentMonth && sendDay == currentDay) {
            /* 当天 */
            fmt.dateFormat = @"HH:mm"; /* 当天 */
        }else{
            fmt.dateFormat = @"MM/dd"; /* 当年 */
        }
    }else{
        /* 不是当年的对话 */
        fmt.dateFormat = @"YYYY/MM/dd";
    }
    return [fmt stringFromDate:sendDate];
}

//时间的转换
+(NSString *)conversationTimeWithRegularFormer:(long long)time;
{
    //今天11:20
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:currentDate];
    NSDate *sendDate = [NSDate dateWithTimeIntervalSince1970:time/1000];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  
    /* 不是当年的对话 */
    fmt.dateFormat = @"YYYY.MM.dd HH:mm";
    return [fmt stringFromDate:sendDate];
}

+(NSString *)change13BitsTimeStrTo10BitsDateString:(NSString *)timeStr{

    NSTimeInterval _interval=[[timeStr substringToIndex:10] doubleValue];
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:_interval];
    //实例化一个NSDateFormatter对象
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}

+ (NSString *)changeDeviceModelPriceLevelToStr:(NSString *)level{
    NSString *priceLevel;
    switch ([level intValue]) {
        case 0:
            priceLevel = @"元级别";
            break;
        case 1:
            priceLevel = @"十元级别";
            break;
        case 2:
            priceLevel = @"百元级别";
            break;
        case 3:
            priceLevel = @"千元级别";
            break;
        case 4:
            priceLevel = @"万元级别";
            break;
        case 5:
            priceLevel = @"十万元级别";
            break;
        case 6:
            priceLevel = @"百万元级别";
            break;
        default:
            break;
    }
    return priceLevel;
}

+ (NSString *)changeDeviceModelTypeToStr:(NSString *)type{
    NSString *deviceCategory;
    
    switch ([type intValue]) {
        case 510000019:
            deviceCategory = @"主机";
            break;
        case 510000020:
            deviceCategory = @"锅炉";
            break;
        case 510000021:
            deviceCategory = @"水泵";
            break;
        case 510000022:
            deviceCategory = @"阀门";
            break;
        case 510000023:
            deviceCategory = @"风机";
            break;
        case 510000024:
            deviceCategory = @"冷却塔";
            break;
        case 510000025:
            deviceCategory = @"空气处理机组";
            break;
        case 510000026:
            deviceCategory = @"风机盘管";
            break;
        case 510000027:
            deviceCategory = @"换热器";
            break;
        case 510000028:
            deviceCategory = @"计量仪表";
            break;
        case 510000029:
            deviceCategory = @"动力柜";
            break;
        case 510000030:
            deviceCategory = @"控制柜";
            break;
            
        default:
            deviceCategory = @"其他";
            
            break;
    }
    return deviceCategory;
}
+ (NSString *)changeDeviceModelDeviceSystemToStr:(NSString *)system{
    NSString *deviceSystem;
    switch ([system intValue]) {
        case 510000001:
            deviceSystem = @"暖通";
            break;
        case 510000002:
            deviceSystem = @"给排水";
            break;
        case 510000003:
            deviceSystem = @"电梯";
            break;
        case 510000004:
            deviceSystem = @"输配电";
            break;
        case 510000005:
            deviceSystem = @"照明";
            break;
        case 510000006:
            deviceSystem = @"设备集控";
            break;
        case 510000007:
            deviceSystem = @"能源管理";
            break;
        case 510000008:
            deviceSystem = @"智能化";
            break;
            
        default:
            break;
    }
    return deviceSystem;
}
+  (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/* 字典转json 字符串 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:nil error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+(NSString *)ReplacingNewLineAndWhitespaceCharactersFromJson:(NSString *)dataStr{
    NSScanner *scanner = [[NSScanner alloc] initWithString:dataStr];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableString *result = [[NSMutableString alloc] init];
    
    NSString *temp;
    NSCharacterSet*newLineAndWhitespaceCharacters = [ NSCharacterSet newlineCharacterSet];
    // 扫描
    while (![scanner isAtEnd])
    {
        temp = nil;
        [scanner scanUpToCharactersFromSet:newLineAndWhitespaceCharacters intoString:&temp];
        if (temp) [result appendString:temp];
        
        // 替换换行符
        if ([scanner scanCharactersFromSet:newLineAndWhitespaceCharacters intoString:NULL]) {
            if (result.length > 0 && ![scanner isAtEnd]) // Dont append space to beginning or end of result
                [result appendString:@""];
        }
    }
    return result;
}
+ (NSString *)changeDataSizeWithFolatValue:(float)value{

    NSString *returnStr;

    if (!returnStr) {
        if (value > 1024) {
            float sizeInt  = value / 1024.0;
            if (sizeInt < 1024) {
                returnStr = [NSString stringWithFormat:@"%fKB", sizeInt];
            }else{
                float MBSize = sizeInt/1024.0;
                if (MBSize<1024) {
                    returnStr = [NSString stringWithFormat:@"%.2fMB", MBSize];
                }else{
                    float GBSize = MBSize/1024.0;
                    if (GBSize < 1024) {
                        returnStr = [NSString stringWithFormat:@"%.2fGB", GBSize];
                    }else{
                        returnStr = [NSString stringWithFormat:@"未知"];
                    }
                }
            }
        }else{
            returnStr = [NSString stringWithFormat:@"%.2fB", value];
        }
    }
    return returnStr;
}

+(NSString *)ret32bitString
{
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

#pragma mark --- 申报类型选择
+ (NSString *)changeReviewTypeEnumToReviewString:(NSString *)typeEnum{

    NSString *reviewTypeStr;
    if ([typeEnum isEqualToString:@"LEAVE"]) {
        reviewTypeStr = @"请假申报";
    }else if ([typeEnum isEqualToString:@"TRIP"]){
        reviewTypeStr = @"出差申报";
    }else if ([typeEnum isEqualToString:@"REIMBURSE"]){
        reviewTypeStr = @"报销申报";
    }else if ([typeEnum isEqualToString:@"ATTACHMENT"]){
        reviewTypeStr = @"备件领用申报";
    }else if ([typeEnum isEqualToString:@"PURCHASE"]){
        reviewTypeStr = @"采购申报";
    }else if ([typeEnum isEqualToString:@"COMMON"]){
        reviewTypeStr = @"通用申报";
    }else{
        
    }
    
    return reviewTypeStr;
}
+ (NSInteger )changeReviewStatusToTypeEnumTo:(NSString *)typeEnum{
    
    NSInteger reviewTypeStr;
    if ([typeEnum isEqualToString:@"不限"]) {
        reviewTypeStr = 4;
    }else if ([typeEnum isEqualToString:@"审批中"]){
        reviewTypeStr = 0;
    }else if ([typeEnum isEqualToString:@"已同意"]){
        reviewTypeStr = 1;
    }else if ([typeEnum isEqualToString:@"已拒绝"]){
        reviewTypeStr = 2;
    }else if ([typeEnum isEqualToString:@"已撤回"]){
        reviewTypeStr = 3;
    }else{
    }
    return reviewTypeStr;
}
+ (NSInteger )changeReviewTypeToTypeEnum:(NSString *)typeEnum{
    
    NSInteger reviewTypeStr;
    if ([typeEnum isEqualToString:@"不限"]) {
        reviewTypeStr = 6;
    }else if ([typeEnum isEqualToString:@"请假申报"]){
        reviewTypeStr = 0;
    }else if ([typeEnum isEqualToString:@"出差申报"]){
        reviewTypeStr = 1;
    }else if ([typeEnum isEqualToString:@"报销申报"]){
        reviewTypeStr = 2;
    }else if ([typeEnum isEqualToString:@"备件领用申报"]){
        reviewTypeStr = 3;
    }else if ([typeEnum isEqualToString:@"采购申报"]){
        reviewTypeStr = 4;
    }else if ([typeEnum isEqualToString:@"通用申报"]){
        reviewTypeStr = 5;
    }else{
    }
    return reviewTypeStr;
}
+ (NSString *)changeEnumTypeToTypeString:(NSString *)typeEnum{

    NSString *typeStr;
    if ([typeEnum isEqualToString:@"COMPASSIONATE_LEAVE"]) {
        typeStr = @"事假";
    }else if ([typeEnum isEqualToString:@"SICK_LEAVE"]){
        typeStr = @"病假";
    }else if ([typeEnum isEqualToString:@"MATERNITY_LEAVE"]){
        typeStr = @"产假";
    }else if ([typeEnum isEqualToString:@"MARITAL_LEAVE"]){
        typeStr = @"婚假";
    }else if ([typeEnum isEqualToString:@"ANNUAL_LEAVE"]){
        typeStr = @"年假";
    }else if ([typeEnum isEqualToString:@"OTHER_LEAVE"]){
        typeStr = @"其他";
    }
    return typeStr;
}
+ (NSString *)changeEnumResultToResultString:(NSString *)resultEnum{
    
    NSString *typeStr;
    if ([resultEnum isEqualToString:@"WAITING"]) {
        typeStr = @"";
    }else if ([resultEnum isEqualToString:@"AGREE"]){
        typeStr = @"审批结果-已同意图标";
    }else if ([resultEnum isEqualToString:@"REFUSE"]){
        typeStr = @"审批结果-已拒绝图标";
    }else if ([resultEnum isEqualToString:@"WITHDRAW"]){
        typeStr = @"";
    }
    return typeStr;
}

+ (NSString *)conversationTimeLongToTimeStr:(NSString *)timeLong{
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:[timeLong doubleValue]/1000];
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:detailDate];
    return currentDateStr;
}

@end
