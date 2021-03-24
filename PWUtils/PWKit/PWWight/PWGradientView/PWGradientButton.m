//
//  UIButton_Color_Brand.m
//  GWUIKit-ENOWight
//
//  Created by mac on 2018/2/9.
//

#import "PWGradientButton.h"
@import YYKit;

@interface PWGradientButton (){
    UIColor *leftColor;
    UIColor *rightColor;
    UIColor *gradientBackgroundColor;
    CAGradientLayer *gradientLayer;
}

@end

@implementation PWGradientButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (void)didMoveToSuperview{
//    [super didMoveToSuperview];
//    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
//}


-(void)dealloc
{
    [self removeObserverBlocks];
}

- (instancetype)init {
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        [self addObserverBlockForKeyPath:@"bounds" block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf drawGradient];
        }];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        __weak typeof(self) weakSelf = self;
        [self addObserverBlockForKeyPath:@"bounds" block:^(id  _Nonnull obj, id  _Nullable oldVal, id  _Nullable newVal) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf drawGradient];
        }];
    }
    return self;
}

- (void)setGradientLeftColor:(UIColor *)gradientLeftColor{
    _gradientLeftColor = gradientLeftColor;
    [self drawGradient];
}

- (void)setGradientRightColor:(UIColor *)gradientRightColor{
    _gradientRightColor = gradientRightColor;
    [self drawGradient];
}

- (void)setLeftColor:(UIColor *)color{
    leftColor = color;
}

- (void)setRightColor:(UIColor *)color{
    rightColor = color;
}

- (void)setGradientBackgroundColor:(UIColor *)color{
    if (!leftColor || !rightColor) {
        return;
    }
    if (gradientLayer) {
        [gradientLayer removeFromSuperlayer];
        gradientLayer = nil;
    }
    gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.frame;  // 设置显示的frame
    gradientLayer.colors = @[(id)leftColor.CGColor,(id)rightColor.CGColor];  // 设置渐变颜色
    gradientLayer.locations = @[@0.3 , @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);   //
    gradientLayer.endPoint = CGPointMake(1, 0);     //
    [gradientLayer setPosition:CGPointMake([self bounds].size.width / 2, [self bounds].size.height / 2)];
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)drawGradient{
    if (!_gradientLeftColor || !_gradientRightColor) {
        return;
    }
    if (gradientLayer != nil) {
        [gradientLayer removeFromSuperlayer];
    }
    gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.frame;  // 设置显示的frame
    UIColor *lColor = [UIColor colorWithRed:_gradientLeftColor.red green:_gradientLeftColor.green blue:_gradientLeftColor.blue alpha:_gradientLeftColor.alpha * (self.enabled ? 1 : 0.5)];
    UIColor *rColor = [UIColor colorWithRed:_gradientRightColor.red green:_gradientRightColor.green blue:_gradientRightColor.blue alpha:_gradientRightColor.alpha * (self.enabled ? 1 : 0.5)];
    gradientLayer.colors = @[(id)lColor.CGColor,(id)rColor.CGColor];  // 设置渐变颜色
    gradientLayer.locations = @[@0.3 , @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);   //
    gradientLayer.endPoint = CGPointMake(1, 0);     //
    [gradientLayer setPosition:CGPointMake([self bounds].size.width / 2, [self bounds].size.height / 2)];
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    [self drawGradient];
}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"frame"]){
//        [self drawGradient];
//    }
//}
@end
