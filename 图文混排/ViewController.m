//
//  ViewController.m
//  图文混排
//
//  Created by shuangHe黄 on 2017/1/29.
//  Copyright © 2017年 shuangHe黄. All rights reserved.
//

#import "ViewController.h"
#import "SHTextView.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet SHTextView *MyWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    
    self.MyWebView.text = @"http://www.baidu.com圆圈勾勒成指纹 印在我的嘴唇 回忆苦涩的吻痕 是树根 春去秋来的茂盛 却遮住了黄昏 寒夜剩我一个人 等清晨 世间最毒的仇恨 是有缘却无分 可惜你从未心疼 我的笨 荒草丛生的青春 倒也过的安稳 代替你陪着我的 是年轮 数着一圈圈年轮 我认真 将心事都封存 密密麻麻是我的自尊 修改一次次离分 我承认 曾幻想过永恒 可惜从没人陪我演这剧本  \r\n 圆圈勾勒成指纹 印在我的嘴唇 回忆苦涩的吻痕 是树根 春去秋来的茂盛13634679713 却遮住了黄昏 寒夜剩我一个人 等清晨 世间最毒的仇恨 是有缘却无分 可惜你从未心疼 我的笨 荒草丛生的青春 倒也过的安稳 代替你陪着我的 是年轮 数着一圈圈年轮 我认真 将心事都封存 密密麻麻是我的自尊 修改一次次离分 我承认 曾幻想过永恒 可惜从没人陪我演这剧本 \n 一圈圈年轮 我认真 将心事都封存 密密麻麻是我的自尊 修改一次次离分 我承认 曾幻想过永恒 可惜从没人陪我演这剧本   可惜从没人陪我演这剧本http://www.weibo.com http://www.QQ.com";
    NSLog(@"%zd",self.MyWebView.text.length);
    self.MyWebView.fontSize = 15;
    [self.MyWebView setBackColorWithR:255 G:255 B:0 A:0.2];
    
//    [self.MyWebView setUrlName:@"#网页链接" andColorR:0 G:255 B:0 A:1 underline:YES];
    
    //插入图片
    [self.MyWebView insertImage:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1485742601&di=23c9814bfc4d3af2337831f1539ef990&src=http://img.zcool.cn/community/01b76b567269176ac725ad90332d60.jpg" withUrl:nil withSubStrAgo:@"等清晨"];

    [self.MyWebView insertImage:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1485742601&di=23c9814bfc4d3af2337831f1539ef990&src=http://img.zcool.cn/community/01b76b567269176ac725ad90332d60.jpg" withUrl:@"http://www.baidu.com" withSubStrAgo:@"荒草丛生的青春"];

    //将字符串替换成图片
    [self.MyWebView replaceImage:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1485742601&di=23c9814bfc4d3af2337831f1539ef990&src=http://img.zcool.cn/community/01b76b567269176ac725ad90332d60.jpg" withUrl:nil withSubStr:@"圆圈勾勒成指纹"];

    [self.MyWebView replaceImage:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1485742601&di=23c9814bfc4d3af2337831f1539ef990&src=http://img.zcool.cn/community/01b76b567269176ac725ad90332d60.jpg" withUrl:@"http://www.baidu.com" withSubStr:@"曾幻想过永恒"];

    //将字符串替换成超链接
    [self.MyWebView replaceAtStr:@"@张三" AtStrColorR:255 G:9 B:0 A:1 Url:@"http://www.baidu.com" SubStr:@"印在我的嘴唇"];
    
    [self.MyWebView replaceAtStr:@"@李四" AtStrColorR:255 G:9 B:0 A:1 Url:@"http://www.baidu.com" SubStr:@"印在我的嘴唇"];
    
    //将指定网址替换成字符串
    [self.MyWebView replaceAtStr:@"百度" AtStrColorR:255 G:0 B:0 A:1 Url:@"http:baidu.com" SubStr:@"http://www.baidu.com"];
    
    [self.MyWebView replaceAtStr:@"微博" AtStrColorR:255 G:0 B:0 A:1 Url:@"http://www.weibo.com" SubStr:@"http://www.weibo.com"];
    
    [self.MyWebView setUrlName:@"#网页链接" andColorR:0 G:255 B:0 A:1 underline:YES];

}


@end
