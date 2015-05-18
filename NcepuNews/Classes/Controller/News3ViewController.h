//
//  News3ViewController.h
//  NcepuNews
//
//  Created by 王新国 on 15/5/5.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel2.h"
@interface News3ViewController : UITableViewController <UIWebViewDelegate>
@property (strong, nonatomic) DataModel2 *arrays3;
//@property (nonatomic, strong) IBOutlet UITableViewCell *NewsCell;
@property (strong,nonatomic) UILabel *titile;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UILabel *time;
@property (strong,nonatomic) UILabel *text;
@end
