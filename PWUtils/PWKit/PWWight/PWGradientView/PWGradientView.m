//
//  UIButton_Color_Brand.m
//  GWUIKit-ENOWight
//
//  Created by mac on 2018/2/9.
//

#import "PWGradientView.h"

@interface PWGradientView (){
    UIColor *leftColor;
    UIColor *rightColor;
    UIColor *gradientBackgroundColor;
}

@end

@implementation PWGradientView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setLeftColor:(UIColor *)color{
    leftColor = color;
    [self setGradientBackgroundColor:nil];
}

- (void)setRightColor:(UIColor *)color{
    rightColor = color;
    [self setGradientBackgroundColor:nil];
}

- (void)setGradientBackgroundColor:(UIColor *)color{
    if (!leftColor || !rightColor) {
        return;
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.frame;  // 设置显示的frame
    gradientLayer.colors = @[(id)leftColor.CGColor,(id)rightColor.CGColor];  // 设置渐变颜色
    gradientLayer.locations = @[@0 , @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);   //
    gradientLayer.endPoint = CGPointMake(1, 0);     //
    [gradientLayer setPosition:CGPointMake([self bounds].size.width / 2, [self bounds].size.height / 2)];
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    [gradientLayer setBounds:self.bounds];
//    NSArray *colors = [NSArray arrayWithObjects:
//                       (id) [UIColor colorWithRed:129.0f / 255.0f green:151.0f / 255.0f blue:179.0f / 255.0f alpha:0.8f].CGColor, // top
//                       (id) [UIColor colorWithRed:111.0f / 245.0f green:133.0f / 255.0f blue:162.0f / 255.0f alpha:0.4f].CGColor, // center
//                       (id) [UIColor colorWithRed:95.0f / 245.0f green:118.0f / 255.0f blue:151.0f / 255.0f alpha:0.4f].CGColor, // center
//                       (id) [UIColor colorWithRed:75.0f / 245.0f green:99.0f / 255.0f blue:133.0f / 255.0f alpha:0.8f].CGColor, // bottom
//                       nil];
//
//    CALayer *buttonLayer = self.layer;
//    [gradientLayer setPosition:CGPointMake([self bounds].size.width / 2, [self bounds].size.height / 2)];
//    [gradientLayer setColors:colors];
//    [buttonLayer insertSublayer:gradientLayer atIndex:0];
//
//    [self setTitleColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f] forState:UIControlStateNormal];
//    [self setTintColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3f]];
}

@end
