//
//  MyTabBarItem.m
//  爱限免
//
//  Created by huangdl on 15/8/13.
//  Copyright (c) 2015年 黄驿. All rights reserved.
//

#import "MyTabBarItem.h"

@implementation MyTabBarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [self setTitleColor:[UIColor colorWithRed:0.36f green:0.36f blue:0.36f alpha:1.00f] forState:UIControlStateNormal];
        
        [self setTitleColor: RGBCOLOR(31, 147, 68) forState:UIControlStateSelected];
        
    }
    return self;
}

//去掉高亮状态
-(void)setHighlighted:(BOOL)highlighted
{}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 30, contentRect.size.width, 15);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (_identify) {
        return CGRectMake((contentRect.size.width - 20)/2, 10, 40, 40);
    }else{
        return CGRectMake((contentRect.size.width - 20)/2, 5, 20, 20);
    }
}





@end
