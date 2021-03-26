//
//  UIImage+UIImage_extrase.h
//  GoldenWay
//
//  Created by 胡双喜 on 2017/1/17.
//  Copyright © 2017年 fs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_extrase)
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage *)circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size;
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;
@end
