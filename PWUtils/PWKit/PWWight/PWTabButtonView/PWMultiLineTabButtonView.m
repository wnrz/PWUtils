//
//  SMCBTabButtonView.m
//  PWUtils
//
//  Created by mac on 2016/11/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PWMultiLineTabButtonView.h"
#import "BaseTool.h"
#import <QuartzCore/QuartzCore.h>
#import <SDAutoLayout/SDAutoLayout.h>
//#import <BusUtils/BusUtils.h>
#import "PWGradientView.h"
@import Masonry;

@interface PWMultiLineTabButtonView(){
    UIFont *textFont;
    UIFont *selectedLabelFont;
    UIColor *textColor;
    UIColor *textSelectColor;
    UIColor *tagColor;
    UIView *buttonView;
    UIView *lineView;
}

@end

@implementation PWMultiLineTabButtonView

- (PWMultiLineTabButtonView *)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self install];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self install];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self install];
    }
    return self;
}

- (void)install{
    self.delegate = self;
    textFont = [UIFont systemFontOfSize:14];
    textColor = UIColorFromRGBWithDecimal(175, 134, 79);
    textSelectColor = UIColorFromRGBWithDecimal(175, 134, 79);
    _buttons = [[NSMutableArray alloc] init];
    buttonView = [[UIView alloc] init];
    lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, self.frame.size.height-.5, self.frame.size.width, .5);
    lineView.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    
    [self addSubview:lineView];
    _edgeInsets.left = 10;
    _edgeInsets.right = 10;
    _oneLineButtonCount = MAX(1, _oneLineButtonCount);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    lineView.frame = CGRectMake(0, self.frame.size.height-.5, self.frame.size.width, .5);
}

- (void)dealloc{
    _headerNames = nil;
    self.clickEvent = nil;
    for (int i = (int)_buttons.count - 1 ; i >= 0 ; i--) {
        UIButton *b = [_buttons objectAtIndex:i];
        [_buttons removeObject:b];
        [b removeFromSuperview];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)setHiddenLineView:(BOOL)isHidden{
    lineView.hidden = isHidden;
}

- (void)updateTagViewFrame{
    double width = 0;
    if (_buttons.count > 0){
        UIButton *b = _buttons[0];
        width = b.frame.size.width;
    }
    if (width == 0){
        return;
    }
}

- (void)setTextColor:(UIColor *)color selectColor:(UIColor *)selectColor {
    textColor = color;
    textSelectColor = selectColor;
    NSArray *buttonArray = [NSArray arrayWithArray:self.buttons];
    [buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = obj;
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setTitleColor:selectColor forState:UIControlStateSelected];
        
    }];
}

- (void)setHeaderNames:(NSArray *)array{
    _headerNames = array;
    [self resetHeaderNames];
}

- (void)setLabelFont:(UIFont *)font{
    textFont = font;
    [self resetHeaderNames];
}

- (void)setSelectedLabelFont:(UIFont *)font{
    selectedLabelFont = font;
    [self resetHeaderNames];
}

- (void)setTextColor:(UIColor *)color{
    NSArray *tmp = [NSArray arrayWithArray:_buttons];
    [tmp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = obj;
        [button setTitleColor:color forState:UIControlStateNormal];
    }];
}

- (void)setTextSelectColor:(UIColor *)selectColor{
    NSArray *tmp = [NSArray arrayWithArray:_buttons];
    [tmp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = obj;
        [button setTitleColor:selectColor forState:UIControlStateSelected];
    }];
}

- (void)updateButtonColor:(UIColor *)color selectColor:(UIColor *)selectColor{
    NSArray *tmp = [NSArray arrayWithArray:_buttons];
    [tmp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = obj;
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setTitleColor:selectColor forState:UIControlStateSelected];
    }];
}

