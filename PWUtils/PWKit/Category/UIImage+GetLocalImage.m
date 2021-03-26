//
//  UIImage+GetLocalImage.m
//  ParentChildClass
//
//  Created by LiuLian on 14-7-21.
//  Copyright (c) 2014年 LiuLian. All rights reserved.
//

#import "UIImage+GetLocalImage.h"

@implementation UIImage (GetLocalImage)

+ (UIImage *)GetLocalImage:(NSString *)imageName withImageType:(NSString *)imageType
{
    if (nil == imageName || nil == imageType) {
        return nil;
    }
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:imageType];
    return [[UIImage alloc] initWithContentsOfFile:imagePath];
}

@end
