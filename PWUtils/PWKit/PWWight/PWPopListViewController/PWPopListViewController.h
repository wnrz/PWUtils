//
//  PWPopListViewController.h
//  BaseUIKit
//
//  Created by 王宁 on 2018/7/25.
//
#import "PWBaseViewController.h"

@interface PWPopListViewConfig : NSObject

@property (nonatomic , copy) NSArray *titles;
@property (nonatomic , strong) UIFont *font;
@property (nonatomic , assign) CGFloat rowHeight;
@property (nonatomic , assign) CGFloat rowWidth;
@property (nonatomic , assign) CGFloat maxTableViewHeight;
@property (nonatomic , assign) NSTextAlignment textAlignment;
@end


typedef void(^PWPopListViewEvent)(id popListViewController , NSInteger index , NSString *title);
@interface PWPopListViewController : PWBaseViewController<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) PWPopListViewConfig *config;
@property(nonatomic,copy) PWPopListViewEvent clickEvent;

+ (void)showViewControllerWith:(PWPopListViewConfig *)config on:(id)sender block:(PWPopListViewEvent)event;
- (CGRect)getRect;
@end
