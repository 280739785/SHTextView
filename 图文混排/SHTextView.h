//
//  SHTextView.h
//  图文混排
//
//  Created by shuangHe黄 on 2017/1/29.
//  Copyright © 2017年 shuangHe黄. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHTextView : UIWebView


/**
  文本
 */
@property (nonatomic, copy) NSString *text;


/**
 字体大小
 */
@property (nonatomic, assign) CGFloat fontSize;



/**
 设置背景颜色 rgba
 */
-(void)setBackColorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(CGFloat)a;

/**
 设置网页名称  **** 此方法会设置所有的网页 使用了其他修改或者指定url的方法不能和此方法同用 ****

 @param urlName 网页名称
 @param r 网页标签颜色
 @param isLine 是否有下划线
 */
-(void)setUrlName:(NSString *)urlName andColorR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(CGFloat)a underline:(BOOL)isLine;




/**
 在指定的字符之前添加图片 并为图片添加url 可点击 不传入url则不能点击

 @param imagePath 图片地址
 @param urlStr url地址
 @param subStr 子字符串
 */
-(void)insertImage:(NSString*)imagePath withUrl:(NSString*)urlStr withSubStrAgo:(NSString*)subStr;


/**
 替换指定的字符串转换为图片

 @param imagePath 图片地址
 @param urlStr url地址
 @param subStr 子字符串
 */
-(void)replaceImage:(NSString*)imagePath withUrl:(NSString*)urlStr withSubStr:(NSString*)subStr;

/**
 将指定字符串设置成超链接

 @param atStr 超链接name
 @param r rgba颜色
 @param urlStr 点击打开的连接地址
 @param subStr 要转换连接的子字符串
 */
-(void)replaceAtStr:(NSString*)atStr AtStrColorR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(CGFloat)a Url:(NSString*)urlStr SubStr:(NSString*)subStr;

@end
