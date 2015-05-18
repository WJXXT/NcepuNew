//
//  News3ViewController.m
//  NcepuNews
//
//  Created by 王新国 on 15/5/5.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "News3ViewController.h"
#import "TFHpple.h"
#import "newViewController.h"
#import "DataModel2.h"

@implementation News3ViewController 
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
    
    //    NSLog(@"%d",self.arrays.ncepuNewsHtmlArray.count);
    return self.arrays3.ncepuNewsHtmlArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text =_arrays3.ncepuNewsTitleArray[indexPath.row];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    //  NSLog(@"%@",_array.ncepuNewsTitleArray[1]);
    //        [cell.contentView addSubview:imageView];
    //       [cell.contentView addSubview:lab];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    //
    UIImage *image = [UIImage imageNamed:@"1.png"];
    cell.imageView.image=image;
    cell.detailTextLabel.text = _arrays3.ncepuNewsDataArray[indexPath.row];
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
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = detailViewController.view.bounds;
    webView.backgroundColor= [UIColor whiteColor];
    webView.delegate = self;
    // 伸缩页面至填充整个webView
    webView.scalesPageToFit = YES;
    // 隐藏scrollView
//    webView.scrollView.hidden = YES;
//http://m.dianping.com/tuan/deal/5501525
    
    // 2.加载网页
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_arrays3.ncepuNewsHtmlArray[indexPath.row]]];
    [webView loadRequest:request];
        [detailViewController.view addSubview:webView];
    // 3.创建
//    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    [loadingView startAnimating];
//    loadingView.center = CGPointMake(160, 240);
//    [self.view addSubview:loadingView];
//    self.loadingView = loadingView;
    
    // 2.加载网页
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/MJServer/resources/htmls/test.html"]];
//    [webView loadRequest:request];
//    UIScrollView *scrollview =[[UIScrollView alloc]init];
//    [detailViewController.view addSubview: scrollview];
//    scrollview.frame =CGRectMake(0, 0, detailViewController.view.frame.size.width, detailViewController.view.frame.size.height);
//    scrollview.backgroundColor = [UIColor whiteColor];
//    _titile =[[UILabel alloc]init];
//    _titile.text= _arrays3.ncepuNewsTitleArray[indexPath.row];
//    _titile.frame =CGRectMake(25,10 , detailViewController.view.frame.size.width-50, 50);
//    _titile.font =[UIFont boldSystemFontOfSize:20];
//    _titile.lineBreakMode = UILineBreakModeWordWrap;
//    _titile.textAlignment= UITextAlignmentCenter;
//    _titile.numberOfLines = 0;
//    [scrollview addSubview:_titile];
//    
//    _time =[[UILabel alloc]init];
//    _time.text=_arrays3.ncepuNewsDataArray[indexPath.row];
//    _time.frame =CGRectMake(25,60 , detailViewController.view.frame.size.width-50, 15);
//    _time.font =[UIFont boldSystemFontOfSize:15];
//    _time.textAlignment= UITextAlignmentRight;
//    [scrollview addSubview:_time];
//    _text =[[UILabel alloc]init];
//    _text.text = _arrays3.ncepuNewsTextArray[indexPath.row];
//    _text.font =[UIFont boldSystemFontOfSize:15];
//    _text.numberOfLines = 0;
//    _text.lineBreakMode = UILineBreakModeWordWrap;
//    CGSize size = CGSizeMake(300,600);
//    CGSize labelsize = [_text.text sizeWithFont:_text.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
//    [scrollview addSubview:_text];
//    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(25, 85, detailViewController.view.frame.size.width-50 ,160)];
//    if ([[_arrays3.ncepuNewsImageArray objectAtIndex:indexPath.row] isEqual:@"http://www.ncepu.edu.cn/"]==YES) {
//        _text.frame =CGRectMake(10,80, labelsize.width, labelsize.height);
//        scrollview.contentSize =CGSizeMake(detailViewController.view.frame.size.width, labelsize.height+160);
//    }
//    else{
//        _imageView.image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_arrays3.ncepuNewsImageArray objectAtIndex:indexPath.row]]]];
//        [scrollview addSubview:_imageView];
//        _text.frame =CGRectMake(10,250, labelsize.width, labelsize.height);
//        scrollview.contentSize =CGSizeMake(detailViewController.view.frame.size.width, labelsize.height+320);
//        
//    }
}
#pragma mark - UIWebViewDelegate
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    NSMutableString *js1 = [NSMutableString string];
//        NSMutableString *js2 = [NSMutableString string];
//    // 利用webView执行js代码，操作网页中的节点
//    [js1 appendString:@"var header = document.getElementsByTagName('header')[0];"];
//    [js1 appendString:@"header.parentNode.removeChild(header);"];
//    [js2 appendString:@"var EC_ECHSYSCLeft = document.getElementsByTagName('EC_ECHSYSCLeft')[0];"];
//    [js2 appendString:@"EC_ECHSYSCLeft.parentNode.removeChild(EC_ECHSYSCLeft);"];
//    
//    [webView stringByEvaluatingJavaScriptFromString:js1];
//    [webView stringByEvaluatingJavaScriptFromString:js2];
//}

- (DataModel2 *)arrays3
{
    if (!_arrays3) {
        NSString *string = @"http://cce.ncepu.edu.cn/xwzx/tztg/index.htm";
        _arrays3 = [[DataModel2 alloc]init];
        [_arrays3 NcepuNewsHtml:string];
        _arrays3.a=0;
    }
    //    dispatch_async(
    //
    //                                      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    if (_arrays3.a<[_arrays3.ncepuNewsHtmlArray count]) {
        for (int i = 0; i<[_arrays3.ncepuNewsHtmlArray count]; i++) {
            
            [_arrays3 NcepuNewsData:_arrays3.ncepuNewsHtmlArray[i]];
//            [_arrays3 NcepuNewsImage:_arrays3.ncepuNewsHtmlArray[i]];
//            [_arrays3 NcepuNewsText:_arrays3.ncepuNewsHtmlArray[i]];
            [_arrays3 NcepuNewsTitle:_arrays3.ncepuNewsHtmlArray[i]];
            _arrays3.a++;
        }
    }
    //                                          dispatch_async(dispatch_get_main_queue(), ^{
    //
    //                                              // 回到主线程，执行UI刷新操作
    //                                              [self.tableView reloadData];
    //                                          });
    //                                                                                });
    return _arrays3;
}


@end
