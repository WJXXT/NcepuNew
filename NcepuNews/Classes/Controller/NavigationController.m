//
//  NavigationController.m
//  NcepuNews
//
//  Created by 王新国 on 15/5/5.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "NavigationController.h"
#import "NavigationBar.h"

@interface NavigationController ()

@end

@implementation NavigationController

+ (void)initialize
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置导航栏背景
    [appearance setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - 这个方法也是专门用来布局子控件（当控制器的view尺寸发生改变的时候会调用）

//}

@end
