//
//  BaseViewController.h
//  CRWB
//
//  Created by CR-IOS on 16/3/2.
//  Copyright © 2016年 CR-IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic,copy) NSString *processStr;

@property (nonatomic,strong) UIButton *buildButton;
//@property (nonatomic,strong) UIImageView  *noDataImage;


- (void)loadingStart;

- (void)loadingEnd;


@end
