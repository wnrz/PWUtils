//
//  BaseTool.m
//  FAFViewTest
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FileTool.h"
#import "BaseTool.h"
//#import "BaseModel.h"
@implementation FileTool

#pragma mark - Documents

/**
 * storeToDocuments:withPath:
 *
 * 将文件存储到Documents目录下
 */
+ (BOOL)storeToDocuments:(id)object withPath:(NSString *)path {
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [FileTool storeDictionaryToDocuments:object withPath:path];
    } else if ([object isKindOfClass:[NSArray class]]) {
        return [FileTool storeArrayToDocuments:object withPath:path];
//    } else if ([object isKindOfClass:[BaseModel class]]) {
//        return [FileTool storeBaseModelToDocuments:object withPath:path];
    }
    
    return NO;
}

/**
 * storeDictionaryToDocuments:withPath:
 *
 * 将文件存储到Document目录下
 */
+ (BOOL)storeDictionaryToDocuments:(NSDictionary *)dic withPath:(NSString *)path {
    if (!dic || !path) {
        return NO;
    }
    
    return [dic writeToFile:[self getDocumentsPath:path] atomically:YES] && [BaseTool addSkipBackupAttributeToItemAtDocumentsDirectory:[self getDocumentsPath:path]];
}

/**
 * storeArrayToDocuments:withPath:
 *
 * 将文件存储到Document目录下
 */
+ (BOOL)storeArrayToDocuments:(NSArray *)arr withPath:(NSString *)path
{
    if (!arr || !path) {
        return NO;
    }
    
    return [arr writeToFile:[self getDocumentsPath:path] atomically:YES] && [BaseTool addSkipBackupAttributeToItemAtDocumentsDirectory:[self getDocumentsPath:path]];
}

/**
 * storeBaseModelToDocuments:withPath:
 *
 * 将文件存储到Document目录下
 */
//+ (BOOL)storeBaseModelToDocuments:(BaseModel *)baseModel withPath:(NSString *)path
//{
//    if ( !baseModel || !path ) {
//        return NO;
//    }
//    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:baseModel];
//    return [data writeToFile:[self getDocumentsPath:path] atomically:YES] && [CommonMethods addSkipBackupAttributeToItemAtDocumentsDirectory:[self getDocumentsPath:path]];
//}

/**
 * clearFileInDocuments:
 *
 * 将存储在Document目录下的文件删除
 */
+ (BOOL)clearFileInDocuments:(NSString *)path {
    if (!path) {
        return NO;
    }
    
    return [[NSFileManager defaultManager] removeItemAtPath:[self getDocumentsPath:path] error:nil];
}

+ (NSString *)getDocumentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:fileName];
    return path;
}

#pragma mark - Tmp

/**
 * storeToTmp:withPath:
 *
 * 将文件存储到Tmp目录下
 */
+ (BOOL)storeToTmp:(id)object withPath:(NSString *)path
{
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [self storeDictionaryToTmp:object withPath:path];
    } else if ([object isKindOfClass:[NSArray class]]) {
        return [self storeArrayToTmp:object withPath:path];
//    } else if ([object isKindOfClass:[BaseModel class]]) {
//        return [self storeBaseModelToTmp:object withPath:path];
    }
    
    return NO;
}

/**
 * storeDictionaryToTmp:withPath:
 *
 * 将文件存储到Tmp目录下
 */
+ (BOOL)storeDictionaryToTmp:(NSDictionary *)dic withPath:(NSString *)path
{
    if (!dic || !path) {
        return NO;
    }
    
    return [dic writeToFile:[self getTmpPath:path] atomically:YES];
}

/**
 * storeArrayToTmp:withPath:
 *
 * 将文件存储到Tmp目录下
 */
+ (BOOL)storeArrayToTmp:(NSArray *)arr withPath:(NSString *)path
{
    if (!arr || !path) {
        return NO;
    }
    
    return [arr writeToFile:[self getTmpPath:path] atomically:YES];
}

