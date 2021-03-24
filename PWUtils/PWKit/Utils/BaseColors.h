
//
//  BaseColors.h
//  Tools
//
//  Created by mac on 2016/12/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BaseColors : NSObject


//#define kHQUpDownColorEnum @"kHQUpDownColorEnum"
//typedef NS_ENUM(NSInteger, HQUpDownColorEnum) {
//    HQUpRedDownGreen,
//    HQUpGreenDownRed
//};

//标题颜色
#define kStatusBarColor UIColorFromRGB(0xffffff)
#define kHeaderColor UIColorFromRGB(0xffffff)
#define kHeaderTitleColor UIColorFromRGB(0x4A505A)
#define kHeaderLineColor UIColorFromRGB(0xe0e0e0)

//涨跌颜色
#define kHQUPColor [BaseColors getUpColor]
#define kHQDOWNColor [BaseColors getDownColor]
#define kHQEQColor UIColorFromRGB(0x838383)

//商品名颜色
#define kHQNameColor UIColorFromRGB(0x4A505A)
//商品代码颜色
#define kHQCodeColor UIColorFromRGB(0x999FAA)

//导航栏涨跌颜色
#define UIColorNavUP kHQUPColor//[UIColor colorWithRed:255.0/255.0 green:44.0/255.0 blue:66.0/255.0 alpha:1.0]
#define UIColorNavDown kHQDOWNColor//[UIColor colorWithRed:0.0/255.0 green:162.0/255.0 blue:91.0/255.0 alpha:1.0]
#define UIColorNavAV kHQEQColor//[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0]

//涨跌背景颜色
#define UIColorUPBJ kHQUPColor//[UIColor colorWithRed:255.0/255.0 green:44.0/255.0 blue:66.0/255.0 alpha:1.0]
#define UIColorDownBJ kHQDOWNColor//[UIColor colorWithRed:0.0/255.0 green:162.0/255.0 blue:91.0/255.0 alpha:1.0]
#define UIColorAVBJ kHQEQColor//[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0]


#define UIColorOrange [UIColor colorWithRed:244.0/255.0 green:99.0/255.0 blue:34.0/255.0 alpha:1.0]
#define UIColorBlack [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]

//颜色获取宏
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBAndAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define UIColorFromRGBWithDecimal(r, g, b) ([UIColor colorWithRed:(float)(r)/255.0 green:(float)(g)/255.0 blue:(float)(b)/255.0 alpha:1.0])
#define UIColorFromRGBWithDecimalAndAlpha(r, g, b , a) ([UIColor colorWithRed:(float)(r)/255.0 green:(float)(g)/255.0 blue:(float)(b)/255.0 alpha:a])

#pragma mark - 资讯Cell的TITLE RESOURCE PUBLICDATA 文字的颜色配置
#define     TITLEColor       [UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1]
#define     SOURCEColor      [UIColor colorWithRed:0x66/255.0 green:0x66/255.0 blue:0x66/255.0 alpha:1]
#define     PUBLISHDATAColor [UIColor colorWithRed:0x99/255.0 green:0x99/255.0 blue:0x99/255.0 alpha:1]
#define     LineColor        [UIColor colorWithRed:0x00/255.0 green:0x00/255.0 blue:0x00/255.0 alpha:0.1]

// 获取本地图片
#define LocalImage(imageName, imageType) ([[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:imageType]])
#define Image(imageName) ([UIImage imageNamed:imageName])

//
// 字体色，用于具体的字体
//
// 红色
#define kRedColor               (UIColorFromRGB(0xed1c1c))
// 橙色
#define kOrangeColor            (UIColorFromRGB(0xff3300))
// 绿色
#define kGreenColor             (UIColorFromRGB(0x0a9650))
// 灰色
#define kGrayColor              (UIColorFromRGB(0x666666))
// 分割线颜色
#define kCutoffLineColor        (UIColorFromRGB(0xc8c7cc))
#define kOtherCutoffLineColor   (UIColorFromRGB(0xdfdfe2))
// 分割线高度
#define kCutoffLineHeight       0.5f
// 分割线宽度
#define kCutoffLineWidth        0.5f
// 背景色
#define kBackgroundColor        (UIColorFromRGBWithDecimal(240, 240, 240))

//导航栏颜色
//#define kNavigationBarColor     (UIColorFromRGB(0x2A458F))

//价格对比设置颜色
+ (void)setColor:(UILabel *)l v1:(float)v1 v2:(float)v2;
//价格对比获取颜色
+ (UIColor *)colorWithP1:(double)p1 p2:(double)p2;

//获取rgb值
+ (NSArray *)getRGBWithColor:(UIColor *)color;
//变换color的alpha值
+ (UIColor *)getNewColorWith:(UIColor *)color alpha:(float)alpha;

//涨跌颜色
+ (UIColor *)getUpColor;
+ (UIColor *)getDownColor;
@end
