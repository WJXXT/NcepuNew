//
//  NewsViewController.h
//  NcepuNews
//
//  Created by 王新国 on 15/5/5.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "MBProgressHUD.h"
//#import "allmodel.h"
@interface NewsViewController : UITableViewController <MBProgressHUDDelegate>
//@property(strong,atomic)allmodel *arrayq;
@property (strong, nonatomic) DataModel *arrays;
//@property (nonatomic, strong) IBOutlet UITableViewCell *NewsCell;
@property (strong,nonatomic) UILabel *titile;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) UILabel *text;
@property (strong,nonatomic) MBProgressHUD *progress_;
@end
