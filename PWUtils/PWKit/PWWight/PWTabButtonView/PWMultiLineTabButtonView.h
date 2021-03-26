//
//  SMCBTabButtonView.h
//  PWUtils
//
//  Created by mac on 2016/11/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLineTagHeight 2

typedef void(^PWMultiLineTabButtonViewButtonEvent)(id tabButtonView , int index , BOOL *move);
@interface PWMultiLineTabButtonView : UIScrollView <UIScrollViewDelegate>

@property(nonatomic , copy) PWMultiLineTabButtonViewButtonEvent clickEvent;
@property(nonatomic , strong) NSArray *headerNames;
@property(nonatomic , strong) NSMutableArray *buttons;
@property(nonatomic , weak) UIButton * tmpButton;
@property(nonatomic , assign) BOOL unableTap;
@property(nonatomic , strong) UIScrollView *ScrollView;
@property(nonatomic , assign) int oneLineButtonCount;


@property(nonatomic , assign) CGSize buttonSize;
@property(nonatomic , assign) UIEdgeInsets edgeInsets;

@property(nonatomic , assign) double verticalSpace;
@property(nonatomic , assign) double horizontalSpace;


@property(nonatomic , assign) double borderWidth;
@property(nonatomic , strong) UIColor *borderColor;
@property(nonatomic , strong) UIColor *borderSelectedColor;
@property(nonatomic , assign) double borderCornerRadius;


- (PWMultiLineTabButtonView *)initWithCoder:(NSCoder *)aDecoder;
- (void)setTextColor:(UIColor *)color selectColor:(UIColor *)selectColor;
- (void)setHeaderNames:(NSArray *)array;
- (void)buttonPressed:(UIButton *)button;
- (void)moveTagToButton:(UIButton *)button;
- (void)setLabelFont:(UIFont *)font;
- (void)setSelectedLabelFont:(UIFont *)font;
- (void)setTextColor:(UIColor *)color;
- (void)setTextSelectColor:(UIColor *)selectColor;
- (void)updateButtonColor:(UIColor *)color selectColor:(UIColor *)selectColor;
- (void)setHiddenLineView:(BOOL)isHidden;
- (NSInteger)currentIndex;
@end
