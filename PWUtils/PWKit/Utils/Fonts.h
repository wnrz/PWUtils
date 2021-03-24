//
//  Fonts.h
//  HQProject
//
//  Created by UP-LiuL on 15/8/6.
//  Copyright (c) 2015年 UP-LiuL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Fonts : NSObject

+ (instancetype)shareFonts;

// 设置颜色的风格
- (void)setFontsStyleStr:(NSInteger)style;

#pragma mark - Fonts
- (UIFont *)font10;
- (UIFont *)font11;
- (UIFont *)font12;
- (UIFont *)font13;
- (UIFont *)font14;
- (UIFont *)font15;
- (UIFont *)font16;
- (UIFont *)font17;
- (UIFont *)font18;
- (UIFont *)font19;
- (UIFont *)font20;
- (UIFont *)font50;
- (UIFont *)boldFont12;
- (UIFont *)boldFont13;
- (UIFont *)boldFont14;
- (UIFont *)boldFont15;
- (UIFont *)boldFont16;
- (UIFont *)boldFont17;
- (UIFont *)boldFont18;
- (UIFont *)boldFont19;
- (UIFont *)boldFont20;

@end