/**
 * storeBaseModelToTmp:withPath:
 *
 * 将文件存储到Document目录下
 */
//+ (BOOL)storeBaseModelToTmp:(BaseModel *)baseModel withPath:(NSString *)path
//{
//    if (!baseModel || !path) {
//        return NO;
//    }
//    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:baseModel];
//    return [data writeToFile:[self getTmpPath:path] atomically:YES];
//}

/**
 * clearFileInTmp:
 *
 * 将存储在Tmp目录下的文件删除
 */
+ (BOOL)clearFileInTmp:(NSString *)path
{
    if (!path) {
        return NO;
    }
    
    return [[NSFileManager defaultManager] removeItemAtPath:[self getTmpPath:path] error:nil];
}

+ (NSString *)getTmpPath:(NSString *)fileName
{
    NSString *path = NSTemporaryDirectory();
    return [path stringByAppendingPathComponent:fileName];
}

#pragma mark - Library

/**
 * storeToLibrary:withPath:
 *
 * 将文件存储到Library目录下
 */
+ (BOOL)storeToLibrary:(id)object withPath:(NSString *)path
{
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [self storeDictionaryToLibrary:object withPath:path];
    } else if ([object isKindOfClass:[NSArray class]]) {
        return [self storeArrayToLibrary:object withPath:path];
//    } else if ([object isKindOfClass:[BaseModel class]]) {
//        return [self storeBaseModelToLibrary:object withPath:path];
    }
    
    return NO;
}

/**
 * storeDictionaryToLibrary:withPath:
 *
 * 将文件存储到Library目录下
 */
+ (BOOL)storeDictionaryToLibrary:(NSDictionary *)dic withPath:(NSString *)path
{
    if (!dic || !path) {
        return NO;
    }
    
    return [dic writeToFile:[self getLibraryPath:path] atomically:YES];
}

/**
 * storeArrayToLibrary:withPath:
 *
 * 将文件存储到Library目录下
 */
+ (BOOL)storeArrayToLibrary:(NSArray *)arr withPath:(NSString *)path
{
    if (!arr || !path) {
        return NO;
    }
    
    return [arr writeToFile:[self getLibraryPath:path] atomically:YES];
}

/**
 * storeBaseModelToLibrary:withPath:
 *
 * 将文件存储到Library目录下
 */
//+ (BOOL)storeBaseModelToLibrary:(BaseModel *)baseModel withPath:(NSString *)path
//{
//    if (!baseModel || !path) {
//        return NO;
//    }
//    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:baseModel];
//    return [data writeToFile:[self getLibraryPath:path] atomically:YES];
//}

/**
 * clearFileInLibrary:
 *
 * 将存储在Library目录下的文件删除
 */
+ (BOOL)clearFileInLibrary:(NSString *)path
{
    if (!path) {
        return NO;
    }
    
    return [[NSFileManager defaultManager] removeItemAtPath:[self getLibraryPath:path] error:nil];
}

+ (NSString *)getLibraryPath:(NSString *)fileName
{
    NSString *path = NSHomeDirectory();
    return [path stringByAppendingPathComponent:fileName];
}

#pragma mark - Caches

/**
 * storeToCaches:withPath:
 *
 * 将文件存储到Caches目录下
 */
+ (BOOL)storeToCaches:(id)object withPath:(NSString *)path
{
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [self storeDictionaryToCaches:object withPath:path];
    } else if ([object isKindOfClass:[NSArray class]]) {
        return [self storeArrayToCaches:object withPath:path];
//    } else if ([object isKindOfClass:[BaseModel class]]) {
//        return [self storeBaseModelToCaches:object withPath:path];
    }
    
    return NO;
}

/**
 * storeDictionaryToCaches:withPath:
 *
 * 将文件存储到Caches目录下
 */
+ (BOOL)storeDictionaryToCaches:(NSDictionary *)dic withPath:(NSString *)path
{
    if (!dic || !path) {
        return NO;
    }
    
    return [dic writeToFile:[self getCachesPath:path] atomically:YES];
}

