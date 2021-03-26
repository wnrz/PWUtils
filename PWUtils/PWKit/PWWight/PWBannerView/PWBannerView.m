//
//  ZBBannerView.m
//  PWUtils
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "PWBannerView.h"
#import "BaseTool.h"
#import "NSBundle+PWBundleTool.h"
#import <SDWebImage/SDWebImage.h>
@import QuartzCore;
@import CHIPageControl;
@interface PWBannerView(){
    NSInteger showIndex;
    NSInteger perIndex;
    NSInteger nextIndex;
    NSInteger scrollDelay;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerBG;
@property (weak, nonatomic) IBOutlet UIImageView *banner1;
@property (weak, nonatomic) IBOutlet UIImageView *banner2;
@property (weak, nonatomic) IBOutlet UIImageView *banner3;

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *banner1_left;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *banner1_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *banner1_right;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *banner1_bottom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *banner2_left;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *banner2_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *banner2_right;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *banner2_bottom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *banner3_left;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *banner3_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *banner3_right;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *banner3_bottom;

@property (weak, nonatomic) IBOutlet CHIPageControlAleppo *pageControlAleppo;

@end

@implementation PWBannerView

- (instancetype)init{
    NSString *className = NSStringFromClass([self class]);
    if ([className containsString:@"."]) {
        NSArray *array = [className componentsSeparatedByString:@"."];
        if (array.count > 1) {
            className = [className componentsSeparatedByString:@"."][1];
        }
    }
    NSBundle *bundle = [NSBundle bundleWith:self.class fileName:className fileType:@"nib"];
    if (bundle) {
        NSArray *array = [bundle loadNibNamed:className owner:self options:nil];
        self = array[0];
    }else{
        self = [super init];
    }
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        scrollDelay = 5;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
//    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
//    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    if (IsValidateArr(_images2) || IsValidateArr(_images1)) {
        [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * 3, 0)];
    }
}

- (void)setBannerBG:(UIImageView *)bannerBG{
    _bannerBG = bannerBG;
    _bannerBGImage ? _bannerBG.image = _bannerBGImage : 0;
}

- (void)setBannerBGImage:(UIImage *)bannerBGImage{
    _bannerBGImage = bannerBGImage;
    _bannerBG.image = bannerBGImage;
}

- (void)setImages1:(NSArray *)images1{
    _images1 = images1;
    [self makeImages];
}

- (void)setPadding:(UIEdgeInsets)padding{
    _padding = padding;
    _banner1_left.constant = padding.left;
    _banner1_top.constant = padding.top;
    _banner1_right.constant = padding.right;
    _banner1_bottom.constant = padding.bottom;
    
    _banner2_left.constant = padding.left;
    _banner2_top.constant = padding.top;
    _banner2_right.constant = padding.right;
    _banner2_bottom.constant = padding.bottom;
    
    _banner3_left.constant = padding.left;
    _banner3_top.constant = padding.top;
    _banner3_right.constant = padding.right;
    _banner3_bottom.constant = padding.bottom;
}

- (void)setImageCornerRadius:(CGFloat)imageCornerRadius{
    _imageCornerRadius = imageCornerRadius;
    _banner1.layer.cornerRadius = imageCornerRadius;
    _banner1.layer.masksToBounds = true;
    _banner2.layer.cornerRadius = imageCornerRadius;
    _banner2.layer.masksToBounds = true;
    _banner3.layer.cornerRadius = imageCornerRadius;
    _banner3.layer.masksToBounds = true;
}

- (void)setPageControlAleppo:(CHIPageControlAleppo *)pageControlAleppo{
    _pageControlAleppo = pageControlAleppo;
    pageControlAleppo.padding = 5;
    pageControlAleppo.radius = 4;
    pageControlAleppo.numberOfPages = 0;
    pageControlAleppo.inactiveTransparency = 1;
//    pageControlAleppo.tintColor = 
}

