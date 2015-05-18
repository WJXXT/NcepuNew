//
//  New2ViewController.h
//  NcepuNews
//
//  Created by 王新国 on 15/5/5.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>
#import "DataModel1.h"

@interface New2ViewController : UITableViewController <MBProgressHUDDelegate>
@property (strong, nonatomic) DataModel1 *arrays2;
@property (strong,nonatomic) UILabel *titile;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) UILabel *text;

@end
