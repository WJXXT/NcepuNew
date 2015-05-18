//
//  NavigationBar.m
//  NcepuNews
//
//  Created by 王新国 on 15/5/5.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "NavigationBar.h"
#import "UIView+Extension.h"

@implementation NavigationBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIButton *button in self.subviews) {
        if (![button isKindOfClass:[UIButton class]]) continue;
        
        if (button.centerX < self.width * 0.5) { // 左边的按钮
            button.x = 0;
        } else if (button.centerX > self.width * 0.5) { // 右边的按钮
            button.x = self.width - button.width;
        }
    }
}
@end
