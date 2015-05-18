//
//  DataModel.h
//  NcepuNews
//
//  Created by 王新国 on 15/5/11.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DataModel : NSObject
@property (strong, nonatomic) NSMutableArray *ncepuNewsHtmlArray;
@property (strong, nonatomic) NSMutableArray *ncepuNewsTitleArray;
@property (strong, nonatomic) NSMutableArray *ncepuNewsDataArray;
@property (strong, nonatomic) NSMutableArray *ncepuNewsImageArray;
@property (strong, nonatomic) NSMutableArray *ncepuNewsTextArray;
@property(assign,nonatomic) int a;

//@property (strong,nonatomic)DataModel *arrays;
-(NSMutableArray *)NcepuNewsHtml:(NSString *)htmlString;

-(NSMutableArray *)NcepuNewsTitle:(NSString *)htmlString;
-(NSMutableArray *)NcepuNewsData:(NSString *)htmlString;


-(NSMutableArray *)NcepuNewsText:(NSString *)htmlString;

-(NSMutableArray *)NcepuNewsImage:(NSString *)htmlString;

@end
