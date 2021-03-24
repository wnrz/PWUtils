//
//  PWBaseCollectionCell.m
//
//
//  Created by 王宁 on 2018/7/14.
//

#import "PWBaseCollectionCell.h"
#import <BaseUtils/NSBundle+PWBundleTool.h>

@implementation PWBaseCollectionCell

+ (NSString *)identifier{
    return [NSString stringWithFormat:@"BaseUIKit_%@" , NSStringFromClass(self.class)];
}

+ (CGSize)size{
    return CGSizeMake(100, 100);
}

- (instancetype)init{
    self = [self.class initWithNib];
    if (!self) {
        self = [super init];
    }
    return self;
}

+ (instancetype)initWithNib{
    id obj;
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
        obj = array[0];
    }
    return obj;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [self.class initWithNib];
    if (!self) {
        self = [super initWithFrame:frame];
    }
    return self;
}

@end
