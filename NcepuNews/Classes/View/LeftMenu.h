//
//  LeftMenu.h
//  NcepuNews
//
//  Created by 王新国 on 15/5/5.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class LeftMenu;

@protocol LeftMenuDelegate <NSObject>
@optional
- (void)leftMenu:(LeftMenu *)menu didSelectedButtonFromIndex:(int)fromIndex toIndex:(int)toIndex;
@end
@interface LeftMenu : UIView <MBProgressHUDDelegate>
@property (nonatomic, weak) id<LeftMenuDelegate> delegate;

@end
