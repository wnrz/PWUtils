//
//  PWBaseViewController.m
//  PWUIKit
//
//  Created by 王宁 on 2018/7/11.
//

#import "PWBaseViewController.h"
#import <BaseUtils/NSBundle+PWBundleTool.h>
#import "GlobalErrorVC.h"

@import BaseUtils;
@import AFNetworking;

@interface PWBaseViewController ()<GlobalErrorVCDelegate>{
    GlobalErrorVC *globalErrorVC;
}

@end

@implementation PWBaseViewController

+ (PWBaseViewController *)getViewController{
    PWBaseViewController *vc = [[[self class] alloc] init];
    return vc;
}

+ (PWBaseViewController *)getViewController:(NSDictionary *)dict{
    PWBaseViewController *vc = [[[self class] alloc] init];
    return vc;
}

+ (void)Push{
    PWBaseViewController *vc = [[[self class] alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [[BaseTool getNav] pushViewController:vc animated:YES];
}

+ (void)Push:(NSDictionary *)dict{
    PWBaseViewController *vc = [[[self class] alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [[BaseTool getNav] pushViewController:vc animated:YES];
}

+ (void)Present{
    PWBaseViewController *vc = [[[self class] alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [[BaseTool topPresentedViewController] presentViewController:vc animated:YES completion:nil];
}

+ (void)Present:(NSDictionary *)dict{
    PWBaseViewController *vc = [[[self class] alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [[BaseTool topPresentedViewController] presentViewController:vc animated:YES completion:nil];
}

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
        self = [super initWithNibName:className bundle:bundle];
    }else{
        self = [super init];
    }
    if (self) {
        
    }
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    globalErrorVC = [GlobalErrorVC shareManager];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    // Do any additional setup after loading the view.
    
    if (![self.navigationController.viewControllers.firstObject isEqual:self]) {
        [self makeBackButton];
    }
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{
                                                                     NSForegroundColorAttributeName:UIColorFromRGB(0x333333),
                                                                     NSFontAttributeName:[GTSkinCss getInstance].mainTextRegularFont} forState:UIControlStateNormal];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:UIColorFromRGB(0x333333),
                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController != nil) {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    [UIApplication sharedApplication].keyWindow.backgroundColor = UIColorFromRGB(0xffffff);
//    [self setStatusBarColor];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateViewByNetworkingReachability) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    if ([self respondsToSelector:@selector(globalErrorVCReTry)]){
        globalErrorVC.delegate = self;
    }
    NSLog(@"%@ is viewDidAppear",NSStringFromClass([self class]));
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AFNetworkingReachabilityDidChangeNotification object:nil];
    if (globalErrorVC.delegate == self){
        globalErrorVC.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)makeBackButton{
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSBundle *bundle = [NSBundle bundleWith:self.class fileName:@"back_image_w@2x" fileType:@"png"];
    UIImage *image = [UIImage imageNamed:@"back_image_w" inBundle:bundle compatibleWithTraitCollection:nil];
    UIImage *originalImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:originalImage style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor blackColor]];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showRightButtonWithTitle:(NSString *)title sel:(SEL)sel{
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    if (IsValidateString(title)){
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 16 * title.length, 30);
    }
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:UIColorFromRGB(0x5886D5)  forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)showRightButtonWithImage:(UIImage *)img sel:(SEL)sel{
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    if (img){
        UIImage *tmp = [img imageByTintColor:PW_Color(PWColorKey_font_1)];
        [button setImage:tmp forState:UIControlStateNormal];
    }
    button.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    button.titleColorKey = PWColorKey_font_1;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (BOOL)prefersStatusBarHidden {
    
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

-(BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

/* 强制改变横竖屏状态 */
- (void)interfaceOrientation:(UIDeviceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)updateViewByNetworkingReachability{
    
}

- (void)setStatusBarColor{
    [self setStatusBarColor:[UIColor whiteColor]];
}
- (void)setStatusBarColor:(UIColor *)color{
    UIView *statusBar;
    if (@available(iOS 13.0, *)) {
        if (!statusBar) {
            // iOS 13  弃用keyWindow属性  从所有windowl数组中取
            UIWindow *keyWindow = [UIApplication sharedApplication].windows[0];
            statusBar = [[UIView alloc] initWithFrame:keyWindow.windowScene.statusBarManager.statusBarFrame];
            [keyWindow addSubview:statusBar];
        }
    } else {
        statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    }
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
@end
