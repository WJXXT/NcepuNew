//
//  DataModel.m
//  NcepuNews
//
//  Created by 王新国 on 15/5/11.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "DataModel.h"
#import "TFHpple.h"
@implementation DataModel

-(NSMutableArray *)NcepuNewsHtml:(NSString *)htmlString
{
    NSString *title=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    NSRange range = [title rangeOfString:@"<LI>"];
    NSMutableString *needTidyString= [NSMutableString stringWithString:[title substringFromIndex:range.location]];
    //    NSLog(@"%@",needTidyString);
    //    NSLog(@"%@",range.location);
    NSRange rang2 =[needTidyString rangeOfString:@"<br /> "];
    NSMutableString *html2 =[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];
    //    NSLog(@"%@",html2);
    NSData *dataTitle=[html2 dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//a"];
    
    
//        _ncepuNewsHtmlArray = [[NSMutableArray alloc] init ];
    _ncepuNewsHtmlArray = [[NSMutableArray alloc]init];
    for (TFHppleElement *element in elements) {
        NSMutableString *str =[NSMutableString stringWithFormat:@"http://www.ncepu.edu.cn/tztg/"];
        NSDictionary *elementContent =[element attributes];
        //        NSMutableArray *arrayURL = [[NSMutableArray alloc] init ];
        
        NSString *strs= [elementContent objectForKey:@"href"];
        [str appendString:strs];
        [_ncepuNewsHtmlArray addObject:str];
    }
//    NSLog(@"%@",_ncepuNewsHtmlArray);
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
    
    NSRange rang2=[needTidyString rangeOfString:@"</TITLE>"];
    
    NSMutableString *html2=[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];
    if (!_ncepuNewsTitleArray) {
        _ncepuNewsTitleArray = [[NSMutableArray alloc]init];
    }
    
//            [_titleArray addObject:html2];
        [_ncepuNewsTitleArray addObject:html2];
//               NSLog(@"%@",_ncepuNewsTitleArray);
    return _ncepuNewsDataArray;
    
    
}
-(NSMutableArray *)NcepuNewsData:(NSString *)htmlString
{
    
    NSString *title=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    
    //NSLog(@"title%@",title);
    
    NSRange range=[title rangeOfString:@"发布时间："];
    
    NSMutableString *needTidyString=[NSMutableString stringWithString:[title substringFromIndex:range.location+range.length]];
    
    //NSLog(@"%@",needTidyString);
    
    NSRange rang2=[needTidyString rangeOfString:@" &nbsp;&nbsp"];
    
    NSMutableString *html2=[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];
    if (!_ncepuNewsDataArray) {
    _ncepuNewsDataArray = [[NSMutableArray alloc]init];
    }
    //        _titleArray=html2;
//  NSString  *ncepuNewsData = html2;
        [_ncepuNewsDataArray addObject:html2];
//       NSLog(@"44%@",_ncepuNewsDataArray);
    return _ncepuNewsDataArray;
    
}
-(NSMutableArray *)NcepuNewsText:(NSString *)htmlString;{
    
    NSString *title=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    NSRange range = [title rangeOfString:@"<div class=contentxxx>"];
    NSMutableString *needTidyString= [NSMutableString stringWithString:[title substringFromIndex:range.location+range.length]];
    //    NSLog(@"%@",needTidyString);
    //    NSLog(@"%@",range.location);
    NSRange rang2 =[needTidyString rangeOfString:@"<DIV class=clear></DIV>"];
    NSMutableString *html2 =[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];
    //        NSLog(@"%@XXX%@",htmlString,html2);
    NSData *dataTitle=[html2 dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//p"];
    
    
    //   NSLog(@"%@",elements);
    if (!_ncepuNewsTextArray) {
        _ncepuNewsTextArray = [[NSMutableArray alloc]init];
    }
    NSMutableString *str = [[NSMutableString alloc]init];
    for (TFHppleElement *element in elements) {
        
        if ([element content]!=nil) {
            //            NSLog(@"XXXX%@",str);
            //            NSLog(@"%@",[element content]);
            [str appendString :[element content]];
//            NSMutableArray
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
