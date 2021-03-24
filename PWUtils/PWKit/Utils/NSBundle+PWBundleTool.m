//
//  BundleTools.m
//  BaseUtils
//
//  Created by 王宁 on 2018/7/14.
//

#import "NSBundle+PWBundleTool.h"

@implementation NSBundle (PWBundleTool)

+ (NSBundle *)bundleWith:(Class)fromClass fileName:(NSString *)fileName fileType:(NSString *)fileType{
    __block NSBundle *bundle;
    NSArray *arr = [[NSBundle bundleForClass:fromClass] pathsForResourcesOfType:@"bundle" inDirectory:nil];
    __block NSString *path;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *bundlePath = obj;
        path = [[NSBundle bundleWithPath:bundlePath] pathForResource:fileName ofType:fileType];
        if (path.length > 0) {
            bundle = [NSBundle bundleWithPath:bundlePath];
            *stop = YES;
        }
    }];
    return bundle;
}
@end
