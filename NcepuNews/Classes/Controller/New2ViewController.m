//
//  New2ViewController.m
//  NcepuNews
//
//  Created by 王新国 on 15/5/5.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "New2ViewController.h"
#import "newViewController.h"
#import "DataModel1.h"
@implementation New2ViewController
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

    return self.arrays2.ncepuNewsHtmlArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text =_arrays2.ncepuNewsTitleArray[indexPath.row];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    
    cell.textLabel.backgroundColor=[UIColor clearColor];
    //
    UIImage *image = [UIImage imageNamed:@"1.png"];
    cell.imageView.image=image;
    cell.detailTextLabel.text = _arrays2.ncepuNewsDataArray[indexPath.row];
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
    _titile.text= _arrays2.ncepuNewsTitleArray[indexPath.row];
    _titile.frame =CGRectMake(25,10 , detailViewController.view.frame.size.width-50, 50);
    _titile.font =[UIFont boldSystemFontOfSize:20];
    _titile.lineBreakMode = UILineBreakModeWordWrap;
    _titile.textAlignment= UITextAlignmentCenter;
    _titile.numberOfLines = 0;
    [scrollview addSubview:_titile];
    
    _time =[[UILabel alloc]init];
    _time.text=_arrays2.ncepuNewsDataArray[indexPath.row];
    _time.frame =CGRectMake(25,60 , detailViewController.view.frame.size.width-50, 15);
    _time.font =[UIFont boldSystemFontOfSize:15];
    _time.textAlignment= UITextAlignmentRight;
    [scrollview addSubview:_time];
    _text =[[UILabel alloc]init];
    _text.text = _arrays2.ncepuNewsTextArray[indexPath.row];
    _text.font =[UIFont boldSystemFontOfSize:15];
    _text.numberOfLines = 0;
    _text.lineBreakMode = UILineBreakModeWordWrap;
    CGSize size = CGSizeMake(300,600);
    CGSize labelsize = [_text.text sizeWithFont:_text.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [scrollview addSubview:_text];
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(25, 85, detailViewController.view.frame.size.width-50 ,160)];
    if ([[_arrays2.ncepuNewsImageArray objectAtIndex:indexPath.row] isEqual:@"http://www.ncepu.edu.cn/"]==YES) {
        _text.frame =CGRectMake(10,80, labelsize.width, labelsize.height);
        scrollview.contentSize =CGSizeMake(detailViewController.view.frame.size.width, labelsize.height+160);
    }
    else{
        _imageView.image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_arrays2.ncepuNewsImageArray objectAtIndex:indexPath.row]]]];
        [scrollview addSubview:_imageView];
        _text.frame =CGRectMake(10,250, labelsize.width, labelsize.height);
        scrollview.contentSize =CGSizeMake(detailViewController.view.frame.size.width, labelsize.height+320);
        
    }
    

}


- (DataModel1 *)arrays2
{
    if (!_arrays2) {
        _arrays2 = [[DataModel1 alloc]init];
        NSString *string = @"http://job.ncepu.edu.cn/xwgg/tzgg/index.htm";
//        _arrays2 = [[DataModel alloc]init];
        [_arrays2 NcepuNewsHtml:string];
                              _arrays2.a=0;
        
    }

    if (_arrays2.a<[_arrays2.ncepuNewsHtmlArray count]) {
        for (int i = 0; i<[_arrays2.ncepuNewsHtmlArray count]; i++) {
            
            [_arrays2 NcepuNewsData:_arrays2.ncepuNewsHtmlArray[i]];
            [_arrays2 NcepuNewsImage:_arrays2.ncepuNewsHtmlArray[i]];
            [_arrays2 NcepuNewsText:_arrays2.ncepuNewsHtmlArray[i]];
            [_arrays2 NcepuNewsTitle:_arrays2.ncepuNewsHtmlArray[i]];
            _arrays2.a++;
        }
    }
    return _arrays2;
}
//

@end