- (void)resetHeaderNames{
    [self clearHeaderNames];
    if (!IsValidateArr(_headerNames)) {
        return;
    }
    
    if (_buttonSize.width <= 0) {
        _buttonSize.width = (self.frame.size.width - (_edgeInsets.left + _edgeInsets.right)) / _oneLineButtonCount;
    }
    //    buttonView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    float w = buttonView.frame.size.width;
    float h = buttonView.frame.size.height;
//    [buttonView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.bottom.equalTo(self);
//        make.width.equalTo(@(w));
//        make.height.equalTo(@(h));
//    }];
    self.contentSize = CGSizeMake(w, h);
    
    for (int i = 0; i < _headerNames.count; i++) {
        UIButton *b = [[UIButton alloc] init];
        [_buttons addObject:b];
        [b setTitle:_headerNames[i] forState:UIControlStateNormal];
        [b setTitleColor:textColor forState:UIControlStateNormal];
        [b setTitleColor:textSelectColor forState:UIControlStateSelected];
        b.titleLabel.font = textFont;
        [buttonView addSubview:b];
        b.translatesAutoresizingMaskIntoConstraints = NO;
        [b addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        UIView *toItem;
        int con;
        //            NSLayoutAttribute leftLA;
        if (i % _oneLineButtonCount == 0) {
            toItem = buttonView;
            con = _edgeInsets.left;
        }else{
            UILabel *b2 = [_buttons objectAtIndex:i - 1];
            toItem = b2;
            con = _horizontalSpace;
        }
        _buttonSize.width = MAX(0, _buttonSize.width);
        _buttonSize.height = MAX(0, _buttonSize.height);
        [b mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo((i % _oneLineButtonCount == 0) ? toItem : toItem.mas_right).offset(con);
            make.top.equalTo(self->buttonView).offset(_edgeInsets.top + i / _oneLineButtonCount * (_buttonSize.height + _verticalSpace));
            if (i / _oneLineButtonCount == _headerNames.count / _oneLineButtonCount){
                make.bottom.equalTo(self->buttonView).offset(_edgeInsets.bottom);
            }
            make.width.equalTo(@(self->_buttonSize.width));
            make.height.equalTo(@(self->_buttonSize.height));
            if ((i % _oneLineButtonCount == _oneLineButtonCount - 1)) {
                make.right.equalTo(self->buttonView).offset(-self->_edgeInsets.right);
            }
        }];
        //        [BaseTool useConstraint:constraints fromView:buttonView];
    }
    
    [_buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *b = obj;
        b.layer.borderWidth = self->_borderWidth;
        if (self->_borderWidth != 0) {
            if (b.selected) {
                if (self->_borderSelectedColor) {
                    b.layer.borderColor = self->_borderSelectedColor.CGColor;
                }
            }else{
                if (self->_borderColor) {
                    b.layer.borderColor = self->_borderColor.CGColor;
                }
            }
            b.layer.cornerRadius = self->_borderCornerRadius;
            b.layer.masksToBounds = YES;
        }
    }];
    [self layoutIfNeeded];
    [self updateTagViewFrame];
}

- (void)clearHeaderNames{
    _tmpButton = nil;
    for (int i = (int)_buttons.count - 1; i >= 0; i--) {
        id subview = [_buttons firstObject];
        [_buttons removeObject:subview];
        [subview removeFromSuperview];
        subview = nil;
    }
}

- (void)buttonPressed:(UIButton *)button{
    if (self.clickEvent && !_unableTap) {
        BOOL move = YES;
        self.clickEvent(self , (int)[_buttons indexOfObject:button] , &move);
        if (move) {
            [self moveTagToButton:button];
        }
    }
}

- (void)moveTagToButton:(UIButton *)button{
    if (_buttonSize.width <= 0) {
        _buttonSize.width = (self.frame.size.width - (_edgeInsets.left + _edgeInsets.right)) / _headerNames.count;
    }
    if ([_tmpButton isEqual:button]) {
        return;
    }
    
    if (self->_borderWidth != 0) {
        if (_borderSelectedColor) {
            button.layer.borderColor = _borderSelectedColor.CGColor;
        }
        if (_borderColor) {
            _tmpButton.layer.borderColor = self->_borderColor.CGColor;
        }
    }
    
    _tmpButton.selected = NO;
    _tmpButton.titleLabel.font = textFont;
    _tmpButton = button;
    _tmpButton.selected = YES;
    if (selectedLabelFont) {
        _tmpButton.titleLabel.font = selectedLabelFont;
    }
    if (_ScrollView) {
        [_ScrollView setContentOffset:CGPointMake([_buttons indexOfObject:button] * _ScrollView.frame.size.width, 0) animated:YES];
    }
    
    if (self.contentSize.width > self.frame.size.width) {
        int index = (int)[_buttons indexOfObject:button];
        UIButton *b1;
        UIButton *b2;
        if (index > 0) {
            b1 = [_buttons objectAtIndex:index - 1];
        }
        if (index < _buttons.count - 1) {
            b2 = [_buttons objectAtIndex:index + 1];
        }
        if (b1.frame.origin.x < self.contentOffset.x) {
            [UIView animateWithDuration:.2 animations:^{
                self.contentOffset = CGPointMake(b1.frame.origin.x, 0);
            }];
        }else if (b2.frame.origin.x + b2.frame.size.width > self.contentOffset.x + self.frame.size.width) {
            [UIView animateWithDuration:.2 animations:^{
                self.contentOffset = CGPointMake(b2.frame.origin.x + b2.frame.size.width - self.frame.size.width, 0);
            }];
        }else if (!b2){
            [UIView animateWithDuration:.2 animations:^{
                self.contentOffset = CGPointMake(self.contentSize.width - self.frame.size.width, 0);
            }];
        }
    }
}

- (NSInteger)currentIndex{
    if (_buttons.count > 0 && [_buttons containsObject:_tmpButton]) {
        return [_buttons indexOfObject:_tmpButton];
    }
    return -1;
}
@end
