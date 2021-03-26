//
//  PWCategoryViewCell.m
//  PWUtils
//
//  Created by 王宁 on 2021/3/25.
//

#import "PWCategoryViewCell.h"
#import "UIImage+MyImage.h"
#import "BaseTool.h"
@import SDWebImage;

@implementation PWCategoryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setup];
}

- (void)setup{
    _imageView.image = [UIImage imageWithColor:UIColorFromRGB(0xe0e0e)];
}

- (void)setModel:(PWCategoryModel *)model{
    _model = model;
    NSURL *url = [NSURL URLWithString:model.imageUrl];
    
    [_imageView sd_setImageWithURL:url placeholderImage:_imageView.image completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    _label.text = model.title;
}

@end