- (void)makeImages{
    _pageControlAleppo.numberOfPages = _images2.count + _images1.count;
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    if (IsValidateArr(_images2) || IsValidateArr(_images1)) {
        [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width * 3, 0)];
        if ((_images2.count + _images1.count) == 1) {
            _scrollView.scrollEnabled = NO;
            _pageControlAleppo.hidden = YES;
        }
        perIndex = showIndex - 1;
        nextIndex = showIndex +1;
        if ((_images2.count + _images1.count) > 1) {
            if (showIndex >= (_images2.count + _images1.count)) {
                perIndex = (int)(_images2.count + _images1.count) - 1;
                nextIndex = 1;
                showIndex = 0;
            }else if (showIndex == (_images2.count + _images1.count) - 1) {
                nextIndex = 0;
            }else if (showIndex == 0){
                perIndex = (int)(_images2.count + _images1.count) - 1;
            }
        }else{
            showIndex = 0;
            perIndex = 0;
            nextIndex = 0;
        }
        [_banner1 sd_setImageWithURL:[self getImageUrlWithIndex:perIndex] placeholderImage:_placeholderImage];
        [_banner2 sd_setImageWithURL:[self getImageUrlWithIndex:showIndex] placeholderImage:_placeholderImage];
        [_banner3 sd_setImageWithURL:[self getImageUrlWithIndex:nextIndex] placeholderImage:_placeholderImage];
    }
    [_pageControlAleppo setProgress:showIndex];
    if ((_images2.count + _images1.count) > 1) {
        _scrollView.scrollEnabled = YES;
        _pageControlAleppo.hidden = NO;
        [self performSelector:@selector(startScroll) withObject:nil afterDelay:scrollDelay];
    }
}

- (NSURL *)getImageUrlWithIndex:(NSInteger)imageIndex{
    NSURL *imageUrl;
    if ((_images2.count + _images1.count) > imageIndex) {
        NSString *url;
        if (imageIndex >= _images2.count) {
            url = [_images1 objectAtIndex:imageIndex - _images2.count];
        }else{
            url = [_images2 objectAtIndex:imageIndex];
        }
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        imageUrl = [NSURL URLWithString:url];
    }
    return imageUrl;
}

- (void)startScroll{
//        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * 2, 0) animated:YES];
}

- (IBAction)actionButtonPressed:(id)sender{
    if (_clickEvent) {
        _clickEvent(self , showIndex);
    }
}

- (IBAction)pageControlValueChanged:(id)sender{
    if ([sender currentPage] != showIndex) {
        if ([sender currentPage] > showIndex) {
            [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * 2, 0) animated:YES];
        }else if ([sender currentPage] < showIndex) {
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int x = (scrollView.contentOffset.x - scrollView.frame.size.width) / scrollView.frame.size.width;
    
    if (x < 0) {
        showIndex = perIndex;
    }else if (x > 0){
        showIndex = nextIndex;
    }
    [self makeImages];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    int x = (scrollView.contentOffset.x - scrollView.frame.size.width) / scrollView.frame.size.width;
    
    if (x < 0) {
        showIndex = perIndex;
    }else if (x > 0){
        showIndex = nextIndex;
    }
    [self makeImages];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    NSLog(@"BannerToZbViewController");
    if (self.scrollView.frame.size.width != 0 && self.scrollView.contentSize.width == self.scrollView.frame.size.width) {
        [self makeImages];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > scrollView.bounds.size.width){
        double p = showIndex + (nextIndex - showIndex) * (scrollView.contentOffset.x / scrollView.bounds.size.width - 1);
        [_pageControlAleppo setProgress:p];
    }else{
        double p = showIndex + (showIndex - perIndex) * (scrollView.contentOffset.x / scrollView.bounds.size.width - 1);
        [_pageControlAleppo setProgress:p];
    }
//    [_pageControlAleppo setProgress:scrollView.contentOffset.x / scrollView.bounds.size.width];
}
@end
