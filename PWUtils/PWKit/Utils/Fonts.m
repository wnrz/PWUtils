//
//  Fonts.m
//  HQProject
//
//  Created by UP-LiuL on 15/8/6.
//  Copyright (c) 2015年 UP-LiuL. All rights reserved.
//

#import "Fonts.h"
#import "BaseTool.h"

#define kFontsStyle     @"FontsStyle"

@interface Fonts ()

// 颜色风格
@property (nonatomic, assign) NSInteger fontsStyle;

@end

@implementation Fonts

#pragma mark - Init

static Fonts *fonts = nil;
- (void)dealloc {
    fonts = nil;
}

+ (instancetype)shareFonts {
    @synchronized(self) {
        if ( nil == fonts ) {
            fonts = [[self alloc] init];
        }
        return fonts;
    }
}

#pragma mark - Font Style

- (NSInteger)fontStyle {
    return [[self fontsStyleStr] integerValue];
}

- (NSString *)fontsStyleStr {
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:kFontsStyle];
    if ( !IsValidateString(str) ) {
        str = @"1";
    }
    return str;
}

/**
 * setFontsStyleStr:
 *
 * 设置字体的风格
 */
- (void)setFontsStyleStr:(NSInteger)style {
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)style] forKey:kFontsStyle];
}

#pragma mark - Fonts

- (UIFont *)font10 {
    return ([UIFont systemFontOfSize:10.f]);
}

- (UIFont *)font11 {
    return ([UIFont systemFontOfSize:11.f]);
}

- (UIFont *)font12 {
    return ([UIFont systemFontOfSize:12.f]);
}

- (UIFont *)font13 {
    return ([UIFont systemFontOfSize:13.f]);
}

- (UIFont *)font14 {
    return ([UIFont systemFontOfSize:14.f]);
}

- (UIFont *)font15 {
    return ([UIFont systemFontOfSize:15.f]);
}

- (UIFont *)font16 {
    return ([UIFont systemFontOfSize:16.f]);
}

- (UIFont *)font17 {
    return ([UIFont systemFontOfSize:17.f]);
}

- (UIFont *)font18 {
    return ([UIFont systemFontOfSize:18.f]);
}

- (UIFont *)font19 {
    return ([UIFont systemFontOfSize:19.f]);
}

- (UIFont *)font20 {
    return ([UIFont systemFontOfSize:20.f]);
}

- (UIFont *)font50 {
    return ([UIFont systemFontOfSize:50.f]);
}

- (UIFont *)boldFont12 {
    return ([UIFont boldSystemFontOfSize:12.f]);
}

- (UIFont *)boldFont13 {
    return ([UIFont boldSystemFontOfSize:13.f]);
}

- (UIFont *)boldFont14 {
    return ([UIFont boldSystemFontOfSize:14.f]);
}

- (UIFont *)boldFont15 {
    return ([UIFont boldSystemFontOfSize:15.f]);
}

- (UIFont *)boldFont16 {
    return ([UIFont boldSystemFontOfSize:16.f]);
}

- (UIFont *)boldFont17 {
    return ([UIFont boldSystemFontOfSize:17.f]);
}

- (UIFont *)boldFont18 {
    return ([UIFont boldSystemFontOfSize:18.f]);
}

- (UIFont *)boldFont19 {
    return ([UIFont boldSystemFontOfSize:19.f]);
}

- (UIFont *)boldFont20 {
    return ([UIFont boldSystemFontOfSize:20.f]);
}

@end