/**
 * storeArrayToCaches:withPath:
 *
 * 将文件存储到Caches目录下
 */
+ (BOOL)storeArrayToCaches:(NSArray *)arr withPath:(NSString *)path
{
    if (!arr || !path) {
        return NO;
    }
    
    return [arr writeToFile:[self getCachesPath:path] atomically:YES];
}

/**
 * storeBaseModelToCaches:withPath:
 *
 * 将文件存储到Caches目录下
 */
//+ (BOOL)storeBaseModelToCaches:(BaseModel *)baseModel withPath:(NSString *)path
//{
//    if (!baseModel || !path) {
//        return NO;
//    }
//    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:baseModel];
//    return [data writeToFile:[self getCachesPath:path] atomically:YES];
//}

/**
 * clearFileInCaches:
 *
 * 将存储在Caches目录下的文件删除
 */
+ (BOOL)clearFileInCaches:(NSString *)path
{
    if (!path) {
        return NO;
    }
    
    return [[NSFileManager defaultManager] removeItemAtPath:[self getCachesPath:path] error:nil];
}

+ (NSString *)getCachesPath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:fileName];
    return path;
}

/*****   Store To Document With Key ********/

#pragma mark - Store String To Document With Key

/**
 * storeStringToDocuments:withPath:withKey:
 *
 * 将字符串存储到Documents目录下
 */
+ (BOOL)storeStringToDocuments:(NSString *)str withPath:(NSString *)path withKey:(NSString *)key {
    if ( nil == str || path == nil || key == nil ) {
        return NO;
    }
    
    NSDictionary * strDic = @{ [NSString stringWithFormat:@"%@", key] : [NSString stringWithFormat:@"%@", str] };
    return [self storeDictionaryToDocuments:strDic withPath:path];
}

/**
 * getStringFromDocumentsWithPath:withKey:
 *
 * 从Documents目录下获取字符串
 */
+ (NSString *)getStringFromDocumentsWithPath:(NSString *)path withKey:(NSString *)key {
    if ( path == nil || key == nil ) {
        return nil;
    }
    
    NSDictionary * strDic = [NSDictionary dictionaryWithContentsOfFile:[self getDocumentsPath:path]];
    if ( strDic && [strDic isKindOfClass:[NSDictionary class]] && [strDic objectForKey:key] ) {
        return [NSString stringWithFormat:@"%@", [strDic objectForKey:@"key"]];
    }
    
    return nil;
}

static const NSString * kDefaultDocumentsStorePathOfString = @"kDefaultDocumentsStorePathOfString";

/**
 * storeStringToDocuments:withKey:
 *
 * 将字符串存储到Documents目录下
 */
+ (BOOL)storeStringToDocuments:(NSString *)str withKey:(NSString *)key {
    if ( nil == str || key == nil ) {
        return NO;
    }
    
    NSDictionary * strDic = @{ [NSString stringWithFormat:@"%@", key] : [NSString stringWithFormat:@"%@", str] };
    return [self storeDictionaryToDocuments:strDic withPath:[NSString stringWithFormat:@"%@%@", kDefaultDocumentsStorePathOfString, key]];
}

/**
 * getStringFromDocumentsWithKey:
 *
 * 从Documents目录下获取字符串
 */
+ (NSString *)getStringFromDocumentsWithKey:(NSString *)key {
    if ( key == nil ) {
        return nil;
    }
    
    NSDictionary * strDic = [NSDictionary dictionaryWithContentsOfFile:[self getDocumentsPath:[NSString stringWithFormat:@"%@%@", kDefaultDocumentsStorePathOfString, key]]];
    if ( strDic && [strDic isKindOfClass:[NSDictionary class]] && [strDic objectForKey:key] ) {
        return [NSString stringWithFormat:@"%@", [strDic objectForKey:key]];
    }
    
    return nil;
}

