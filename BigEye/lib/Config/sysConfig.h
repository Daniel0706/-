//
//  sysConfig.h
//  BigEye
//
//  Created by CR-IOS on 2017/4/8.
//  Copyright © 2017年 CR-IOS. All rights reserved.
//
#ifndef sysConfig_h
#define sysConfig_h

typedef enum : int{
    MainEntry_ONLINE          = 1,     //在线列表
    MainEntry_JOURNAL         = 2,     //日志列表
    MainEntry_AGENDA          = 3,     //日程列表
    MainEntry_ANNOUNCE        = 4,     //公告列表
    MainEntry_NEWONLINE       = 5,     //新建在线
    MainEntry_NEWJOURNAL      = 6,     //新建日志
    MainEntry_NEWAGENDA       = 7,     //新建日程
    MainEntry_SYSTEMNEWS      = 8,     //系统消息
    MainEntry_EXAMINE         = 9,     //审核消息
    MainEntry_AUTHORIZE       = 10,    //授权消息
    MainEntry_MAINTAIN        = 11,    //保养列表
    MainEntry_NEWMAINTAIN     = 12,    //新建保养
    MainEntry_MONITORING      = 13,    //监控
} selectBtnTag;



#pragma mark ---- 环信消息会话ID
#define WORKREMINDID        @"100"          // 工作提醒
#define MSGNOTIFICTIONID    @"102"          //消息通知
#define ATMINEID            @"101"          //@我的
#define ONLINETASKID        @"103"          //在线任务群
#define CHATLISTID          @"104"          //单人、群聊
#define CRHELPER            @"crwb_admin"   //从小容
#define ALARMSENDER         @"alarm_sender"   //报警提醒





//设备屏幕frame
#define kMainScreenFrameRect                          [[UIScreen mainScreen] bounds]
//状态栏高度
#define kMainScreenStatusBarFrameRect                 [[UIApplication sharedApplication] statusBarFrame]
#define kMainScreenHeight                             kMainScreenFrameRect.size.height
#define kMainScreenWidth                              kMainScreenFrameRect.size.width
//减去状态栏和导航栏的高度
#define kScreenHeightNoStatusAndNoNaviBarHeight       (kMainScreenFrameRect.size.height - kMainScreenStatusBarFrameRect.size.height-44.0f)

//减去状态栏和底部菜单栏高度
#define kScreenHeightNoStatusAndNoTabBarHeight       (kMainScreenFrameRect.size.height - kMainScreenStatusBarFrameRect.size.height-49.0f)

//减去状态栏和底部菜单栏以及导航栏高度
#define kScreenHeightNoStatusAndNoTabBarNoNavBarHeight       (kMainScreenFrameRect.size.height - kMainScreenStatusBarFrameRect.size.height-49.0f - 44.0f)
//底部工具栏高度
#define kTabBarHeight               49
//导航栏高度
#define kNavBarHeight               44
//获取系统版本
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
#define DownLoadURL @"https://itunes.apple.com/app/id1105709606"

#define BDMapSDKAppKey @"fM94yadRyAOsK4wiL4hYlCW8bURy2IhM"




#pragma mark ----- EASEMOBAPPKEY



//网络环境设置
//测试库
#define is_TestNetwork 1
#if is_TestNetwork
#define MAIN_URL            @"https://test.crongwb.com/api/"
#define WEB_URL             @"https://test.crongwb.com/"
//#define MAIN_URL            @"http://192.168.1.45:8080/saas/"
//#define MAIN_URL            @"http://192.168.1.234:9000/saas/"
//#define WEB_URL             @"http://192.168.1.234:9000/"

#define MAIN_IPADDR         @"http://121.41.115.54:8080/"
#define IMAGE_HEADURL       @"http://test-crimage.oss-cn-hangzhou.aliyuncs.com/"
//#define PUSHIDENTIFY        @"iOSDevelopmentPush"

#define PUSHIDENTIFY        @"DevelopmentPro"
#define EaseMobApp_Key      @"crwb2016#saastest"
//#define  EaseMobApp_Key     @"2016crwb#crwb" // 本地AppKey

