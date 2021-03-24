//
//  BaseQuoCell.m
//  AFNetworking
//
//  Created by 王宁 on 2018/7/14.
//

#import "PWBaseView.h"
#import <BaseUtils/NSBundle+PWBundleTool.h>

@implementation PWBaseView

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
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
