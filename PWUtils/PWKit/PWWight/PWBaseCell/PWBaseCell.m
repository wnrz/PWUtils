//
//  BaseQuoCell.m
//  AFNetworking
//
//  Created by 王宁 on 2018/7/14.
//

#import "PWBaseCell.h"
#import <BaseUtils/NSBundle+PWBundleTool.h>

@implementation PWBaseCell

+ (NSString *)identifier{
    return [NSString stringWithFormat:@"BaseUIKit_%@" , NSStringFromClass(self.class)];
}

+ (CGFloat)height{
    return 44;
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [self.class initWithNib];
    if (!self) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    }
    return self;
}

@end