#pragma mark - Store NSData To Document With Key

static const NSString * kDefaultDocumentsStorePathOfNSData = @"kDefaultDocumentsStorePathOfNSData";

+ (BOOL)storeNSDataToDocuments:(NSData *)data withKey:(NSString *)key {
    if ( nil == data || key == nil ) {
        return NO;
    }
    return [data writeToFile:[self getDocumentsPath:[NSString stringWithFormat:@"%@%@", kDefaultDocumentsStorePathOfNSData, key]] atomically:YES] && [BaseTool addSkipBackupAttributeToItemAtDocumentsDirectory:[self getDocumentsPath:[self getDocumentsPath:[NSString stringWithFormat:@"%@%@", kDefaultDocumentsStorePathOfNSData, key]]]];
}

+ (NSData *)getNSDataFromDocumentsWithKey:(NSString *)key {
    if ( key == nil ) {
        return nil;
    }
    NSData *data = [NSData dataWithContentsOfFile:[self getDocumentsPath:[NSString stringWithFormat:@"%@%@", kDefaultDocumentsStorePathOfNSData, key]]];
    return data;
}

#pragma mark - Store baseModel To Document With Key

static const NSString *kDefaultDocumentsStorePathOfBaseModelArr = @"kDefaultDocumentsStorePathOfBaseModelArr";

/**
 * storeBaseModelArrToDocuments:withKey:
 *
 * 将存储了BaseModel的数组存储到Documents目录下
 */
//+ (BOOL)storeBaseModelArrToDocuments:(NSArray *)arr withKey:(NSString *)key {
//    if ( !IsValidateArr(arr) || !IsValidateString(key) ) {
//        return NO;
//    }
//    
//    int pathIndex = [self getCountOfBaseModelFilesWithKey:key];
//    for ( BaseModel *baseModel in arr ) {
//        // 只存储不在本地列表中的数据
//        if ( ![self isTheBaseModelAtLocalStorage:baseModel WithKey:key] ) {
//            pathIndex++;
//            if ( !([self storeToDocuments:baseModel withPath:[[NSString stringWithFormat:@"%@%@", kDefaultDocumentsStorePathOfBaseModelArr, key] stringByAppendingString:[NSString stringWithFormat:@"%d", pathIndex]]]) ) {
//                return NO;
//            }
//        }
//    }
//    
//    return [self storeCountOfBaseModelFiles:pathIndex withKey:key];
//}

/**
 * getBaseModelArrFromDocumentsWithKey:
 *
 * 从Documents目录下获取存储了BaseModel的数组
 */
//+ (NSArray *)getBaseModelArrFromDocumentsWithKey:(NSString *)key {
//    if ( !IsValidateString(key) ) {
//        return nil;
//    }
//    
//    NSString *path = [self getDocumentsPath:[NSString stringWithFormat:@"%@%@", kDefaultDocumentsStorePathOfBaseModelArr, key]];
//    NSMutableArray *arr = [NSMutableArray array];
//    int countOfFiles = [self getCountOfBaseModelFilesWithKey:key];
//    for ( int i = 0; i < countOfFiles; i++ ) {
//        NSData *data = [NSData dataWithContentsOfFile:[path stringByAppendingString:[NSString stringWithFormat:@"%d", i + 1]]];
//        if ( data ) {
//            BaseModel *baseModel = (BaseModel *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
//            if ( baseModel ) {
//                [arr addObject:baseModel];
//            }
//        }
//    }
//    return arr;
//}

//+ (BOOL)isTheBaseModelAtLocalStorage:(BaseModel *)baseModel WithKey:(NSString *)key {
//    if ( IsValidateString(key) ) {
//        NSMutableArray *arr = [NSMutableArray arrayWithArray:[self getBaseModelArrFromDocumentsWithKey:key]];
//        if ( arr ) {
//            for ( BaseModel *model in arr ) {
//                if ( [model isEqual:baseModel] ) {
//                    return YES;
//                }
//            }
//        }
//    }
//    
//    return NO;
//}

