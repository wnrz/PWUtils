//
//  SMCBTabButtonView.m
//  SMCBProjcet
//
//  Created by mac on 2016/11/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PWTabButtonView.h"
#import <QuartzCore/QuartzCore.h>
//#import <BusUtils/BusUtils.h>
#import "PWGradientView.h"
#import "BaseColors.h"
#import "CommonMacro.h"
#import "BaseTool.h"
#import <SDAutoLayout/SDAutoLayout.h>
@import Masonry;

@interface PWTabButtonView(){
    UIFont *textFont;
    UIFont *selectedLabelFont;
    UIColor *textColor;
    UIColor *textSelectColor;
    UIColor *tagColor;
    UIView *buttonView;
    UIView *tagView;
    UIView *lineView;
    
    PWGradientView *leftShadowView,*rightShadowView;
}

@end

@implementation PWTabButtonView

- (PWTabButtonView *)initWithCoder:(NSCoder *)aDecoder{
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
    
    tagView = [[UIView alloc] init];
    [self insertSubview:tagView atIndex:0];
    [self addSubview:lineView];
    _leftSpace = 10;
    _rightSpace = 10;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    lineView.frame = CGRectMake(0, self.frame.size.height-.5, self.frame.size.width, .5);
    [self setShadow];
}

- (void)dealloc{
    _headerNames = nil;
    self.clickEvent = nil;
    for (int i = (int)_buttons.count - 1 ; i >= 0 ; i--) {
        UIButton *b = [_buttons objectAtIndex:i];
        [_buttons removeObject:b];
        [b removeFromSuperview];
    }
    if (leftShadowView) {
        [leftShadowView removeFromSuperview];
        leftShadowView = nil;
    }
    if (rightShadowView) {
        [rightShadowView removeFromSuperview];
        rightShadowView = nil;
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

- (void)setTType:(tagType)tType{
    _tType = tType;
    tagView.hidden = YES;
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
    if (self.tType == NOTagType) {
    }else if (self.tType == FixedLineTagType) {
        if (_tagWidth == 0) {
            _tagWidth = 15;
        }
        tagView.frame = CGRectMake(self.leftSpace + width / 2 - _tagWidth / 2, self.frame.size.height - kLineTagHeight - 1, _tagWidth, kLineTagHeight);
    }else if (self.tType == LineTagType) {
        if (_tagWidth == 0) {
            _tagWidth = _borderWidth;
        }
        tagView.frame = CGRectMake(self.leftSpace + width / 2 - _tagWidth / 2, self.frame.size.height - kLineTagHeight - 1, _tagWidth, kLineTagHeight);
    }else if (self.tType == BackgroundTagType) {
        tagView.frame = CGRectMake(self.leftSpace + width / 2 - _tagWidth / 2, 0, _tagWidth, textFont.pointSize + 10);
        tagView.layer.cornerRadius = 4;
        tagView.layer.masksToBounds = YES;
    }else if (self.tType == ShortLineTagType) {
        if (_tagWidth == 0) {
            _tagWidth = 30;
        }
        tagView.frame = CGRectMake(self.leftSpace + width / 2 - _tagWidth / 2, self.frame.size.height - kLineTagHeight - 1, _tagWidth, kLineTagHeight);
    }else if (self.tType == FullBackgroundTagType) {
        tagView.frame = CGRectMake(self.leftSpace + width / 2 - _buttonWidth / 2, 0, _buttonWidth, self.frame.size.height);
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

- (void)setTagColor:(UIColor *)color{
    tagColor = color;
    if (tagView){
        tagView.backgroundColor = tagColor != nil ? tagColor : textSelectColor;
    }
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
    tagView.backgroundColor = tagColor != nil ? tagColor : selectColor;
}

- (void)updateButtonColor:(UIColor *)color selectColor:(UIColor *)selectColor{
    NSArray *tmp = [NSArray arrayWithArray:_buttons];
    [tmp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = obj;
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setTitleColor:selectColor forState:UIControlStateSelected];
    }];
    tagView.backgroundColor = tagColor != nil ? tagColor : selectColor;
}

- (void)resetHeaderNames{
    if (_viewWidth == 0) {
        _viewWidth = kScreenWidth;
    }
    [self clearHeaderNames];
    if (!IsValidateArr(_headerNames)) {
        return;
    }
    if (_isVertical) {
        _buttonHeight = _buttonHeight > 0 ? _buttonHeight : 30;
        __block CGFloat height = _buttonHeight * _headerNames.count + (_buttonSpace * _headerNames.count - 1) + _topSpace + _bottomSpace;
        buttonView.frame = CGRectMake(0, 0, self.frame.size.width, height);
    }else if (_fixButtonWidthWithTitle) {
        __block CGFloat width = 0;
        NSArray *arr = [NSArray arrayWithArray:_headerNames];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *title = obj;
            CGSize titleSize = [BaseTool sizeWithContent:title font:self->textFont width:10000];
            if (width > 0){
                width = width + self->_buttonSpace;
            }
            width = width + titleSize.width + 22;
        }];
        buttonView.frame = CGRectMake(0, 0, width + (_leftSpace + _rightSpace), self.frame.size.height);
    }else{
        if (_buttonWidth <= 0) {
            _buttonWidth = (_viewWidth - (_leftSpace + _rightSpace)) / _headerNames.count;
            buttonView.frame = CGRectMake(0, 0, _viewWidth, self.frame.size.height);
        }else{
            buttonView.frame = CGRectMake(0, 0, _buttonWidth * _headerNames.count + (_leftSpace + _rightSpace) + _buttonSpace * (_headerNames.count - 1), self.frame.size.height);
        }
    }
    float w = buttonView.frame.size.width;
    float h = buttonView.frame.size.height;
    [buttonView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
        make.width.equalTo(@(w));
        make.height.equalTo(@(h));
    }];
    self.contentSize = CGSizeMake(w, h);
    
    for (int i = 0; i < _headerNames.count; i++) {
        if (_isVertical) {
            UIButton *b = [[UIButton alloc] init];
            [_buttons addObject:b];
            [b setTitle:_headerNames[i] forState:UIControlStateNormal];
            [b setTitleColor:textColor forState:UIControlStateNormal];
            [b setTitleColor:textSelectColor forState:UIControlStateSelected];
            b.titleLabel.font = textFont;
            //        b.enabled = !_unableTap;
            [buttonView addSubview:b];
            b.translatesAutoresizingMaskIntoConstraints = NO;
            [b addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            //        NSMutableArray *constraints = [[NSMutableArray alloc] init];
            UIView *toItem;
            int con;
//            NSLayoutAttribute leftLA;
            if (i == 0) {
                toItem = buttonView;
                con = _topSpace;
//                leftLA = NSLayoutAttributeLeft;
            }else{
                UILabel *b2 = [_buttons objectAtIndex:i - 1];
                toItem = b2;
                con = _buttonSpace;
//                leftLA = NSLayoutAttributeRight;
            }
            [b mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo((i == 0) ? toItem : toItem.mas_bottom).offset(con);
                make.left.equalTo(self->buttonView);
                make.right.equalTo(self->buttonView);
            }];
            if (i > 0) {
                if (_buttonHeight <= 0) {
                    [b mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(toItem.mas_height);
                    }];
                }else{
                    [b mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(@(self->_buttonHeight));
                    }];
                }
                
            }else{
                if (_buttonHeight <= 0) {
                }else{
                    [b mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(@(self->_buttonHeight));
                    }];
                }
            }
            if (i == _headerNames.count - 1) {
                if (_buttonHeight <= 0) {
                    [b mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(self->buttonView).offset(-self->_bottomSpace);
                    }];
                }else{
                    [b mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(@(self->_buttonHeight));
                    }];
                }
            }
        }else{
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
            if (i == 0) {
                toItem = buttonView;
                con = _leftSpace;
//                leftLA = NSLayoutAttributeLeft;
            }else{
                UILabel *b2 = [_buttons objectAtIndex:i - 1];
                toItem = b2;
                con = _buttonSpace;
//                leftLA = NSLayoutAttributeRight;
            }
            [b mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo((i == 0) ? toItem : toItem.mas_right).offset(con);
                make.top.equalTo(self->buttonView);
                make.bottom.equalTo(self->buttonView);
            }];
            if (_fixButtonWidthWithTitle) {
                CGSize titleSize = [BaseTool sizeWithContent:_headerNames[i] font:textFont width:10000];
                [b mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@(titleSize.width + 22));
                }];
            }else{
                if (i > 0) {
                    if (_buttonWidth <= 0) {
                        [b mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.equalTo(toItem.mas_width);
                        }];
                    }else{
                        [b mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.equalTo(@(self->_buttonWidth));
                        }];
                    }
                }else{
                    if (_buttonWidth <= 0) {
                    }else{
                        [b mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.width.equalTo(@(self->_buttonWidth));
                        }];
                    }
                }
            }
            if (i == _headerNames.count - 1) {
                if (_buttonWidth <= 0) {
                    [b mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self->buttonView).offset(-self->_rightSpace);
                    }];
                }else{
                    [b mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.width.equalTo(@(self->_buttonWidth));
                    }];
                }
            }
            //        [BaseTool useConstraint:constraints fromView:buttonView];
        }
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
    [self moveTagToButton:button animated:YES];
}

