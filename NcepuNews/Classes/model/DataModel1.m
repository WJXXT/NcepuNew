//
//  DataModel1.m
//  NcepuNews
//
//  Created by 王新国 on 15/5/12.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "DataModel1.h"
#import "TFHpple.h"
@implementation DataModel1
-(NSMutableArray *)NcepuNewsHtml:(NSString *)htmlString
{
    NSString *title=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    NSRange range = [title rangeOfString:@"<div class=\"text_r01\">"];
    NSMutableString *needTidyString= [NSMutableString stringWithString:[title substringFromIndex:range.location]];
    //    NSLog(@"%@",needTidyString);
    //    NSLog(@"%@",range.location);
    NSRange rang2 =[needTidyString rangeOfString:@"</ul>"];
    NSMutableString *html2 =[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];
    //    NSLog(@"%@",html2);
    NSData *dataTitle=[html2 dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//a"];
    
    
    //    NSMutableArray *arrayURL2 = [[NSMutableArray alloc] init ];
    _ncepuNewsHtmlArray = [[NSMutableArray alloc]init];
    for (TFHppleElement *element in elements) {
        NSMutableString *str =[NSMutableString stringWithFormat:@"http://job.ncepu.edu.cn/xwgg/tzgg/"];
        NSDictionary *elementContent =[element attributes];
        //        NSMutableArray *arrayURL = [[NSMutableArray alloc] init ];
        
        NSString *strs= [elementContent objectForKey:@"href"];
        if (strs.length<15) {
            [str appendString:strs];
            [_ncepuNewsHtmlArray addObject:str];
        }
    }
//        NSLog(@"%@",_ncepuNewsHtmlArray);
    return _ncepuNewsHtmlArray;
}

-(NSMutableArray *)NcepuNewsTitle:(NSString *)htmlString
{
    
    //self.titleArray=[[NSMutableArray alloc]initWithCoder:0];
    
    NSString *title=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    
    //NSLog(@"title%@",title);
    
    NSRange range=[title rangeOfString:@"<title>"];
    
    NSMutableString *needTidyString=[NSMutableString stringWithString:[title substringFromIndex:range.location+range.length]];
    
    //NSLog(@"%@",needTidyString);
    
    NSRange rang2=[needTidyString rangeOfString:@"</title>"];
    
    NSMutableString *html2=[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];
    if (!_ncepuNewsTitleArray) {
        _ncepuNewsTitleArray = [[NSMutableArray alloc]init];
    }
    [_ncepuNewsTitleArray addObject:html2];
    return _ncepuNewsTitleArray;
    
    
}
-(NSMutableArray *)NcepuNewsData:(NSString *)htmlString
{

    
    NSString *title=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    
//    NSLog(@"title%@",title);
    
    NSRange range=[title rangeOfString:@"发布时间："];
    
    NSMutableString *needTidyString=[NSMutableString stringWithString:[title substringFromIndex:range.location+range.length]];
    
//    NSLog(@"%@",needTidyString);
    if (!_ncepuNewsDataArray) {
        _ncepuNewsDataArray = [[NSMutableArray alloc]init];
    }
    
    NSRange rang2=[needTidyString rangeOfString:@"</span></div>"];
    
    NSMutableString *html2=[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];
    [_ncepuNewsDataArray addObject:html2];
    
    //   NSLog(@"%@",_titleArray);
    return _ncepuNewsDataArray;
    
}
-(NSMutableArray *)NcepuNewsText:(NSString *)htmlString;{
    
    NSString *title=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    NSRange range = [title rangeOfString:@"<div class=\"maintext\">"];
    NSMutableString *needTidyString= [NSMutableString stringWithString:[title substringFromIndex:range.location+range.length]];
    //    NSLog(@"%@",needTidyString);
    //    NSLog(@"%@",range.location);
    NSRange rang2 =[needTidyString rangeOfString:@"<div class=\"bottom\"></div>"];
    NSMutableString *html2 =[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];
    //        NSLog(@"%@XXX%@",htmlString,html2);
    NSData *dataTitle=[html2 dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//div"];
    
    if (!_ncepuNewsTextArray) {
        _ncepuNewsTextArray = [[NSMutableArray alloc]init];
    }
    NSMutableString *str = [[NSMutableString alloc]init];
    for (TFHppleElement *element in elements) {
        
        if ([element content]!=nil) {

            [str appendString :[element content]];
        }
    }
    [_ncepuNewsTextArray addObject:str];
    //            [_ncepuNewsTextArray addObject:html2];
    return _ncepuNewsTextArray;
}
-(NSMutableArray *)NcepuNewsImage:(NSString *)htmlString
{
    NSString *imageStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    
    NSRange rang1=[imageStr rangeOfString:@"<div class=\"maintext\">"];
    NSMutableString *imageStr2=[[NSMutableString alloc]initWithString:[imageStr substringFromIndex:rang1.location+rang1.length]];
    
    NSRange rang2=[imageStr2 rangeOfString:@"<div class=\"bottom\"></div>"];
    NSMutableString *imageStr3=[[NSMutableString alloc]initWithString:[imageStr2 substringToIndex:rang2.location]];
    
    //    NSLog(@"%@",imageStr3);
    
    NSData *dataTitle=[imageStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//img"];
    if (!_ncepuNewsImageArray) {
        _ncepuNewsImageArray = [[NSMutableArray alloc]init];
    }
        NSMutableString *stru=[NSMutableString stringWithFormat:@"http://www.ncepu.edu.cn/"];
    for (TFHppleElement *element in elements) {
        NSDictionary *elementContent =[element attributes];
        NSString *strurl = [elementContent objectForKey:@"src"];
        NSString *strurl2 =[strurl substringFromIndex:3];
        [stru appendString:strurl2];        

    }
            [_ncepuNewsImageArray addObject:stru];
    return _ncepuNewsImageArray;
    
}
@end
