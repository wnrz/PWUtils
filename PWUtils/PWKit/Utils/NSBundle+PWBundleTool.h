//
//  BundleTools.h
//  BaseUtils
//
//  Created by 王宁 on 2018/7/14.
//

#import <Foundation/Foundation.h>

@interface NSBundle (PWBundleTool)

+ (NSBundle *)bundleWith:(Class)fromClass fileName:(NSString *)fileName fileType:(NSString *)fileType;
@end
