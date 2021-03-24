//
//  PWPagingTableView+mingyanjingju.m
//  AFNetworking
//
//  Created by 王宁 on 2018/10/15.
//

#import "PWPagingTableView+mingyanjingju.h"
#import <MJRefresh/MJRefresh.h>
#import <BaseUtils/GTAppUtils.h>
#import <BaseUtils/NSObject+Swizzling.h>
#import <objc/runtime.h>

@implementation PWPagingTableView (mingyanjingju)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [PWPagingTableView swizzleMethod:@selector(setBeginHeaderRefreshingOperation:) swizzledSelector:@selector(mingyanjingju_setBeginHeaderRefreshingOperation:)];
        }
    });
}

- (void)changeMYJJ{
    if (self.mjheader) {
        NSArray *titleArray = [GTAppUtils myjj];//@[@"投资，必须具备正确判断的能力。", @"一定要在自己的理解力允许的范围内投资。", @"投资必须是理性的，如果你不能理解它，就不要做。", @"买卖遭损失时，以谋，求摊低成本。", @"不进行研究的投资，必然失败。", @"看不懂、看不准、没把握时坚决不进场。", @"先学会做空，再学会做多。", @"君子问凶不问吉，高手看盘先看跌。", @"婪与恐惧，投资之大忌。", @"心态第一，策略第二，技术第三。", @"涨时重势，跌时重质。", @"耐心是致胜的关键，信心是成功的保障。", @"下降通道抢反弹，无异于刀口舔血。", @"一要稳、二要准、三要等、四要狠、五要忍。", @"该跌的不跌理应看涨，该涨的不涨则坚决看跌。"];
        [(MJRefreshNormalHeader *)self.mjheader setTitle:titleArray[arc4random() % titleArray.count] forState:MJRefreshStatePulling];
    }
}

- (void)mingyanjingju_setBeginHeaderRefreshingOperation:(void (^)(void))beginHeaderRefreshingOperation{
    [self changeMYJJ];
    __weak typeof(self) weakSelf = self;
    __block void (^handle)(void) = beginHeaderRefreshingOperation;
    [self mingyanjingju_setBeginHeaderRefreshingOperation:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf changeMYJJ];
        if (handle) {
            handle();
        }
    }];
}
@end
