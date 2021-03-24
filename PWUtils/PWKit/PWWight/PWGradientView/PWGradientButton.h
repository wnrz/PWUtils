//
//  UIButton_Color_Brand.h
//  GWUIKit-ENOWight
//
//  Created by mac on 2018/2/9.
//

#import <UIKit/UIKit.h>

@interface PWGradientButton : UIButton

@property (nonatomic, strong) IBInspectable UIColor *gradientLeftColor;
@property (nonatomic, strong) IBInspectable UIColor *gradientRightColor;


- (void)setLeftColor:(UIColor *)color;
- (void)setRightColor:(UIColor *)color;
- (void)setGradientBackgroundColor:(UIColor *)color;
- (void)drawGradient;
@end
