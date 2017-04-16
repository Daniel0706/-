//
//  MyTabbarViewController.m
//  CongRongWeiBao
//
//  Created by CR-IOS on 16/3/1.
//  Copyright © 2016年 储兆伟. All rights reserved.
//

#import "MyTabbarViewController.h"

#import "MyTabBarItem.h"
//#import "HomeViewController.h"
//#import "onlineShopViewController.h"
//#import "LeftSortsViewController.h"
//#import "AddButton.h"
//#import "NewOnlineViewController.h"
//#import "NewBuildJournalViewController.h"
//#import "RenewAgendaViewController.h"
//#import "OthersViewController.h"
//#import "RebuildHomeViewController.h"
//#import "EaseMobMessageViewController.h"
#import "ViewController1.h"
#import "ViewController.h"


@interface MyTabbarViewController ()
{
    UIImageView     *_myTabbar;
    UIView          *_backGroundView;
}
@property (nonatomic,assign) NSInteger unreadCount;

@end

@implementation MyTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建视图控制器
    [self createViewControllers];
    
    //创建标签栏
    [self createTabbar];
    
    //创建标签
    [self createTabbarItems];
    //获取未读消息
//    [self getUnreadMessage];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUnreadMessage) name:@"reciveMessage" object:nil];
    
    
}

