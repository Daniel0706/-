//
//  AppDelegate.m
//  BigEye
//
//  Created by CR-IOS on 2017/4/8.
//  Copyright © 2017年 CR-IOS. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabbarViewController.h"
#import "ATLNewFeatureControl.h"
#import "MyTabbarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    
    [self initLocalData];
    [self initNavigationBar];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [application setStatusBarHidden:NO];
    [application setStatusBarStyle:UIStatusBarStyleDefault];
    
//    ATLNewFeatureControl *tabVC = [[ATLNewFeatureControl alloc] init];
    
    MyTabbarViewController *tabVC = [[MyTabbarViewController alloc] init];
    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:tabVC];
    self.window.rootViewController = tabVC;
    
    return YES;
}
#pragma mark - 初始化NavigationBar
- (void)initNavigationBar {
    [[UINavigationBar appearance] setBarTintColor:RGBCOLOR(250, 250, 250)];
    if ([CurrentSystemVersion compare:@"8.0"] != NSOrderedAscending) {
        [UINavigationBar appearance].autoresizesSubviews = YES;
    }
    [[UINavigationBar appearance] setAlpha:1];
    
}

#pragma mark -- 本地数据载入
- (void)initLocalData{
    LocalData *localData = [LocalData shareInstance];
    BOOL bInitOK = [localData initFromUserDefaults];
    if (!bInitOK) {
        localData.userIsLogin = @"false";
        
        [localData localDataSave];
    }
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





@end
