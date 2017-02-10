//
//  TableViewController.m
//  图文混排
//
//  Created by shuangHe黄 on 2017/2/10.
//  Copyright © 2017年 shuangHe黄. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.text =  @"http://www.baidu.com圆圈勾勒成指纹 印在我的嘴唇 回忆苦涩的吻痕 是树根 春去秋来的茂盛 却遮住了黄昏 寒夜剩我一个人 等清晨 世间最毒的仇恨 是有缘却无分 可惜你从未心疼 我的笨 荒草丛生的青春 倒也过的安稳 代替你陪着我的 是年轮 数着一圈圈年轮 我认真 将心事都封存 密密麻麻是我的自尊 修改一次次离分 我承认 曾幻想过永恒 可惜从没人陪我演这剧本  \r\n 圆圈勾勒成指纹 印在我的嘴唇 回忆苦涩的吻痕 是树根 春去秋来的茂盛13634679713 却遮住了黄昏 寒夜剩我一个人 等清晨 世间最毒的仇恨 是有缘却无分 可惜你从未心疼 我的笨 荒草丛生的青春 倒也过的安稳 代替你陪着我的 是年轮 数着一圈圈年轮 我认真 将心事都封存 密密麻麻是我的自尊 修改一次次离分 我承认 曾幻想过永恒 可惜从没人陪我演这剧本 \n 一圈圈年轮 我认真 将心事都封存 密密麻麻是我的自尊 修改一次次离分 我承认 曾幻想过永恒 可惜从没人陪我演这剧本 78293467@qq.com  可惜从没人陪我演这剧本http://www.weibo.com http://www.QQ.com";
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500;
}
@end
