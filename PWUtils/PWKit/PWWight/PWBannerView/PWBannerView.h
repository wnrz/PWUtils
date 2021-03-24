//
//  ZBBannerView.h
//  SMCBProjcet
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PWBannerViewButtonEvent)(id bannerView , NSInteger index);
@interface PWBannerView : UIView<UIScrollViewDelegate>

@property (copy, nonatomic) UIImage *bannerBGImage;
@property (copy, nonatomic) UIImage *placeholderImage;

@property (nonatomic, strong) NSArray *images1;
@property (nonatomic, strong) NSArray *images2;

@property(nonatomic,copy) PWBannerViewButtonEvent clickEvent;

@end
