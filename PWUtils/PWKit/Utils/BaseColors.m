//
//  BaseColors.m
//  Tools
//
//  Created by mac on 2016/12/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseColors.h"

@implementation BaseColors

+ (void)setColor:(UILabel *)l v1:(float)v1 v2:(float)v2{
    if (v1 > v2) {
        l.textColor = kHQUPColor;
    }
    else if (v1 < v2)
    {
        l.textColor = kHQDOWNColor;
    }else
    {
        l.textColor = kHQEQColor;
    }
}

+ (UIColor *)colorWithP1:(double)p1 p2:(double)p2{
    UIColor *color = kHQEQColor;
    if (p1 > p2) {
        color = kHQUPColor;
    }else if (p1 < p2){
        color = kHQDOWNColor;
    }
    return color;
}

// 获取RGB和Alpha
+ (NSArray *)getRGBWithColor:(UIColor *)color {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}

// 改变UIColor的Alpha
+ (UIColor *)getNewColorWith:(UIColor *)color alpha:(float)alpha{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha2 = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha2];
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return newColor;
}

+ (UIColor *)getUpColor{
    return UIColorFromRGB(0xfa4e63);
}

+ (UIColor *)getDownColor{
    return UIColorFromRGB(0x3bbd8a);
}
@end
