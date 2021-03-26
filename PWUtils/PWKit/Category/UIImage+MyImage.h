//
//  UIImage+MyImage.h
//  socketTest
//
//  Created by mac on 14-9-23.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MyImage)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage*) imageWithColor:(UIColor*)color;
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
- (UIImage *) imageWithTintColor2:(UIColor *)tintColor;
@end