- (NSString *)getDocumentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:fileName];
    return path;
}

//+ (BOOL)storeBaseModelToDocuments:(BaseModel *)baseModel withPath:(NSString *)path
//{
//    if ( !baseModel || !path ) {
//        return NO;
//    }
//    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:baseModel];
//    return [data writeToFile:[self getDocumentsPath:path] atomically:YES] && [BaseTool addSkipBackupAttributeToItemAtDocumentsDirectory:[self getDocumentsPath:path]];
//}

+ (BOOL)removeBaseModelArrFromDocumentsWithKey:(NSString *)key {
    if ( !IsValidateString(key) ) {
        return NO;
    }
    
    NSString *path = [self getDocumentsPath:[NSString stringWithFormat:@"%@%@", kDefaultDocumentsStorePathOfBaseModelArr, key]];
    int countOfFiles = [self getCountOfBaseModelFilesWithKey:key];
    for ( int i = 0; i < countOfFiles; i++ ) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:[path stringByAppendingString:[NSString stringWithFormat:@"%d", i + 1]] error:&error];
        if ( error ) {
            return NO;
        }
    }
    return [self storeCountOfBaseModelFiles:0 withKey:key];
}

static const NSString *kBaseModelFileCountStorePath  =   @"kBaseModelFileCountStorePath";
static const NSString *kBaseModelFileCountStoreKey   =   @"kBaseModelFileCountStoreKey";

+ (BOOL)storeCountOfBaseModelFiles:(int)count withKey:(NSString *)key {
    NSDictionary *countDic = @{ [NSString stringWithFormat:@"%@", kBaseModelFileCountStoreKey] : [NSString stringWithFormat:@"%d", count] };
    return [self storeToDocuments:countDic withPath:[NSString stringWithFormat:@"%@%@", kBaseModelFileCountStorePath, key]];
}

+ (int)getCountOfBaseModelFilesWithKey:(NSString *)key {
    NSDictionary *countDic = [NSDictionary dictionaryWithContentsOfFile:[self getDocumentsPath:[NSString stringWithFormat:@"%@%@", kBaseModelFileCountStorePath, key]]];
    if ( countDic ) {
        return [[countDic objectForKey:[NSString stringWithFormat:@"%@", kBaseModelFileCountStoreKey]] intValue];
    }
    
    return 0;
}

#pragma mark - Store NSDictionary To Document With Key

static const NSString * kDefaultDocumentsStorePathOfNSDictionary = @"kDefaultDocumentsStorePathOfNSDictionary";

+ (BOOL)storeNSDictionaryToDocuments:(NSDictionary *)dic withKey:(NSString *)key {
    if ( nil == dic || key == nil ) {
        return NO;
    }
    
    return [dic writeToFile:[self getDocumentsPath:[NSString stringWithFormat:@"%@%@", kDefaultDocumentsStorePathOfNSDictionary, key]] atomically:YES] && [BaseTool addSkipBackupAttributeToItemAtDocumentsDirectory:[self getDocumentsPath:[self getDocumentsPath:[NSString stringWithFormat:@"%@%@", kDefaultDocumentsStorePathOfNSDictionary, key]]]];
}

+ (NSDictionary *)getNSDictionaryFromDocumentsWithKey:(NSString *)key {
    if ( key == nil ) {
        return nil;
    }
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[self getDocumentsPath:[NSString stringWithFormat:@"%@%@", kDefaultDocumentsStorePathOfNSDictionary, key]]];
    return dic;
}

+ (NSString *)getLocalizedStringFromTableInBundle:(NSString *)bundleName key:(NSString *)key{
    NSBundle *bundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle" , bundleName]]];
    if (!bundle) {
        bundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundleName]];
    }
    if (bundle) {
        NSString *value = NSLocalizedStringFromTableInBundle(key, @"Localizable", bundle, nil);
        if (value) {
            return value;
        }
    }
    return key;
}

@end
