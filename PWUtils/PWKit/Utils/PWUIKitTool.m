//
//  PWUIKitTool.m
//  GWUtils
//
//  Created by mac on 2017/12/29.
//  Copyright © 2017年 com.gw. All rights reserved.
//

#import "PWUIKitTool.h"
#import "BaseTool.h"

@implementation PWUIKitTool

+ (void)clearSubviews:(UIView *)view{
    if ([view isKindOfClass:[UIView class]]) {
        NSArray *subviews = [NSArray arrayWithArray:view.subviews];
        for (NSInteger i = subviews.count - 1 ; i >= 0 ; i--) {
            UIView *v = subviews[i];
            [v removeFromSuperview];
            v = nil;
        }
    }
}

+ (void)clearSubviews:(UIView *)view withClassName:(NSString *)className{
    if (!className) {
        return;
    }
    if ([view isKindOfClass:[UIView class]]) {
        for (NSInteger i = view.subviews.count - 1 ; i >= 0 ; i--) {
            id v = [view subviews][i];
            NSString *c = NSStringFromClass([v class]);
            if ([c isEqual:className]) {
                [v removeFromSuperview];
                v = nil;
            }
        }
    }
}


+ (void)setFullConstraint:(UIView *)fromView toItem:(UIView *)toItem{
    NSMutableArray *constraints = nil;//[[NSMutableArray alloc] init];
    NSLayoutConstraint* leftConstraint = [NSLayoutConstraint
                                          constraintWithItem:fromView
                                          attribute:NSLayoutAttributeLeft
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:toItem
                                          attribute:NSLayoutAttributeLeft
                                          multiplier:1.0f
                                          constant:0.0f];
    NSLayoutConstraint* topConstraint = [NSLayoutConstraint
                                         constraintWithItem:fromView
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:toItem
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.0f
                                         constant:0.0f];
    NSLayoutConstraint* bottomConstraint = [NSLayoutConstraint
                                            constraintWithItem:fromView
                                            attribute:NSLayoutAttributeBottom
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:toItem
                                            attribute:NSLayoutAttributeBottom
                                            multiplier:1.0f
                                            constant:0.0f];
    
    NSLayoutConstraint* rightConstraint = [NSLayoutConstraint
                                           constraintWithItem:fromView
                                           attribute:NSLayoutAttributeRight                                                        relatedBy:NSLayoutRelationEqual
                                           toItem:toItem
                                           attribute:NSLayoutAttributeRight
                                           multiplier:1.0f
                                           constant:-10];
    constraints = [NSMutableArray arrayWithArray:@[leftConstraint,topConstraint,bottomConstraint,rightConstraint]];
    [BaseTool useConstraint:constraints fromView:toItem];
}
@end
