//
//  LeftMenu.m
//  NcepuNews
//
//  Created by 王新国 on 15/5/5.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "LeftMenu.h"
#import "LeftMenuButton.h"
#import "UIImage+Extension.h"
#import "UIView+Extension.h"
#define HMColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
@interface LeftMenu()
@property (nonatomic, weak) LeftMenuButton *selectedButton;
@end

@implementation LeftMenu

#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat alpha = 0.2;
        
        [self setupBtnWithIcon:@"sidebar_nav_news" title:@"校园新闻" bgColor:HMColorRGBA(202, 68, 73, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_reading" title:@"就业新闻" bgColor:HMColorRGBA(190, 111, 69, alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_photo" title:@"控计院新闻" bgColor:HMColorRGBA(76, 132, 190, alpha)];
//        [self setupBtnWithIcon:@"sidebar_nav_video" title:@"视频" bgColor:HMColorRGBA(101, 170, 78, alpha)];
//        [self setupBtnWithIcon:@"sidebar_nav_comment" title:@"跟帖" bgColor:HMColorRGBA(170, 172, 73, alpha)];
//        [self setupBtnWithIcon:@"sidebar_nav_radio" title:@"电台" bgColor:HMColorRGBA(190, 62, 119, alpha)];
    }
    return self;
}

- (void)setDelegate:(id<LeftMenuDelegate>)delegate
{
    _delegate = delegate;
    
    // 默认选中新闻按钮
    [self buttonClick:[self.subviews firstObject]];

    //    [self buttonClick:self.subviews[1]];
}

/**
 *  添加按钮
 *
 *  @param icon  图标
 *  @param title 标题
 */
- (LeftMenuButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title bgColor:(UIColor *)bgColor
{
    LeftMenuButton *btn = [[LeftMenuButton alloc] init];
    btn.tag = self.subviews.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    
    // 设置图片和文字
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置按钮选中的背景
    [btn setBackgroundImage:[UIImage imageWithColor:bgColor] forState:UIControlStateSelected];
    
    // 设置高亮的时候不要让图标变色
    btn.adjustsImageWhenHighlighted = NO;
    
    // 设置按钮的内容左对齐
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    int btnCount = self.subviews.count;
    CGFloat btnW = self.width;
    CGFloat btnH = self.height / btnCount;
    for (int i = 0; i<btnCount; i++) {
        LeftMenuButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = i * btnH;
    }
}

#pragma mark - 私有方法
/**
 *  监听按钮点击
 */
- (void)buttonClick:(LeftMenuButton *)button
{
    // 0.通知代理
    if ([self.delegate respondsToSelector:@selector(leftMenu:didSelectedButtonFromIndex:toIndex:)]) {
        [self.delegate leftMenu:self didSelectedButtonFromIndex:self.selectedButton.tag toIndex:button.tag];

    }

    // 1.控制按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}
@end
