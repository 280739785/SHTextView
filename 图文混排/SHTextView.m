//
//  SHTextView.m
//  图文混排
//
//  Created by shuangHe黄 on 2017/1/29.
//  Copyright © 2017年 shuangHe黄. All rights reserved.
//

#import "SHTextView.h"

@interface SHTextView()<UIWebViewDelegate>


@end

@implementation SHTextView




-(instancetype)init
{
    if (self = [super init])
    {
        self.scrollView.scrollEnabled = NO;
        self.delegate = self;
        
        NSString *textStr = [NSString stringWithFormat:@"document.write('<div id=\"divId\"></div>');"];
        [self stringByEvaluatingJavaScriptFromString:textStr];

    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.scrollView.scrollEnabled = NO;
    self.delegate = self;
    NSString *textStr = [NSString stringWithFormat:@"document.write('<div id=\"divId\"></div>');"];
    [self stringByEvaluatingJavaScriptFromString:textStr];
    
    
}



-(void)setText:(NSString *)text
{

    _text = text;
    

    NSString *js1 = @"var div = document.getElementById('divId');";
    NSString *js2 = [NSString stringWithFormat:@"div.innerHTML = \"%@\";",text];
    [self stringByEvaluatingJavaScriptFromString:js1];
    [self stringByEvaluatingJavaScriptFromString:js2];

    
}


-(void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    
    NSString *textStr = [NSString stringWithFormat:@" var div = document.getElementById('divId');div.style.fontSize = \"%fpx\";",self.fontSize];
    [self stringByEvaluatingJavaScriptFromString:textStr];
}



-(void)setBackColorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(CGFloat)a
{

    NSString *textStr = [NSString stringWithFormat:@"var div = document.getElementById('divId');div.style.backgroundColor ='rgba(%zd,%zd,%zd,%f)';",r,g,b,a];
    [self stringByEvaluatingJavaScriptFromString:textStr];


}


-(void)setUrlName:(NSString *)urlName andColorR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(CGFloat)a underline:(BOOL)isLine
{
    NSString *textStr = self.text;
    NSArray *resultArr = [self searchUrlWithString:textStr];
    
    
    for (NSString *urlName_str in resultArr)
    {
        if (isLine)
        {
            NSString *uName = [NSString stringWithFormat:@"<a href='%@'style='color:rgba(%zd,%zd,%zd,%f)'>%@</a>",urlName_str,r,g,b,a,urlName];
            textStr = [textStr stringByReplacingOccurrencesOfString:urlName_str withString:uName];
        }else
        {
            NSString *uName = [NSString stringWithFormat:@"<a href='%@'style='color:rgba(%zd,%zd,%zd,%f);text-decoration:none'>%@</a>",urlName_str,r,g,b,a,urlName];
            textStr = [textStr stringByReplacingOccurrencesOfString:urlName_str withString:uName];
        }
        
    }
    
    [self setText:textStr];
}





-(void)insertImage:(NSString *)imagePath withUrl:(NSString *)urlStr withSubStrAgo:(NSString *)subStr
{
    NSRange range = [self.text rangeOfString:subStr];
    NSMutableString *textStrM = [NSMutableString stringWithString:self.text];
    
    if (range.length>0)
    {
        CGFloat imageH = [self.text sizeWithFont:[UIFont systemFontOfSize:self.fontSize]].height- self.fontSize/4;
        NSString *imageStr = nil;
        if (urlStr.length>0)
        {
            imageStr = [NSString stringWithFormat:@"<a href='%@'><img src='%@'width='%fxp' height='%fxp'></a>",urlStr,imagePath,imageH,imageH];
        }else
        {
            imageStr = [NSString stringWithFormat:@"<img src='%@'width='%fxp' height='%fxp'>",imagePath,imageH,imageH];
        }
        
        
        [textStrM insertString:imageStr atIndex:range.location];
        
        [self setText:textStrM];
        
    }
}


-(void)replaceImage:(NSString *)imagePath withUrl:(NSString *)urlStr withSubStr:(NSString *)subStr
{
    NSRange range = [self.text rangeOfString:subStr];
    NSMutableString *textStrM = [NSMutableString stringWithString:self.text];
    
    if (range.length>0)
    {
        CGFloat imageH = [self.text sizeWithFont:[UIFont systemFontOfSize:self.fontSize]].height- self.fontSize/4;
        NSString *imageStr = nil;
        if (urlStr.length>0)
        {
            imageStr = [NSString stringWithFormat:@"<a href='%@'><img src='%@'width='%fxp' height='%fxp'></a>",urlStr,imagePath,imageH,imageH];
        }else
        {
            imageStr = [NSString stringWithFormat:@"<img src='%@'width='%fxp' height='%fxp'>",imagePath,imageH,imageH];
        }
        
        
        //只替换第一个 替换所以  换成stringByReplacingOccurrencesOfString: withString:
        NSString* textStr = [textStrM stringByReplacingOccurrencesOfString:subStr withString:imageStr options:0 range:range];
        
        [self setText:textStr];
    }

}


-(void)replaceAtStr:(NSString *)atStr AtStrColorR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(CGFloat)a Url:(NSString *)urlStr SubStr:(NSString *)subStr
{
    NSRange range = [self.text rangeOfString:subStr];
    NSString *js = self.text;
    NSString *atStrJs;
    if (range.length>0)
    {
        if (urlStr.length>0)
        {
            atStrJs = [NSString stringWithFormat:@"<a href='%@'style='color:rgba(%zd,%zd,%zd,%f);text-decoration:none'>%@</a>",urlStr,r,g,b,a,atStr];
            
            js = [js stringByReplacingOccurrencesOfString:subStr withString:atStrJs options:0 range:range];
        }else
        {
            atStrJs = [NSString stringWithFormat:@"<a href='#'style='color:rgba(%zd,%zd,%zd,%f);text-decoration:none'>%@</a>",r,g,b,a,atStr];
            
            js = [js stringByReplacingOccurrencesOfString:subStr withString:atStrJs options:0 range:range];
        }
    }
    
    [self setText:js];
}

-(NSArray*)searchUrlWithString:(NSString*)str
{
    
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    NSError *error;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:regulaStr options:0 error:&error];
    
    if (error)
    {
        return nil;
    }
    
    //匹配字符串
    NSTextCheckingResult *result;
    NSMutableArray *url_arr = [NSMutableArray array];
    while((result = [reg firstMatchInString:str options:0 range:NSMakeRange(0, str.length)]))
    {
        NSString *urlStr = [str substringWithRange:result.range];
        [url_arr addObject:urlStr];
        str = [str substringFromIndex:result.range.location + result.range.length];

    }
    
    return url_arr;

}


#pragma mark- UIWebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 获得app对象
    UIApplication *app = [UIApplication sharedApplication];
    

    [app openURL:request.URL options:@{} completionHandler:^(BOOL success) {
       
   }];
   
    
    return NO;
}
@end
