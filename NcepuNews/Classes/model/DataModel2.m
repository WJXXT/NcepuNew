//
//  DataModel2.m
//  NcepuNews
//
//  Created by 王新国 on 15/5/13.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "DataModel2.h"
#import "TFHpple.h"
@implementation DataModel2
-(NSMutableArray *)NcepuNewsHtml:(NSString *)htmlString
{
    NSString *title=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    NSRange range = [title rangeOfString:@"<DIV id=\"zw_content\">"];
    NSMutableString *needTidyString= [NSMutableString stringWithString:[title substringFromIndex:range.location]];
    //    NSLog(@"%@",needTidyString);
    //    NSLog(@"%@",range.location);
    NSRange rang2 =[needTidyString rangeOfString:@"</TBODY></TABLE><BR>"];
    NSMutableString *html2 =[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];
    //    NSLog(@"%@",html2);
    NSData *dataTitle=[html2 dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//a"];
    
    
    //    NSMutableArray *arrayURL2 = [[NSMutableArray alloc] init ];
    _ncepuNewsHtmlArray = [[NSMutableArray alloc]init];
    for (TFHppleElement *element in elements) {
        NSMutableString *str =[NSMutableString stringWithFormat:@"http://cce.ncepu.edu.cn/xwzx/tztg/"];
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
    
    NSRange range=[title rangeOfString:@"<TITLE>"];
    
    NSMutableString *needTidyString=[NSMutableString stringWithString:[title substringFromIndex:range.location+range.length]];
    
    //NSLog(@"%@",needTidyString);
    
    NSRange rang2=[needTidyString rangeOfString:@" _ 通知通告"];
    
    NSMutableString *html2=[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];

    if (!_ncepuNewsTitleArray) {
        //        int i = 0;
        _ncepuNewsTitleArray = [[NSMutableArray alloc]init];
    }
    [_ncepuNewsTitleArray addObject:html2];
    
    //        [_titleArray addObject:html2];
    //           NSLog(@"%@",_ncepuNewsTitleArray);
    return _ncepuNewsTitleArray;
    
    
}
-(NSMutableArray *)NcepuNewsData:(NSString *)htmlString
{
    //self.titleArray=[[NSMutableArray alloc]initWithCoder:0];
    
    NSString *title=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    
    //NSLog(@"title%@",title);
    
    NSRange range=[title rangeOfString:@">[  日期："];
    
    NSMutableString *needTidyString=[NSMutableString stringWithString:[title substringFromIndex:range.location+range.length]];
    
    //NSLog(@"%@",needTidyString);
    if (!_ncepuNewsDataArray) {
        //        int i = 0;
        _ncepuNewsDataArray = [[NSMutableArray alloc]init];
    }
    
    NSRange rang2=[needTidyString rangeOfString:@"   ] </DIV>"];
    
    NSMutableString *html2=[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];

    [_ncepuNewsDataArray addObject:html2];
    //   NSLog(@"%@",_titleArray);
    return _ncepuNewsDataArray;
    
}
-(NSMutableArray *)NcepuNewsText:(NSString *)htmlString;{
    
    NSString *title=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    NSRange range = [title rangeOfString:@"<DIV id=\"zw_content\">"];
    NSMutableString *needTidyString= [NSMutableString stringWithString:[title substringFromIndex:range.location+range.length]];
    //    NSLog(@"%@",needTidyString);
    //    NSLog(@"%@",range.location);
    NSRange rang2 =[needTidyString rangeOfString:@"<DIV class=\"clear_float\"></DIV>"];
    NSMutableString *html2 =[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];
    //        NSLog(@"%@XXX%@",htmlString,html2);
    NSData *dataTitle=[html2 dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//div"];
    
    
    //   NSLog(@"%@",elements);
    if (!_ncepuNewsTextArray) {
        //        int i = 0;
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
    
    NSRange rang1=[imageStr rangeOfString:@"<div class=contentxxx>"];
    NSMutableString *imageStr2=[[NSMutableString alloc]initWithString:[imageStr substringFromIndex:rang1.location+rang1.length]];
    
    NSRange rang2=[imageStr2 rangeOfString:@"<DIV class=clear>"];
    NSMutableString *imageStr3=[[NSMutableString alloc]initWithString:[imageStr2 substringToIndex:rang2.location]];
    
        NSLog(@"%@",imageStr3);
    
    NSData *dataTitle=[imageStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//img"];
    
    if (!_ncepuNewsImageArray) {
        //        int i = 0;
        _ncepuNewsImageArray = [[NSMutableArray alloc]init];
    }
            NSMutableString *stru=[NSMutableString stringWithFormat:@"http://www.ncepu.edu.cn/"];
    for (TFHppleElement *element in elements) {

        
        NSDictionary *elementContent =[element attributes];
        
        //        NSLog(@"%@",[elementContent objectForKey:@"src"]);
        NSString *strurl = [elementContent objectForKey:@"src"];

        NSString *strurl2 =[strurl substringFromIndex:3];
        [stru appendString:strurl2];
    }
            [_ncepuNewsImageArray addObject:stru];
    return _ncepuNewsImageArray;
    
}

@end
