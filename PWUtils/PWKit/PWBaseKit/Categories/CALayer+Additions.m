//
//  CALayer+Additions.m
//  GWUIKit
//
//  Created by mac on 2018/1/15.
//

#import "CALayer+Additions.h"

@implementation CALayer (Additions)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

@end