-(void)getUnreadMessage
{


    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger allNum = 0;
//        NSArray *conversationArray =  [[EMClient sharedClient].chatManager getAllConversations];
//        for (EMConversation *conversation in conversationArray) {
//            if (conversation.unreadMessagesCount!=0) {
//                allNum = 1;
//                break;
//            }
//        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (allNum == 0) {
                UITabBar *tabbar = self.tabBar;
                UITabBarItem *tabItem = [tabbar.items objectAtIndex:1];
        
                UIImage *noImage = [[UIImage imageNamed:@"logo_消息_未选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                tabItem.image = noImage;
                UIImage *selectImage = [[UIImage imageNamed:@"logo_消息_选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                tabItem.selectedImage = selectImage;
        
            }else
            {
                UITabBar *tabbar = self.tabBar;
                UITabBarItem *tabItem = [tabbar.items objectAtIndex:1];
                UIImage *noImage = [[UIImage imageNamed:@"logo_消息_未选中_有消息"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                tabItem.image =noImage;
                UIImage *selectImage = [[UIImage imageNamed:@"logo_消息_选中_有消息"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                tabItem.selectedImage = selectImage;
        
            }
            
        });
    });

    



}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)createViewControllers
{
    //首页
//    HomeViewController *homeVC = [[HomeViewController alloc] init];
//    UINavigationController *navHomeVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    ViewController1 *homeVC = [[ViewController1 alloc] init];
    UINavigationController *navHomeVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    ViewController1 *mesaageViewController = [[ViewController1 alloc] init];
    UINavigationController *navMessageVC = [[UINavigationController alloc] initWithRootViewController:mesaageViewController];

    
    //商城
    ViewController *onlineShopVC = [[ViewController alloc] init];
    UINavigationController *navOnlineShopVC = [[UINavigationController alloc] initWithRootViewController:onlineShopVC];
    
    //知库
    ViewController *MineVC = [[ViewController alloc] init];
    UINavigationController *navKnowledgeVC = [[UINavigationController alloc] initWithRootViewController:MineVC];
    
    self.viewControllers = @[navHomeVC,navMessageVC,navOnlineShopVC,navKnowledgeVC];
}

-(void)createTabbar
{
    _myTabbar = [[UIImageView alloc]initWithFrame:self.tabBar.bounds];
    _myTabbar.image = [UIImage imageNamed:@"tabbar_bg"];
    _myTabbar.userInteractionEnabled = YES;
    [self.tabBar addSubview:_myTabbar];
}

-(void)createTabbarItems
{
    NSArray *titleArray = @[@"工作",@"消息",@"项目搜索",@"我的"];
    
    NSArray *imageArray = @[@"logo_工作_未选中",
                            @"logo_消息_未选中",
                            @"icon_搜索-未选中",
                            @"icon_我的_-未选中"];
    
    NSArray *imageSelectedArray = @[@"logo_工作_选中",
                                    @"logo_消息_选中",
                                    @"icon_搜索-选中",
                                    @"icon_我的_-选中"];
    for (int i = 0; i<titleArray.count; i++) {
        UITabBar *tabbar = self.tabBar;
        UITabBarItem *tabItem = [tabbar.items objectAtIndex:i];
        tabItem.title =titleArray[i];
        UIColor *titleHighlightedColor = RGB(31, 147, 68);
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
        UIImage *noImage =[[UIImage imageNamed:imageArray[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabItem.image =noImage;
        UIImage *selectImage =[[UIImage imageNamed:imageSelectedArray[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabItem.selectedImage =selectImage;
    }
}

- (void) newBuildButtonClick{
//
//    _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    _backGroundView.backgroundColor = RGBA(0, 0, 0, 0.3);
//    [self.view.window addSubview:_backGroundView];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 200, ScreenWidth, 200)];
//    view.backgroundColor = RGBA(254, 254, 254, 0.7);
//    [_backGroundView addSubview:view];
//    
//    UILabel *label = [[UILabel alloc] initForAutoLayout];
//    [view addSubview:label];
//    [label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:view withOffset:-50];
//    [label autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:view withOffset:0];
//    [label autoSetDimension:ALDimensionWidth toSize:ScreenWidth];
//    [label autoSetDimension:ALDimensionHeight toSize:50];
//    label.backgroundColor = [UIColor whiteColor];
//    
//    NSArray *newImageArr = @[@"在线维保logo",@"日志logo",@"日程图标"];
//    
//    for (int i = 0; i<3; i++) {
//        AddButton *btn = [[AddButton alloc] initForAutoLayout];
//        [view addSubview:btn];
//        btn.tag = 35000+i;
//        [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:view withOffset:30];
//        [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:view withOffset:30 + 100*(i)];
//        [btn autoSetDimension:ALDimensionHeight toSize:80];
//        [btn autoSetDimension:ALDimensionWidth toSize:80];
//        [btn setImage:[UIImage imageNamed:newImageArr[i]] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(newButtonclick:) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//
//    _backGroundView.userInteractionEnabled = YES;
//    //添加手势
//    UITapGestureRecognizer *ViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewTap:)];
//    [_backGroundView addGestureRecognizer:ViewTap];
//
}
- (void)newButtonclick:(UIButton *)btn{
//    [_backGroundView removeFromSuperview];
//    
//    NSInteger btnTag = btn.tag - 35000;
//    if (btnTag == 0) {
//        NSLog(@"%ld",(long)btnTag);
//        NewOnlineViewController *newOnlineViewC = [[NewOnlineViewController alloc] init];
//        newOnlineViewC.isFromHomeViewController = YES;
//        UINavigationController *new = [[UINavigationController alloc] initWithRootViewController:newOnlineViewC];
//        [self presentViewController:new animated:YES completion:nil];
//        
//    }else if (btnTag == 1){
//        NSLog(@"%ld",(long)btnTag);
//        NewBuildJournalViewController *newBuildVC = [[NewBuildJournalViewController alloc] init];
//        newBuildVC.isFromHomeViewController = YES;
//        [self.navigationController pushViewController:newBuildVC animated:YES];
//    }else if (btnTag == 2){
//        NSLog(@"%ld",(long)btnTag);
//        RenewAgendaViewController *renewAgendaVC = [[RenewAgendaViewController alloc] init];
//        renewAgendaVC.isFromHomeViewController = YES;
//        [self.navigationController pushViewController:renewAgendaVC animated:YES];
//    }
}

- (void) backViewTap:(UIGestureRecognizer *) sender{
    [_backGroundView removeFromSuperview];
}
-(void)tabbarAction:(UIButton *)item
{
    //取消所有按钮的选中状态
    for (MyTabBarItem *item in _myTabbar.subviews) {
        if ([item isKindOfClass:[UIButton class]]) {
            item.selected = NO;
        }
    }
    
    item.selected = YES;
    NSInteger index = item.tag - 100;
    self.selectedIndex = index;
    
}


@end