/* ======================MQTT配置======================= */
//#define MQTTHOST        @"0e047b8d47d94ae4bc41ec8211483ef9.mqtt.iot.gz.baidubce.com"
#define MQTTPORT        @"1884"
#define MQTTCLIENT      @"MQTTClient";

#define MQTTHOST @"1276c076299147f19cdd782036e3b8b7.mqtt.iot.gz.baidubce.com" // 测试库地址

#else
#define WEB_URL          @"https://saas.crongwb.com/" //
#define MAIN_URL        @"https://saas.crongwb.com/api/"
#define MAIN_IPADDR     @"http://121.41.115.54:8080/"
#define IMAGE_HEADURL   @"http://real-crimage.oss-cn-hangzhou.aliyuncs.com/"
#define PUSHIDENTIFY    @"ProductionCer"
#define  EaseMobApp_Key   @"crwb2016#saas"

/* ======================MQTT配置======================= */
//#define MQTTHOST        @"0e047b8d47d94ae4bc41ec8211483ef9.mqtt.iot.gz.baidubce.com"
#define MQTTPORT        @"1884"
#define MQTTCLIENT      @"MQTTClient";
#define MQTTHOST @"6b132f75fef64d8b95418aea2e71c1bc.mqtt.iot.gz.baidubce.com" // 测试库地址


#endif




//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
///* 判定字符串是否为空 */
//#define STRING_ISNIL(__POINTER) (__POINTER == nil || [__POINTER isEqualToString:@""] || [__POINTER isEqualToString:@"(null)"] || [__POINTER isEqualToString:@"null"]|| [__POINTER isEqualToString:@"(NULL)"] || [__POINTER isEqualToString:@"NULL"] || [__POINTER isEqualToString:@"<null>"] || __POINTER == NULL || [__POINTER isKindOfClass:[NSNull class]] || [[__POINTER stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)?YES:NO
//
//#define STRING_ISNONIL(__POINTER) (__POINTER == nil || [__POINTER isEqualToString:@""] || [__POINTER isEqualToString:@"(null)"] || [__POINTER isEqualToString:@"null"]|| [__POINTER isEqualToString:@"(NULL)"] || [__POINTER isEqualToString:@"NULL"] || [__POINTER isEqualToString:@"<null>"] || __POINTER == NULL || [__POINTER isKindOfClass:[NSNull class]] || [[__POINTER stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)?NO:YES

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]
//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#pragma mark - 全局色系统一更改
//全局主题颜色
#define COLOR_GLOBAL_THEME          RGB(105,49,142)
//全局背景色
#define COLOR_GLOBAL_BACKGROUND     RGB(246,246,246)
//全局浅色分割线
#define COLOR_GLOBAL_SEPLINELIGHT   RGB(220,220,220)
//全局深色分割线
#define COLOR_GLOBAL_SEPLINEDEEP    RGB(200,200,200)
//全局灰色字体
#define COLOR_GLOBAL_GRAYFONT       RGB(150,150,150)
//全局红色字体
#define COLOR_GLOBAL_REDFONT        RGB(255,64,64)
//全局主题字体颜色
#define COLOR_GLOBAL_THEMEFONT      RGB(0,0,0)
//订单或记录等的状态颜色
#define COLOR_GLOBAL_THEMESTATUS    UIColorFromRGB(0xFFA640)

//网络错误信息提示
#define ALERT_LOACLNETWORKERR  UIAlertView *view=[[UIAlertView  alloc]initWithTitle:@"温馨提示" message:@"系统繁忙，请稍后再试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]; [view show];

#define ALERT_NETWORKERR UIAlertView *view=[[UIAlertView  alloc]initWithTitle:@"温馨提示" message:errorStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]; [view show];

#define DATEFORMATTER(dateString,Nowstring) NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; NSDate* inputDate = [dateFormatter dateFromString:dateString]; [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];NSString *Nowstring = [dateFormatter stringFromDate:inputDate];





#endif /* sysConfig_h */

