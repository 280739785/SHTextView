//
//  TableViewCell.m
//  图文混排
//
//  Created by shuangHe黄 on 2017/2/10.
//  Copyright © 2017年 shuangHe黄. All rights reserved.
//

#import "TableViewCell.h"
#import "SHTextView.h"

@interface TableViewCell ()

@property (nonatomic, weak) SHTextView *textView;

@end

@implementation TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        SHTextView *textView = [[SHTextView alloc]init];
        self.textView = textView;
        
        [self.contentView addSubview:self.textView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textView.frame = CGRectMake(0, 0, self.bounds.size.width, 362);
    
}

-(void)setText:(NSString *)text
{
    _text = text;
    
    self.textView.text = text;
    
    
    self.textView.fontSize = 15;
    [self.textView setBackColorWithR:255 G:255 B:0 A:0.2];
    
    [self.textView setUrlName:@"#网页链接" andColorR:0 G:255 B:0 A:1 underline:YES];
    
    //插入图片
    [self.textView insertImage:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1485742601&di=23c9814bfc4d3af2337831f1539ef990&src=http://img.zcool.cn/community/01b76b567269176ac725ad90332d60.jpg" withUrl:nil withSubStrAgo:@"等清晨"];
    
    [self.textView insertImage:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1485742601&di=23c9814bfc4d3af2337831f1539ef990&src=http://img.zcool.cn/community/01b76b567269176ac725ad90332d60.jpg" withUrl:@"http://www.baidu.com" withSubStrAgo:@"荒草丛生的青春"];
    
    //将字符串替换成图片
    [self.textView replaceImage:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1485742601&di=23c9814bfc4d3af2337831f1539ef990&src=http://img.zcool.cn/community/01b76b567269176ac725ad90332d60.jpg" withUrl:nil withSubStr:@"圆圈勾勒成指纹"];
    
    [self.textView replaceImage:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1485742601&di=23c9814bfc4d3af2337831f1539ef990&src=http://img.zcool.cn/community/01b76b567269176ac725ad90332d60.jpg" withUrl:@"http://www.baidu.com" withSubStr:@"曾幻想过永恒"];
    
    //将字符串替换成超链接
    [self.textView replaceAtStr:@"@张三" AtStrColorR:255 G:9 B:0 A:1 Url:@"http://www.baidu.com" SubStr:@"印在我的嘴唇"];
    
    [self.textView replaceAtStr:@"@李四" AtStrColorR:255 G:9 B:0 A:1 Url:@"http://www.baidu.com" SubStr:@"印在我的嘴唇"];
    
    //将指定网址替换成字符串
    [self.textView replaceAtStr:@"百度" AtStrColorR:255 G:0 B:0 A:1 Url:@"http:baidu.com" SubStr:@"http://www.baidu.com"];
    
    [self.textView replaceAtStr:@"微博" AtStrColorR:255 G:0 B:0 A:1 Url:@"http://www.weibo.com" SubStr:@"http://www.weibo.com"];
    
    
    [self.textView replaceAtStr:@"邮箱" AtStrColorR:255 G:10 B:0 A:1 Url:@"mailto://78293467@qq.com" SubStr:@"78293467@qq.com"];
    
    [self.textView setUrlName:@"#网页链接" andColorR:0 G:255 B:0 A:1 underline:YES];
    

}
@end
