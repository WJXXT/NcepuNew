//
//  NewModel.h
//  NcepuNews
//
//  Created by 王新国 on 15/5/17.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"
@interface NewModel : NSObject
@property (strong, nonatomic) DataModel *arrays;
@property (strong, nonatomic) NSMutableArray *titile;
@property (strong, nonatomic) NSMutableArray *image;
@property (strong, nonatomic) NSMutableArray *text;
@property (strong, nonatomic) NSMutableArray *data;
//@property (strong, nonatomic) int *num;
@end
