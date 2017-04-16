/*****************************************************************
 文件名称 : UIProvideToast.h 文件
 作 者 : He_Ping
 创建时间 : 2012-07-14
 文件描述 : 已给的高保真Toast视图
 ****************************************************************/

#import <UIKit/UIKit.h>

#define IOS_SDK_VERSION    [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]

@interface UIProvideToast : UIView
{
    NSInteger animation;
    NSTimeInterval dimissDuration;
}

@property (nonatomic,assign) NSTimeInterval dimissDuration;

//快速显示toast
-(void)show:(NSString*)content;

// 在屏幕的任意高度显示toast提示
- (void)show:(NSString*)content withHeight:(float)aHeight;

@end
