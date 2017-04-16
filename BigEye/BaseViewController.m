//
//  BaseViewController.m
//  CRWB
//
//  Created by CR-IOS on 16/3/2.
//  Copyright © 2016年 CR-IOS. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
@interface BaseViewController ()<UIGestureRecognizerDelegate>
{
    
    MBProgressHUD *_hud;
    id<UIGestureRecognizerDelegate> _delegate;

}

@end

@implementation BaseViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    
    [self setBackBtn];
    [self initNavigationBarRightView];
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;  /* 因为复写了返回方法，所以需要重新设置代理，实现左滑返回上一级页面的功能  */
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 63.5, ScreenWidth, 0.5)];
    label.backgroundColor = RGB(217, 217, 217);
    [self.navigationController.view addSubview:label];
    
    
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    edgePanGestureRecognizer.delegate = self;
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanGestureRecognizer];
    
    

}
#pragma mark -- 新建内容
- (void) initNavigationBarRightView{
    _buildButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buildButton setBackgroundImage:[UIImage imageNamed:@"icon_新建"] forState:UIControlStateNormal];
    [_buildButton addTarget:self action:@selector(rightBtnItemBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _buildButton.frame=CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:_buildButton];
    self.navigationItem.rightBarButtonItem = leftItem;
    _buildButton.hidden = YES;
}
- (void) rightBtnItemBtnClick {



}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.navigationController.viewControllers.count > 1;
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    
}

- (void)pan:(UIPanGestureRecognizer*)gesture {
    [self endEidt];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [self setTabBar];

}
- (void)setTabBar {
    
    if (1 == self.navigationController.viewControllers.count) {
        self.tabBarController.tabBar.hidden = NO;
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;//
    } else {
//        _delegate = self.navigationController.interactivePopGestureRecognizer.delegate;//
        self.tabBarController.tabBar.hidden = YES;
    }
}
#pragma mark setTitle
/* 重写setTitle方法 */
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    UILabel *lable = [[UILabel alloc]init];
    lable.font = [UIFont systemFontOfSize:18];
    lable.textColor = RGB(51, 51, 51);
    lable.text = title;
    [lable sizeToFit];
    self.navigationItem.titleView = lable;
}
#pragma mark NavigationBar backBtn
/* 设置返回按钮 */
- (void)setBackBtn {
    NSArray * arryCtrls = self.navigationController.viewControllers;
    if (arryCtrls.count > 1) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 44, 44);
        [backBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        UIImage *image = [UIImage imageNamed:@"icon_返回"];//Back_Arrow
        [backBtn setImage:image forState:UIControlStateNormal];
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 10)];
        [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        /* leftBarButton设置 */
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        [negativeSpacer setWidth:-10];
        self.navigationItem.leftBarButtonItems = @[negativeSpacer,left];
        //        self.navigationItem.leftBarButtonItem = left;
        
    }
}
/* 返回按钮点击调用方法 */
- (void)backBtnClick {
    [self endEidt];
    
    [self.navigationController popViewControllerAnimated:YES];
}



/* 结束编辑模式 */
- (void)endEidt {
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window endEditing:YES];
}
-(void)loadingStart
{
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (_processStr) {
        _hud.labelText = _processStr;
    }else{
        _hud.labelText = @"加载中...";
    }
    _hud.labelFont = [UIFont systemFontOfSize:14.0f];
    _hud.mode = MBProgressHUDModeIndeterminate;//可以显示不同风格的进度；
}

-(void)loadingEnd
{
    [_hud hide:YES afterDelay:0];
}
//*************方法二*****************//
- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer*)edgePanGestureRecognizer{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark- UIGestureRecognizerDelegate
//**************方法二****************//
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    if (self.navigationController && [self.navigationController.viewControllers count] == 1) {
//        return NO;
//    }
//    return YES;
//}

@end
