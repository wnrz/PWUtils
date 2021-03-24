//
//  SMCBTabButtonView.h
//  SMCBProjcet
//
//  Created by mac on 2016/11/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLineTagHeight 2

typedef NS_ENUM(NSInteger, tagType) {
    NOTagType,
    LineTagType,
    ShortLineTagType,
    FixedLineTagType,
    BackgroundTagType,
    FixedBackgroundTagType,
    FullBackgroundTagType
};

typedef void(^PWTabButtonViewButtonEvent)(id tabButtonView , int index , BOOL *move);
@interface PWTabButtonView : UIScrollView <UIScrollViewDelegate>

@property(nonatomic , copy) PWTabButtonViewButtonEvent clickEvent;
@property(nonatomic , strong) NSArray *headerNames;
@property(nonatomic , strong) NSMutableArray *buttons;
@property(nonatomic , assign) double buttonWidth;
@property(nonatomic , assign) BOOL fixButtonWidthWithTitle;
@property(nonatomic , assign) double buttonSpace;
@property(nonatomic , assign) double leftSpace;
@property(nonatomic , assign) double rightSpace;
@property(nonatomic , assign) double tagWidth;
@property(nonatomic , assign) BOOL isTagCorner;
@property(nonatomic , assign) double viewWidth;
@property(nonatomic , weak) UIButton * tmpButton;
@property(nonatomic , assign) tagType tType;
@property(nonatomic , assign) BOOL unableTap;
@property(nonatomic , strong) UIScrollView *ScrollView;
@property(nonatomic , assign) BOOL showShadow;

@property(nonatomic , assign) BOOL isVertical;
@property(nonatomic , assign) double buttonHeight;
@property(nonatomic , assign) double topSpace;
@property(nonatomic , assign) double bottomSpace;


@property(nonatomic , assign) double borderWidth;
@property(nonatomic , strong) UIColor *borderColor;
@property(nonatomic , strong) UIColor *borderSelectedColor;
@property(nonatomic , assign) double borderCornerRadius;


- (PWTabButtonView *)initWithCoder:(NSCoder *)aDecoder;
- (void)setTextColor:(UIColor *)color selectColor:(UIColor *)selectColor;
- (void)setTagColor:(UIColor *)color;
- (void)setHeaderNames:(NSArray *)array;
- (void)buttonPressed:(UIButton *)button;
- (void)moveTagToButton:(UIButton *)button;
- (void)moveTagToButton:(UIButton *)button animated:(BOOL)animated;
- (void)setLabelFont:(UIFont *)font;
- (void)setSelectedLabelFont:(UIFont *)font;
- (void)setTextColor:(UIColor *)color;
- (void)setTextSelectColor:(UIColor *)selectColor;
- (void)updateButtonColor:(UIColor *)color selectColor:(UIColor *)selectColor;
- (void)setHiddenLineView:(BOOL)isHidden;
- (NSInteger)currentIndex;
@end
