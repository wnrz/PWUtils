//
//  BaseTool.h
//  FAFViewTest
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define GWLocalizedString(bundleName , keyString) ([FileTool getLocalizedStringFromTableInBundle:bundleName key:keyString])

@interface FileTool : NSObject

#pragma mark - Documents
// Documents
+ (BOOL)storeToDocuments:(id)object withPath:(NSString *)path;
+ (BOOL)clearFileInDocuments:(NSString *)path;
+ (NSString *)getDocumentsPath:(NSString *)fileName;

#pragma mark - Tmp
// Tmp
+ (BOOL)storeToTmp:(id)object withPath:(NSString *)path;
+ (BOOL)clearFileInTmp:(NSString *)path;
+ (NSString *)getTmpPath:(NSString *)fileName;

#pragma mark - Library
// Library
+ (BOOL)storeToLibrary:(id)object withPath:(NSString *)path;
+ (BOOL)clearFileInLibrary:(NSString *)path;
+ (NSString *)getLibraryPath:(NSString *)fileName;

#pragma mark - Caches
// Caches
+ (BOOL)storeToCaches:(id)object withPath:(NSString *)path;
+ (BOOL)clearFileInCaches:(NSString *)path;
+ (NSString *)getCachesPath:(NSString *)fileName;

/** Operation With Key, For Use Easy **/

#pragma mark - Store String To Document With Key
+ (BOOL)storeStringToDocuments:(NSString *)str withPath:(NSString *)path withKey:(NSString *)key;
+ (NSString *)getStringFromDocumentsWithPath:(NSString *)path withKey:(NSString *)key;
+ (BOOL)storeStringToDocuments:(NSString *)str withKey:(NSString *)key;
+ (NSString *)getStringFromDocumentsWithKey:(NSString *)key;

#pragma mark - Store NSData To Document With Key
+ (BOOL)storeNSDataToDocuments:(NSData *)data withKey:(NSString *)key;
+ (NSData *)getNSDataFromDocumentsWithKey:(NSString *)key;

#pragma mark - Store NSDictionary To Document With Key
+ (BOOL)storeNSDictionaryToDocuments:(NSDictionary *)dic withKey:(NSString *)key;
+ (NSDictionary *)getNSDictionaryFromDocumentsWithKey:(NSString *)key;

//+ (BOOL)storeBaseModelToDocuments:(BaseModel *)upModel withPath:(NSString *)path;

+ (NSString *)getLocalizedStringFromTableInBundle:(NSString *)bundleName key:(NSString *)key;
@end
