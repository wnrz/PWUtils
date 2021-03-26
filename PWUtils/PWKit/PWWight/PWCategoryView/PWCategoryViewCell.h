//
//  PWCategoryViewCell.h
//  PWUtils
//
//  Created by 王宁 on 2021/3/25.
//

#import <UIKit/UIKit.h>
#import "PWCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWCategoryViewCell : UICollectionViewCell
@property (nonatomic, weak)IBOutlet UIImageView *imageView;
@property (nonatomic, weak)IBOutlet UILabel *label;

@property (nonatomic,strong)PWCategoryModel *model;
@end

NS_ASSUME_NONNULL_END
