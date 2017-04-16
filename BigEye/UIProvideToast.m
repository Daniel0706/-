/*****************************************************************
 文件名称 : UIProvideToast.m 文件
 作 者 : He_Ping
 创建时间 : 2012-07-14
 文件描述 : 已给的高保真Toast视图
 ****************************************************************/

#import <QuartzCore/QuartzCore.h>
#import "UIProvideToast.h"
#import "AppDelegate.h"
#define WIDTH_INTERVAL_FROM_IMAGE 14
#define HEIGHT_INTERVAL_FROM_IMAGE 8
#define TOAST_BOUNDS CGSizeMake(28, 32)
#define TOAST_TEXT_WIDTH 196
#define TEXT_FONT [UIFont fontWithName:@"HelveticaNeue" size:16.0]
#define VIEW_BACKGROUND_COLOR [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.6f]

@implementation UIProvideToast

@synthesize dimissDuration;

//开始动画
- (void)beginAnimationWithDuration:(CGFloat)duTime{
	[UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:duTime];
}

//结束动画
- (void)commitModalAnimationsWithSelector:(SEL)seletor
{
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:seletor];
	[UIView commitAnimations];
}

// 在屏幕的中间显示toast提示
- (void)show:(NSString*)content
{
    animation = 0;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *rootView = appDelegate.window;
    CGRect rect = rootView.screen.bounds;
    CGSize labFrame = [content sizeWithFont:TEXT_FONT  constrainedToSize:CGSizeMake(TOAST_TEXT_WIDTH, 400) 
                              lineBreakMode:NSLineBreakByWordWrapping];
    CGSize size = TOAST_BOUNDS;
    labFrame.width += size.width;
	labFrame.height += size.height;
    
    //设置view边框
    if (rect.size.height == 568)
    {
        self.frame = CGRectMake((rect.size.width-labFrame.width)/2, (rect.size.height-labFrame.height)/2,
                                labFrame.width, labFrame.height);
    }
    else
    {
        self.frame = CGRectMake((rect.size.width-labFrame.width)/2, (rect.size.height-labFrame.height)/2 - 10,
                                labFrame.width, labFrame.height);
    }

    self.layer.cornerRadius = 12;
    self.backgroundColor = VIEW_BACKGROUND_COLOR;
    
    //设置文字输入框
    UILabel *labelTip = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_INTERVAL_FROM_IMAGE, HEIGHT_INTERVAL_FROM_IMAGE, 
                                                                  labFrame.width - 2 * WIDTH_INTERVAL_FROM_IMAGE, 
                                                                  labFrame.height - 2 * HEIGHT_INTERVAL_FROM_IMAGE)];        
    labelTip.textAlignment = NSTextAlignmentCenter;
    labelTip.backgroundColor = [UIColor clearColor];
    labelTip.textColor = [UIColor whiteColor];
    labelTip.text = content;
    labelTip.font = TEXT_FONT;
    labelTip.lineBreakMode = NSLineBreakByWordWrapping;
    labelTip.numberOfLines = 0;
    [self addSubview:labelTip];
    
    if (IOS_SDK_VERSION >= 8)
    {
        self.transform = CGAffineTransformMakeRotation(0);
    }
    else
    {
        //横竖屏判断，方向旋转  肖亚东 2014/8/25
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft)
        {
            self.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }
        else if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight)
        {
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    }
        
    
    [rootView addSubview:self];    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:self.dimissDuration > 0 ? self.dimissDuration : 0.5];
}

// 在屏幕的任意高度显示toast提示
- (void)show:(NSString*)content withHeight:(float)aHeight
{
    animation = 0;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *rootView = appDelegate.window;
    CGRect rect = rootView.screen.bounds;
    CGSize labFrame = [content sizeWithFont:TEXT_FONT  constrainedToSize:CGSizeMake(TOAST_TEXT_WIDTH, 400) 
                              lineBreakMode:NSLineBreakByWordWrapping];
    CGSize size = TOAST_BOUNDS;
    labFrame.width += size.width;
	labFrame.height += size.height;
    
    //设置view边框
    self.frame = CGRectMake((rect.size.width-labFrame.width)/2, aHeight, 
                            labFrame.width, labFrame.height);
    self.layer.cornerRadius = 12;
    self.backgroundColor = VIEW_BACKGROUND_COLOR;
    
    //设置文字输入框
    UILabel *labelTip = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_INTERVAL_FROM_IMAGE, HEIGHT_INTERVAL_FROM_IMAGE, 
                                                                  labFrame.width - 2 * WIDTH_INTERVAL_FROM_IMAGE, 
                                                                  labFrame.height - 2 * HEIGHT_INTERVAL_FROM_IMAGE)];        
    labelTip.textAlignment = NSTextAlignmentCenter;
    labelTip.backgroundColor = [UIColor clearColor];
    labelTip.textColor = [UIColor whiteColor];
    labelTip.text = content;
    labelTip.font = TEXT_FONT;
    labelTip.lineBreakMode = NSLineBreakByWordWrapping;
    labelTip.numberOfLines = 0;
    [self addSubview:labelTip];
    
    [rootView addSubview:self];    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:self.dimissDuration > 0 ? self.dimissDuration : 0.5];
}

//隐藏窗口
- (void)dismiss
{
    switch (animation++) 
    {
        case 0:
        {
            [self beginAnimationWithDuration:1];
            self.alpha = 0.1f;
			[self commitModalAnimationsWithSelector:@selector(dismiss)];
            break;
        }
        case 1:
        {
            NSInteger vLength = [self.subviews count];
            while (vLength-->0) 
            {
                UIView *v = [self.subviews objectAtIndex:vLength];
                [v removeFromSuperview];
            }
            [self removeFromSuperview];
            break;
        }
        default:
			break;
	}
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
