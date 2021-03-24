//
//  PWBaseViewController.h
//  PWUIKit
//
//  Created by 王宁 on 2018/7/11.
//

#import <UIKit/UIKit.h>
#import "NSBundle+PWBundleTool.h"

@interface PWBaseViewController : UIViewController
- (void)backAction;
+ (PWBaseViewController *)getViewController;
+ (PWBaseViewController *)getViewController:(NSDictionary *)dict;
+ (void)Push;
+ (void)Push:(NSDictionary *)dict;
+ (void)Present;
+ (void)Present:(NSDictionary *)dict;
- (void)makeBackButton;
- (void)showRightButtonWithTitle:(NSString *)title sel:(SEL)sel;
- (void)showRightButtonWithImage:(UIImage *)img sel:(SEL)sel;
- (void)interfaceOrientation:(UIDeviceOrientation)orientation;
- (void)updateViewByNetworkingReachability;
- (void)setStatusBarColor:(UIColor *)color;
@end
