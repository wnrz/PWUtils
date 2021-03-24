//
//  PWPageControl.m
//  AFNetworking
//
//  Created by 王宁 on 2019/7/25.
//

#import "PWPageControl.h"
@import BaseUtils;

#define kDotW 4  //圆点的宽度
#define kDotW2 12  //圆点的宽度
#define kDotH 4  //圆点的宽度
#define kMagrin 5 //圆点之间的间隔

@implementation PWPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    self = [super init];
    if (self){
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setup];
    }
    return self;
}

- (void)setup{
    self.currentPageIndicatorTintColor = UIColorFromRGB(0xc8c8c8);
    self.tintColor = UIColorFromRGB(0x858585);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    [self updateFrame];
}

- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    NSBundle *b = [NSBundle bundleWith:[self class] fileName:@"PWPageControl_selected.png" fileType:@""];
    if (b != nil) {
        if (@available(iOS 14, *)) {
            self.currentPageIndicatorTintColor = UIColorFromRGB(0xc8c8c8);
            self.pageIndicatorTintColor = UIColorFromRGB(0x848484);
        }else{
            [self setValue:[UIImage imageNamed:@"PWPageControl_selected.png" inBundle:b compatibleWithTraitCollection:nil] forKeyPath:@"_currentPageImage"];
            [self setValue:[UIImage imageNamed:@"PWPageControl_unselected.png" inBundle:b compatibleWithTraitCollection:nil] forKeyPath:@"_pageImage"];
        }
    }
    [self updateFrame];
}

- (void)updateFrame{
    //计算圆点尺寸和间距的长度
    
//    CGFloat marginX = kDotW + kMagrin;
    
    //计算整个pageControll的宽度
    CGFloat newW = (self.numberOfPages - 1) * kDotW + kDotW + (self.numberOfPages + 1) * kMagrin; //self.frame.size.width;//(self.subviews.count - 1 ) * magrin + self.subviews.count *dotW;
    
    //计算左边距
    CGFloat leftRight = kMagrin;//(newW - ((self.subviews.count - 1 ) * kMagrin + self.subviews.count * kDotW)) / 2;
    
    //设置新frame
    CGPoint center = self.center;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    self.center = center;
    
    //遍历subview,设置圆点frame
    CGFloat x = leftRight;
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        [dot setFrame:CGRectMake(x, dot.frame.origin.y, ((self.currentPage == i) ? kDotW2 : kDotW), kDotH)];
        x = x + ((self.currentPage == i) ? kDotW2 : kDotW) + kMagrin;
    }
}
@end
