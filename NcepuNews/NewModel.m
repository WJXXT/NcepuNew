//
//  NewModel.m
//  NcepuNews
//
//  Created by 王新国 on 15/5/17.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "NewModel.h"
@implementation NewModel
- (DataModel *)arrays
{
    if (!_arrays) {
        //                           _arrays = [[DataModel alloc]init];
        NSString *string = @"http://www.ncepu.edu.cn/tztg/index.htm";
        _arrays = [[DataModel alloc]init];
        [_arrays NcepuNewsHtml:string];
//        _num =_arrays.ncepuNewsHtmlArray.count;
        NSLog(@"dsad");
    }
    //
    //    dispatch_async(
    //
    //                                      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    for(NSString *object in _arrays.ncepuNewsHtmlArray) {
        [_arrays NcepuNewsData:object];
        [_arrays NcepuNewsTitle:object];
        [_arrays NcepuNewsText:object];
        [_arrays NcepuNewsImage:object];
    }
    _data =_arrays.ncepuNewsDataArray;
    _titile = _arrays.ncepuNewsTitleArray;
    _image = _arrays.ncepuNewsImageArray;
    _text =  _arrays.ncepuNewsTextArray;
    //                           NSLog(@"%@",_arrays.ncepuNewsTitleArray);
    //                                          dispatch_async(dispatch_get_main_queue(), ^{
    //
    //                                              // 回到主线程，执行UI刷新操作
    //                                              [self.tableView reloadData];
    //                                          });
    //
    //                                      });
    
    
    //    NSLog(@"%@",_arrays.ncepuNewsTitleArray);
    //    NSLog(@"%@",_arrays.ncepuNewsDataArray);
    //    NSLog(@"%@",_arrays.ncepuNewsImageArray);
    //    NSLog(@"%@",_arrays.ncepuNewsTextArray);
    return _arrays;
}

@end
