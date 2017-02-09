//
//  SHTextView.m
//  图文混排
//
//  Created by shuangHe黄 on 2017/1/29.
//  Copyright © 2017年 shuangHe黄. All rights reserved.
//

#import "SHTextView.h"

@interface SHTextView()<UIWebViewDelegate>

@property (nonatomic, assign) NSRange urlRange;

@end

@implementation SHTextView

static NSString *aString =   @"<a  href=";
static NSString *imgString = @"<img src=";

-(instancetype)init
{
    if (self = [super init])
    {
        [self creatDiv];

    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self creatDiv];
    
}

-(void)creatDiv
{
    self.scrollView.scrollEnabled = NO;
    self.delegate = self;
    NSString *textStr = [NSString stringWithFormat:@"document.write('<div id=\"divId\"></div>');"];
    [self stringByEvaluatingJavaScriptFromString:textStr];
    
    //间距
    NSString *js = @" var body = document.getElementsByTagName('body')[0];body.style.margin = '5px';";
    [self stringByEvaluatingJavaScriptFromString:js];
    
    
    //禁止缩放
    NSString *js2 = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    [self stringByEvaluatingJavaScriptFromString:js2];
    self.fontSize = 10;
    
}


-(CGFloat)height
{
    NSString *js1 = @"var d = document.getElementById('divId');";
    NSString *js2 = @"d.offsetHeight;";
    [self stringByEvaluatingJavaScriptFromString:js1];

    //加双间距
    return [[self stringByEvaluatingJavaScriptFromString:js2] floatValue] + 10;
}


-(void)setText:(NSString *)text
{

    NSRange rRange = [text rangeOfString:@"\r\n"];
    if (rRange.length>0)
    {
        text = [text stringByReplacingOccurrencesOfString:@"\r\n" withString:@"<br/>"];
    }
    
    NSRange nRange = [text rangeOfString:@"\n"];
    if (nRange.length>0)
    {
        text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    }

    _text = text;
    

    NSString *js1 = @"var div = document.getElementById('divId');";
    NSString *js2 = [NSString stringWithFormat:@"div.innerHTML = \"%@\";",text];
    [self stringByEvaluatingJavaScriptFromString:js1];
    [self stringByEvaluatingJavaScriptFromString:js2];

    
}


-(void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    
    NSString *textStr = [NSString stringWithFormat:@"var d = document.getElementsByTagName('body')[0];d.style.fontSize = \"%fpx\";",self.fontSize];
    [self stringByEvaluatingJavaScriptFromString:textStr];
}



-(void)setBackColorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(CGFloat)a
{

    NSString *textStr = [NSString stringWithFormat:@"var d = document.getElementsByTagName('body')[0];d.style.backgroundColor ='rgba(%zd,%zd,%zd,%f)';",r,g,b,a];
    [self stringByEvaluatingJavaScriptFromString:textStr];
}


-(void)setUrlName:(NSString *)urlName andColorR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(CGFloat)a underline:(BOOL)isLine
{
    NSString *textStr = self.text;

    NSString *urlName_str = [self searchUrlWithString:textStr];
    
    while (urlName_str.length > 0)
    {
        NSString *uName = nil;
        if (isLine)
        {
            uName = [NSString stringWithFormat:@"%@'%@'style='color:rgba(%zd,%zd,%zd,%f)'>%@</a>",aString,urlName_str,r,g,b,a,urlName];
        }else
        {
            uName = [NSString stringWithFormat:@"%@'%@'style='color:rgba(%zd,%zd,%zd,%f);text-decoration:none'>%@</a>",aString,urlName_str,r,g,b,a,urlName];
        }
        
        textStr = [textStr stringByReplacingOccurrencesOfString:urlName_str withString:uName options:0 range:self.urlRange];
        urlName_str = [self searchUrlWithString:textStr];


    }
    
    [self setText:textStr];
}





-(void)insertImage:(NSString *)imagePath withUrl:(NSString *)urlStr withSubStrAgo:(NSString *)subStr
{
    NSRange range = [self.text rangeOfString:subStr];
    NSMutableString *textStrM = [NSMutableString stringWithString:self.text];
    
    if (range.length>0)
    {
        NSDictionary *atts = @{NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize]};
        CGFloat imageH = [self.text sizeWithAttributes:atts].height - self.fontSize/4;
        NSString *imageStr = nil;
        if (urlStr.length>0)
        {
            imageStr = [NSString stringWithFormat:@"%@'%@'>%@'%@'width='%fxp' height='%fxp'></a>",aString,urlStr,imgString,imagePath,imageH,imageH];
            

        }else
        {
            imageStr = [NSString stringWithFormat:@"%@'%@'width='%fxp' height='%fxp'>",imgString,imagePath,imageH,imageH];

        }
        
        
        [textStrM insertString:imageStr atIndex:range.location];
        [self setText:textStrM];
        
    }
}


