//
//  MainViewController.m
//  NcepuNews
//
//  Created by 王新国 on 15/5/5.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "MainViewController.h"
#import "LeftMenu.h"
#import "NavigationController.h"
#import "NewsViewController.h"
#import "New2ViewController.h"
#import "TitleView.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "News3ViewController.h"

#define HMNavShowAnimDuration 0.25
#define HMCoverTag 100
#define HMLeftMenuW 150
#define HMLeftMenuH 300
#define HMLeftMenuY 50
#define HMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HMRandomColor HMColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface MainViewController () <LeftMenuDelegate>
/**
 *  正在显示的导航控制器
 */
@property (nonatomic, weak) NavigationController *showingNavigationController;
//@property (nonatomic, strong) RightMenuController *rightMenuVc;
@property (nonatomic, weak) LeftMenu *leftMenu;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建子控制器
    [self setupAllChildVcs];
    
    // 2.添加左菜单
    [self setupLeftMenu];
    
    // 3.添加右菜单
    [self setupRightMenu];
}

/**
 *  添加右菜单
 */
- (void)setupRightMenu
{

}

/**
 *  添加左菜单
 */
- (void)setupLeftMenu
{
    LeftMenu *leftMenu = [[LeftMenu alloc] init];
    leftMenu.delegate = self;
    leftMenu.height = HMLeftMenuH;
    leftMenu.width = HMLeftMenuW;
    leftMenu.y = HMLeftMenuY;
    [self.view insertSubview:leftMenu atIndex:1];
    self.leftMenu = leftMenu;
}

/**
 *  创建子控制器
 */
- (void)setupAllChildVcs
{
    // 1.新闻控制器
    NewsViewController *news = [[NewsViewController alloc] init];
    [self setupVc:news title:@"校园新闻"];
    
    // 2.订阅控制器
    New2ViewController *news2 = [[New2ViewController alloc] init];
    [self setupVc:news2 title:@"就业新闻"];
    
    // 3.图片控制器
    News3ViewController *new3 = [[News3ViewController alloc] init];
    [self setupVc:new3 title:@"控计院新闻"];
    
//    // 4.视频控制器
//    UIViewController *video = [[UIViewController alloc] init];
//    [self setupVc:video title:@"视频"];
//    
//    // 5.跟帖控制器
//    UIViewController *comment = [[UIViewController alloc] init];
//    [self setupVc:comment title:@"跟帖"];
//    
//    // 6.电台控制器
//    UIViewController *radio = [[UIViewController alloc] init];
//    [self setupVc:radio title:@"电台"];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 *  初始化一个控制器
 *
 *  @param vc      需要初始化的控制器
 *  @param title   控制器的标题
 */
- (void)setupVc:(UIViewController *)vc title:(NSString *)title
{
    // 1.设置背景色
    vc.view.backgroundColor = HMRandomColor;
    
    // 2.设置标题
    TitleView *titleView = [[TitleView alloc] init];
    titleView.title = title;
    vc.navigationItem.titleView = titleView;
    
    // 3.设置左右按钮
    vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"top_navigation_menuicon" target:self action:@selector(leftMenuClick)];
    vc.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"top_navigation_infoicon" target:self action:@selector(rightMenuClick)];
    
    // 4.包装一个导航控制器
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
    // 让newsNav成为self（HMMainViewController）的子控制器，能保证：self在，newsNav就在
    // 如果两个控制器互为父子关系，那么它们的view也应该互为父子关系
    [self addChildViewController:nav];
}

#pragma mark - 监听导航栏按钮点击
- (void)leftMenuClick
{
    self.leftMenu.hidden = NO;
//    self.rightMenuVc.view.hidden = YES;
    
    [UIView animateWithDuration:HMNavShowAnimDuration animations:^{
        // 取出正在显示的导航控制器的view
        UIView *showingView = self.showingNavigationController.view;
        
        // 缩放比例
        CGFloat navH = [UIScreen mainScreen].bounds.size.height - 2 * HMLeftMenuY;
        CGFloat scale = navH / [UIScreen mainScreen].bounds.size.height;
        
        // 菜单左边的间距
        CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width * (1 - scale) * 0.5;
        CGFloat translateX = HMLeftMenuW - leftMenuMargin;
        
        CGFloat topMargin = [UIScreen mainScreen].bounds.size.height * (1 - scale) * 0.5;
        CGFloat translateY = HMLeftMenuY - topMargin;
        
        // 缩放
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
        // 平移
        CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX / scale, translateY / scale);
        
        showingView.transform = translateForm;
        
        // 添加一个遮盖
        UIButton *cover = [[UIButton alloc] init];
        cover.tag = HMCoverTag;
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        cover.frame = showingView.bounds;
        
        [showingView addSubview:cover];
        
    }];
}

- (void)coverClick:(UIView *)cover
{
    [UIView animateWithDuration:HMNavShowAnimDuration animations:^{
        self.showingNavigationController.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [cover removeFromSuperview];
    }];
}

- (void)rightMenuClick
{
    self.leftMenu.hidden = YES;
//    self.rightMenuVc.view.hidden = NO;
    
    [UIView animateWithDuration:HMNavShowAnimDuration animations:^{
        // 取出正在显示的导航控制器的view
        UIView *showingView = self.showingNavigationController.view;
        
        // 缩放比例
        CGFloat navH = [UIScreen mainScreen].bounds.size.height - 2 * HMLeftMenuY;
        CGFloat scale = navH / [UIScreen mainScreen].bounds.size.height;
        
        // 菜单左边的间距
        CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width * (1 - scale) * 0.5;
//        CGFloat translateX = leftMenuMargin - self.rightMenuVc.view.width;
        
        CGFloat topMargin = [UIScreen mainScreen].bounds.size.height * (1 - scale) * 0.5;
        CGFloat translateY = HMLeftMenuY - topMargin;
        
        // 缩放
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
        // 平移
//        CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX / scale, translateY / scale);
        
//        showingView.transform = translateForm;
        
        // 添加一个遮盖
        UIButton *cover = [[UIButton alloc] init];
        cover.tag = HMCoverTag;
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        cover.frame = showingView.bounds;
        [showingView addSubview:cover];
    } completion:^(BOOL finished) {
//        [self.rightMenuVc didShow];
    }];
}

#pragma mark - HMLeftMenuDelegate
- (void)leftMenu:(LeftMenu *)menu didSelectedButtonFromIndex:(int)fromIndex toIndex:(int)toIndex
{

    // 0.移除旧控制器的view
    NavigationController *oldNav = self.childViewControllers[fromIndex];
    [oldNav.view removeFromSuperview];

    // 1.显示新控制器的view
    NavigationController *newNav = self.childViewControllers[toIndex];
    [self.view addSubview:newNav.view];
    
    // 2.设置新控制的transform跟旧控制器一样
    newNav.view.transform = oldNav.view.transform;
    // 设置阴影
 
    newNav.view.layer.shadowColor = [UIColor blackColor].CGColor;
    newNav.view.layer.shadowOffset = CGSizeMake(-3, 0);
    newNav.view.layer.shadowOpacity = 0.2;
    
    // 一个导航控制器的view第一次显示到它的父控件上时，如果transform的缩放值被改了，上面的20高度当时是不会出来
    
    // 2.设置当前正在显示的控制器
    self.showingNavigationController = newNav;
    
    // 3.点击遮盖
    [self coverClick:[newNav.view viewWithTag:HMCoverTag]];
}
@end