- (void)moveTagToButton:(UIButton *)button animated:(BOOL)animated{
    _viewWidth = kScreenWidth;
    if (_buttonWidth <= 0) {
        _buttonWidth = (_viewWidth - (_leftSpace + _rightSpace)) / _headerNames.count;
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
    
    int idx = (int)[_buttons indexOfObject:button];
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
    if (_isTagCorner) {
        tagView.layer.cornerRadius = kLineTagHeight / 2;
        tagView.layer.masksToBounds = YES;
    }else{
        tagView.layer.cornerRadius = 0;
    }
    float time = animated ? .2 : 0;
    if (_tType == NOTagType) {
        tagView.hidden = YES;
    }else if (_fixButtonWidthWithTitle){
        [UIView animateWithDuration:time animations:^{
            CGRect frame = self->tagView.frame;
            frame.origin.y = self.frame.size.height - kLineTagHeight - 1;
            frame.origin.x = self.leftSpace + button.frame.size.width - frame.size.width / 2;
            self->tagView.frame = frame;
            self->tagView.center = CGPointMake(button.center.x, self->tagView.center.y);
        } completion:^(BOOL finished) {
            self->tagView.hidden = NO;
        }];
        tagView.backgroundColor = tagColor != nil ? tagColor :[button titleColorForState:UIControlStateSelected];
    }else{
        CGSize titleSize = [BaseTool sizeWithContent:button.titleLabel.text font:button.titleLabel.font width:self->_buttonWidth];
        if (_tType == LineTagType ) {
            [UIView animateWithDuration:time animations:^{
                self->tagView.frame = CGRectMake(self.leftSpace + idx * self->_buttonWidth, self.frame.size.height - kLineTagHeight - 1, self->_buttonWidth, kLineTagHeight);
                //                tagView.center = CGPointMake(button.center.x, tagView.center.y);
            } completion:^(BOOL finished) {
                self->tagView.hidden = NO;
            }];
            tagView.backgroundColor = tagColor != nil ? tagColor :[button titleColorForState:UIControlStateSelected];
        }else if (_tType == BackgroundTagType || _tType == FixedBackgroundTagType) {
            CGFloat width = (_tType == FixedBackgroundTagType) ? titleSize.width + 22 : _buttonWidth;
            [UIView animateWithDuration:time animations:^{
                self->tagView.frame = CGRectMake(self.leftSpace + idx * self->_buttonWidth, self->tagView.frame.origin.y, width, button.titleLabel.font.pointSize + 10);
                self->tagView.center = button.center;
                //                tagView.center = button.center;
            } completion:^(BOOL finished) {
                self->tagView.center = button.center;
                self->tagView.hidden = NO;
            }];
            tagView.layer.cornerRadius = _tType == FixedBackgroundTagType ? (button.titleLabel.font.pointSize + 10) / 2.0 : 4;
            tagView.layer.masksToBounds = YES;
            tagView.backgroundColor = tagColor != nil ? tagColor : [button titleColorForState:UIControlStateNormal];
        }else if (_tType == ShortLineTagType) {
            [UIView animateWithDuration:time animations:^{
                self->tagView.frame = CGRectMake(self.leftSpace + idx * self->_buttonWidth + (self->_buttonWidth - titleSize.width) / 2, self.frame.size.height - kLineTagHeight - 1, titleSize.width, kLineTagHeight);
                //                tagView.center = CGPointMake(button.center.x, tagView.center.y);
            } completion:^(BOOL finished) {
                self->tagView.hidden = NO;
            }];
            tagView.backgroundColor = tagColor != nil ? tagColor : [button titleColorForState:UIControlStateSelected];
        }else if (_tType == FixedLineTagType) {
            [UIView animateWithDuration:time animations:^{
                self->tagView.frame = CGRectMake(self.leftSpace + idx * self->_buttonWidth + (self->_buttonWidth - self->_tagWidth) / 2, self.frame.size.height - kLineTagHeight - 1, self->_tagWidth, kLineTagHeight);
                //                tagView.center = CGPointMake(button.center.x, tagView.center.y);
            } completion:^(BOOL finished) {
                self->tagView.hidden = NO;
            }];
            tagView.backgroundColor = tagColor != nil ? tagColor : [button titleColorForState:UIControlStateSelected];
        }else if (_tType == FullBackgroundTagType) {
            [UIView animateWithDuration:time animations:^{
                self->tagView.center = button.center;
                self->tagView.frame = CGRectMake(self.leftSpace + idx * self->_buttonWidth, 0, self->_buttonWidth, self.frame.size.height);
                //                tagView.center = button.center;
            } completion:^(BOOL finished) {
                self->tagView.hidden = NO;
            }];
            tagView.backgroundColor = tagColor != nil ? tagColor : [button titleColorForState:UIControlStateNormal];
        }
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
            [UIView animateWithDuration:time animations:^{
                self.contentOffset = CGPointMake(b1.frame.origin.x, 0);
            }];
        }else if (b2.frame.origin.x + b2.frame.size.width > self.contentOffset.x + self.frame.size.width) {
            [UIView animateWithDuration:time animations:^{
                self.contentOffset = CGPointMake(b2.frame.origin.x + b2.frame.size.width - self.frame.size.width, 0);
            }];
        }else if (!b2){
            [UIView animateWithDuration:time animations:^{
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

- (void)setShadow{
    if (!_showShadow) {
        return;
    }
    if (!self.superview) {
        return;
    }
    CGFloat width = kScreenWidth / 6;
    if (!leftShadowView) {
        leftShadowView = [[PWGradientView alloc]  initWithFrame:CGRectMake(0, 0, width, self.frame.size.height)];
        leftShadowView.hidden = YES;
        leftShadowView.userInteractionEnabled = NO;
        [leftShadowView setLeftColor:UIColorFromRGBAndAlpha(0xffffff, 1)];
        [leftShadowView setRightColor:UIColorFromRGBAndAlpha(0xffffff, 0)];
    }
    if (!rightShadowView) {
        rightShadowView = [[PWGradientView alloc]  initWithFrame:CGRectMake(0, 0, width, self.frame.size.height)];
        rightShadowView.hidden = YES;
        rightShadowView.userInteractionEnabled = NO;
        [rightShadowView setLeftColor:UIColorFromRGBAndAlpha(0xffffff, 0)];
        [rightShadowView setRightColor:UIColorFromRGBAndAlpha(0xffffff, 1)];
    }
    if (![leftShadowView.superview isEqual:self.superview]) {
        [self.superview addSubview:leftShadowView];
        leftShadowView.sd_layout
        .leftEqualToView(self)
        .topEqualToView(self)
        .bottomEqualToView(self)
        .widthIs(width);
    }
    
    if (![rightShadowView.superview isEqual:self.superview]) {
        [self.superview addSubview:rightShadowView];
        rightShadowView.sd_layout
        .rightEqualToView(self)
        .topEqualToView(self)
        .bottomEqualToView(self)
        .widthIs(width);
    }
    [self updateShadowView];
}

- (void)updateShadowView{
    if (!_showShadow) {
        leftShadowView.hidden = YES;
        rightShadowView.hidden = YES;
        return;
    }
    leftShadowView.hidden = self.contentOffset.x == 0;
    rightShadowView.hidden = self.contentOffset.x > (self.contentSize.width - self.frame.size.width - 10);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_showShadow) {
        [self updateShadowView];
    }
}
@end
