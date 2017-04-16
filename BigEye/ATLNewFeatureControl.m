//
//  ATLNewFeatureControl.m
//  Aotianlai
//
//  Created by apple on 17/1/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ATLNewFeatureControl.h"
#import "ViewController.h"
#import "MyTabbarViewController.h"

#define KMPicNum 3
#define viewsize self.view.bounds.size
#define NewFeatureImageCount 3

@interface ATLNewFeatureControl ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)UIButton *checkBox;

@end

@implementation ATLNewFeatureControl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self scrollView];
    
    [self setupPageControl];
    
}


- (void)scrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(KMPicNum*viewsize.width,  0);
    
    scrollView.pagingEnabled = YES;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.bounces = NO;
    
    scrollView.delegate = self;
    
    for (int index = 0; index < NewFeatureImageCount; index++) {
        
        NSString *name = [NSString stringWithFormat:@"00%d.jpg",index+1];
        
        UIImageView *image= [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
        
        image.frame = CGRectMake(index * scrollView.frame.size.width, 0, viewsize.width, viewsize.height);
        
        [scrollView addSubview:image];
        
        if (index == NewFeatureImageCount - 1) {
            [self startBtn:image];
        
            image.userInteractionEnabled = YES;
        }
    }
    
}


- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    pageControl.numberOfPages = NewFeatureImageCount;
    
    CGFloat centerX = self.view.frame.size.width *0.5;
    
    CGFloat centerY = self.view.frame.size.height-30;
    
    pageControl.center = CGPointMake(centerX, centerY);
    
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    
    pageControl.userInteractionEnabled = NO;
    
    [self.view addSubview:pageControl];
    
    self.pageControl = pageControl;
    
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    pageControl.pageIndicatorTintColor = [UIColor orangeColor];
    

}



- (void)startBtn:(UIImageView *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    [button setTitle:@"开始体验" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake((viewsize.width - 100) / 2, 350, 100, 30);
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [button addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    
    [image addSubview:button];
    
    
    UIButton *checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [checkBox setTitle:@"我是书僮机器人" forState:UIControlStateNormal];
    
    [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
    
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateSelected];
    
    checkBox.frame = CGRectMake((viewsize.width - 200)/2, button.frame.origin.y - 30, 200, 30);
    
    [checkBox addTarget:self action:@selector(checkBoxAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [image addSubview:checkBox];
    
    
    
}

- (void)start:(UIButton *)startBtn{
   // self.view.window.rootViewController =[[UIViewController alloc] init];
        //ViewController *CON = [[ViewController alloc] init];
    
    MyTabbarViewController *TAB = [[MyTabbarViewController alloc] init];
    
    self.view.window.rootViewController = TAB;
  //  [self presentModalViewController:TAB animated:YES];

}

- (void)checkBoxAction:(UIButton *)checkBox
{
    checkBox.selected = !checkBox.selected;
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    double pageDouble =offsetX / scrollView.frame.size.width;
    
    int pageInt = (int)(pageDouble+0.5);
    
    self.pageControl.currentPage=pageInt;
    





}




@end
