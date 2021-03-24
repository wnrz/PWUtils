//
//  PWUIKitTool.h
//  GWUtils
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 com.gw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PWUIKitTool : NSObject

+ (void)clearSubviews:(UIView *)view;
+ (void)clearSubviews:(UIView *)view withClassName:(NSString *)className;

+ (void)setFullConstraint:(UIView *)fromView toItem:(UIView *)toItem;
@end