-(void)replaceImage:(NSString *)imagePath withUrl:(NSString *)urlStr withSubStr:(NSString *)subStr
{
    if ([self isHtmlTagUrlWithSubstring:subStr]) return;
    
    NSRange range = [self.text rangeOfString:subStr];
    NSString *textStrM = [NSMutableString stringWithString:self.text];
    
    if (range.length>0)
    {
        NSDictionary *atts = @{NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize]};
        CGFloat imageH = [self.text sizeWithAttributes:atts].height - self.fontSize/4;
        NSString *imageStr = nil;
        NSString* textStr;
        if (urlStr.length>0)
        {
            imageStr = [NSString stringWithFormat:@"%@'%@'>%@'%@'width='%fxp' height='%fxp'></a>",aString,urlStr,imgString,imagePath,imageH,imageH];
            
            
        }else
        {
            imageStr = [NSString stringWithFormat:@"%@'%@'width='%fxp' height='%fxp'>",imgString,imagePath,imageH,imageH];

        }
        
        //只替换第一个 替换所有  换成stringByReplacingOccurrencesOfString: withString:
        textStr = [textStrM stringByReplacingOccurrencesOfString:subStr withString:imageStr options:0 range:range];
        
        
        [self setText:textStr];
    }

}


-(void)replaceAtStr:(NSString *)atStr AtStrColorR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(CGFloat)a Url:(NSString *)urlStr SubStr:(NSString *)subStr
{
    if ([self isHtmlTagUrlWithSubstring:subStr]) return;
    
    NSRange range = [self.text rangeOfString:subStr];
    NSString *js = self.text;
    NSString *atStrJs;
    if (range.length>0)
    {
        if (urlStr.length>0)
        {
            atStrJs = [NSString stringWithFormat:@"%@'%@'style='color:rgba(%zd,%zd,%zd,%f);text-decoration:none'>%@</a>",aString,urlStr,r,g,b,a,atStr];
            

        }else
        {
            atStrJs = [NSString stringWithFormat:@"%@'#'style='color:rgba(%zd,%zd,%zd,%f);text-decoration:none'>%@</a>",aString,r,g,b,a,atStr];
            
        }
    }
    
    js = [js stringByReplacingOccurrencesOfString:subStr withString:atStrJs options:0 range:range];
    
    [self setText:js];
}

-(NSString*)searchUrlWithString:(NSString*)str
{
    
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    NSError *error;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:regulaStr options:0 error:&error];
    
    if (error)
    {
        return nil;
    }
    
    NSString *textStr = str;
    NSInteger index = 0;
    
    //匹配字符串
    NSTextCheckingResult *result;
    while((result = [reg firstMatchInString:textStr options:0 range:NSMakeRange(0, textStr.length)]))
    {
        NSString *urlStr = [textStr substringWithRange:result.range];
        
        NSInteger location = result.range.location - 1- aString.length;
        if (location<0)
        {
            location = 0;
        }
        NSString *hrefStr = [textStr substringWithRange:NSMakeRange(location, aString.length )];

        if (!([hrefStr rangeOfString:aString].length>0 ||[hrefStr rangeOfString:imgString].length>0))
        {
            index = [str rangeOfString:textStr].location;
            self.urlRange = NSMakeRange(index + result.range.location,result.range.length);
            return urlStr;
        }
        textStr = [textStr substringFromIndex:(result.range.location + result.range.length)];
        

    }
    
    return nil;

}

//判断是否标签内部链接
-(BOOL)isHtmlTagUrlWithSubstring:(NSString*)subString
{
    NSRange range = [self.text rangeOfString:subString];
    
    if (range.length>0)
    {
        NSInteger location = range.location - 1- aString.length;
        if (location<0)
        {
            location = 0;
        }
        
        NSString *hrefStr = [self.text substringWithRange:NSMakeRange(location, aString.length)];
        
        if (([hrefStr rangeOfString:aString].length>0 ||[hrefStr rangeOfString:imgString].length>0))
        {

            return YES;
        }
        

    }
    return NO;
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
