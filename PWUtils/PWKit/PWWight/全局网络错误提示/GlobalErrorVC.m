//
//  QuoTabButtonView.m
//  AFNetworking
//
//  Created by 王宁 on 2018/7/16.
//

#import "GlobalErrorVC.h"
#import <BaseUtils/BaseTool.h>
#import <BaseUtils/NSBundle+PWBundleTool.h>
@import Masonry;

@interface GlobalErrorVC () {
}

@property(nonatomic , weak) IBOutlet UILabel *label;
@end

@implementation GlobalErrorVC

+(GlobalErrorVC *)shareManager{
    //使用单一线程，解决网络同步请求的问题
    static GlobalErrorVC* shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[GlobalErrorVC alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:shareInstance selector:@selector(show:) name:@"GlobalErrorVC_shareManager_show" object:nil];
    });
    return shareInstance;
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
    return self;
}

- (void)dealloc{
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)reTry:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(globalErrorVCReTry)]){
        [self.delegate globalErrorVCReTry];
        [self.view removeFromSuperview];
    }
}

- (void)show:(NSNotification *)notify{
    if (self.delegate != nil){
        UIView *v;
        if ([self.delegate isKindOfClass:[UIView class]]){
            v = (UIView *)self.delegate;
        }else if ([self.delegate isKindOfClass:[UIViewController class]]){
            v = ((UIViewController *)self.delegate).view;
        }
        if ([self.view.superview isEqual:v]){
            return;
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(globalErrorVCReTry)]){
        UIView *v;
        if ([self.delegate isKindOfClass:[UIView class]]){
            v = (UIView *)self.delegate;
        }else if ([self.delegate isKindOfClass:[UIViewController class]]){
            v = ((UIViewController *)self.delegate).view;
        }
        if (v != nil){
            [v addSubview:self.view];
            [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(self->_left));
                make.top.equalTo(@(self->_top));
                make.right.equalTo(@(self->_right));
                make.bottom.equalTo(@(self->_bottom));
            }];
            self.label.text = [@"加载失败，请检查网络后重试！\n" stringByAppendingString:notify.userInfo[@"functionID"]];
        }
    }
}

- (void)setDelegate:(id<GlobalErrorVCDelegate>)delegate{
    _delegate = delegate;
    _left = 0;
    _top = 0;
    _right = 0;
    _bottom = 0;
}
@end
