//
//  NewsViewController.m
//  NcepuNews
//
//  Created by 王新国 on 15/5/5.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "NewsViewController.h"
#import "TFHpple.h"
#import "newViewController.h"
#import "DataModel.h"
#import "MBProgressHUD.h"

#define HMCoverTag 100

@implementation NewsViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

}
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrays.ncepuNewsHtmlArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *identifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
}
//
//    MBProgressHUD *progress_ = [[MBProgressHUD alloc] initWithView:self.tableView];
//    [self.view addSubview:progress_];
//    [self.view bringSubviewToFront:progress_];
//    progress_.delegate = self;
//    progress_.labelText = @"加载中...";
//    [progress_ show:YES];
   
     cell.textLabel.text =_arrays.ncepuNewsTitleArray[indexPath.row];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];

    cell.textLabel.backgroundColor=[UIColor clearColor];
//
    UIImage *image = [UIImage imageNamed:@"1.png"];
    cell.imageView.image=image;
    cell.detailTextLabel.text = _arrays.ncepuNewsDataArray[indexPath.row];
//     [self.tableView reloadInputViews];
//        [progress_ removeFromSuperview];
//        [progress_ release];
//         });
  return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

//
//
//#pragma mark - Table view delegate
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     newViewController  *detailViewController = [[newViewController alloc] init];
         [self.navigationController pushViewController:detailViewController animated:YES];
            detailViewController.title =@"新闻";
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    
    temporaryBarButtonItem.title =@"返回";
    
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    UIScrollView *scrollview =[[UIScrollView alloc]init];
    [detailViewController.view addSubview: scrollview];
    scrollview.frame =CGRectMake(0, 0, detailViewController.view.frame.size.width, detailViewController.view.frame.size.height);
    scrollview.backgroundColor = [UIColor whiteColor];
    _titile =[[UILabel alloc]init];
    _titile.text= _arrays.ncepuNewsTitleArray[indexPath.row];
    _titile.frame =CGRectMake(25,10 , detailViewController.view.frame.size.width-50, 50);
    _titile.font =[UIFont boldSystemFontOfSize:20];
    _titile.lineBreakMode = UILineBreakModeWordWrap;
    _titile.textAlignment= UITextAlignmentCenter;
    _titile.numberOfLines = 0;
    [scrollview addSubview:_titile];

    _time =[[UILabel alloc]init];
    _time.text=_arrays.ncepuNewsDataArray[indexPath.row];
    _time.frame =CGRectMake(25,60 , detailViewController.view.frame.size.width-50, 15);
    _time.font =[UIFont boldSystemFontOfSize:15];
    _time.textAlignment= UITextAlignmentRight;
    [scrollview addSubview:_time];
    _text =[[UILabel alloc]init];
    _text.text = _arrays.ncepuNewsTextArray[indexPath.row];
    _text.font =[UIFont boldSystemFontOfSize:15];
    _text.numberOfLines = 0;
    _text.lineBreakMode = UILineBreakModeWordWrap;
    CGSize size = CGSizeMake(300,600);
    CGSize labelsize = [_text.text sizeWithFont:_text.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        [scrollview addSubview:_text];
            _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(25, 85, detailViewController.view.frame.size.width-50 ,160)];
    if ([[_arrays.ncepuNewsImageArray objectAtIndex:indexPath.row] isEqual:@"http://www.ncepu.edu.cn/"]==YES) {
        _text.frame =CGRectMake(10,80, labelsize.width, labelsize.height);
   scrollview.contentSize =CGSizeMake(detailViewController.view.frame.size.width, labelsize.height+160);
    }
    else{
        _imageView.image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_arrays.ncepuNewsImageArray objectAtIndex:indexPath.row]]]];
                      [scrollview addSubview:_imageView];
        _text.frame =CGRectMake(10,250, labelsize.width, labelsize.height);
   scrollview.contentSize =CGSizeMake(detailViewController.view.frame.size.width, labelsize.height+320);

    }

}
- (DataModel *)arrays
{
                          if (!_arrays) {
                           NSString *string = @"http://www.ncepu.edu.cn/tztg/index.htm";
                           _arrays = [[DataModel alloc]init];
                           [_arrays NcepuNewsHtml:string];
                              _arrays.a=0;
                       }
//    dispatch_async(
//                   
//                                      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

    if (_arrays.a<[_arrays.ncepuNewsHtmlArray count]) {
        for (int i = 0; i<[_arrays.ncepuNewsHtmlArray count]; i++) {

            [_arrays NcepuNewsData:_arrays.ncepuNewsHtmlArray[i]];
            [_arrays NcepuNewsImage:_arrays.ncepuNewsHtmlArray[i]];
                [_arrays NcepuNewsText:_arrays.ncepuNewsHtmlArray[i]];
                [_arrays NcepuNewsTitle:_arrays.ncepuNewsHtmlArray[i]];
            _arrays.a++;
        }
    }
//                                          dispatch_async(dispatch_get_main_queue(), ^{
//
//                                              // 回到主线程，执行UI刷新操作
//                                              [self.tableView reloadData];
//                                          });
//                                                                                });
                    return _arrays;
}
//-(void)loaddata{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    if (_arrays.a<[_arrays.ncepuNewsHtmlArray count]) {
//        for (int i = 0; i<[_arrays.ncepuNewsHtmlArray count]; i++) {
//            
//            [_arrays NcepuNewsData:_arrays.ncepuNewsHtmlArray[i]];
//            [_arrays NcepuNewsImage:_arrays.ncepuNewsHtmlArray[i]];
//            [_arrays NcepuNewsText:_arrays.ncepuNewsHtmlArray[i]];
//            [_arrays NcepuNewsTitle:_arrays.ncepuNewsHtmlArray[i]];
//            _arrays.a++;
//        }
//    }
//            [self.tableView reloadData];
//        });
//}
@end
