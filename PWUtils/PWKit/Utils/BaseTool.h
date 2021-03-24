//
//  BaseTool.h
//  FAFViewTest
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseColors.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "PWUIKitTool.h"
#import "FileTool.h"
#import "CommonMacro.h"

typedef enum :NSInteger {
    kCameraMoveDirectionNone,
    kCameraMoveDirectionUp,
    kCameraMoveDirectionDown,
    kCameraMoveDirectionRight,
    kCameraMoveDirectionLeft
} CameraMoveDirection;

@interface BaseTool : NSObject


float EMA(float x, float ema, int n);
float SMA(float x, float sma, int n, int m);
float WMA(NSArray *arr, int idx, int n);
float MA(NSArray *arr, int idx, int n);
float SUM(NSArray *arr, int idx, int n);
float HHV(NSArray *arr, int idx, int n);
float LLV(NSArray *arr, int idx, int n);
float REF(NSArray *arr, int idx, int n);
int EXIST(NSArray *arr, int idx, int n);
int CROSS(NSArray *arr1, NSArray *arr2, int idx);
int COUNT(NSArray *arr, int idx, int n);
int BARSLAST(NSArray *arr, int idx);
int PEAKBARS(NSArray *arr, int idx, int n);
float IFF(BOOL c, float v1, float v2);
NSArray *TFILTER(NSArray *arr1, NSArray *arr2);
NSDictionary *ZIG(NSArray *arr, float r);


// tool funtion
float valid(float value);

// string funtion
NSString *unit(float num);

// specify function

/**
 * sizeWithContent:font:width:
 *
 * 计算content的size
 */
+ (CGSize)sizeWithContent:(NSString *)content font:(UIFont *)font width:(CGFloat)width ;
+ (CGSize)sizeWithContent:(NSString *)content options:(NSStringDrawingOptions)options attributes:(NSDictionary *)attributes width:(CGFloat)width ;
+ (CGFloat)contentHeight:(NSDictionary *)dic isFold:(BOOL)isFold;

+ (float)getMaxDiff:(NSArray *)array perClose:(float)perClose;

+ (NSString *)getDataBasePath;

NSString* PathForBundleResource(NSString* relativePath);
NSString* PathForDocumentsResource(NSString* relativePath);
NSString* DirectoryForDocumentsResource(NSString* DirectoryName);
NSString* PathForDocumentsAppResource(NSString* relativePath);
BOOL PathCheckFileExit(NSString *path,BOOL * isDirectory);

NSString *TpflagString(NSInteger tpflag, NSString *string);
NSString *StringWithTpflag(double p , NSInteger tpflag , NSString *string);

+ (void)useConstraint:(NSArray *)constraints fromView:(UIView *)view;//根据版本号设置约束
+ (NSString*)randomStringWithLength:(NSInteger)length;//随机数生成
+ (NSString *)firstCharactor:(NSString *)aString;//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)

#pragma mark - Date
+ (NSString *)currentDate:(NSString *)dateFormatter;
+ (int)currentYear;
+ (int)currentMonth;
+ (int)currentDay;
+ (int)currentHour;
+ (int)currentMinute;
+ (int)currentSecond;
+ (NSString *)nowDateStr;
+ (NSString *)dateStrFrom1990;

/**
 * dateFromDate:interval:
 *
 * 获取与date间隔某段时间的日期
 *
 * @Parameters:
 *          date - 原日期
 *          day  - 间隔天数
 */
+ (NSString *)dayFromDate:(NSString *)data format:(NSString *)format;
+ (NSString *)yearFromDate:(NSString *)data format:(NSString *)format;
+ (NSString *)dateFromDate:(NSDate *)date interval:(int)day withDateFormatter:(NSString *)df;
+ (NSDate *)string2Date:(NSString *)dateStr withDateFormatter:(NSString *)df;
+ (NSTimeInterval)standardTime2TimeStamp:(NSString *)standardTime;
+ (NSTimeInterval)standardTime2TimeStamp:(NSString *)standardTime withDateFormatter:(NSString *)df;
+ (NSString *)timeStamp2StandardTime:(NSTimeInterval)timeStamp dateFormat:(NSString *)dateFormat;
+ (NSString *)timeIntervalSinceDate:(NSString *)data format:(NSString *)format;

/**
 * stringStamp2Date:
 *
 * 时间戳转为标准时间
 */
+ (NSString *)stringStamp2Date:(NSString *)dateStr;
+ (NSString *)stringStamp2Date:(NSString *)dateStr format:(NSString *)format;
+ (NSString *)stringStamp2UTCDate:(NSString *)timesp format:(NSString *)format;
+ (NSString *)stringStamp2UTCDate:(NSString *)timesp format:(NSString *)format gmt:(float)gmt;
+ (NSString *)stringStamp2Time:(NSString *)dateStr;
+ (NSString *)stringStamp2Time:(NSString *)dateStr gmt:(int)gmt;

/**
 * date2StringStamp:
 *
 * 标准时间转为时间戳
 */
+ (NSString *)date2StringStamp:(NSString *)dateStr format:(NSString *)format;
/**
 * standardDate2MYDate:
 *
 * 将标准时间转为客户端需要的形式：不是当天的就显示日期（mm-dd），当天的则显示时间（hh-mm）
 */
+ (NSString *)standardDate2MYDate:(NSString *)string;
+ (NSString *)standardDate2MYDate2:(NSString *)string;

//时间格式转换成秒 HH:mm->mm
+ (NSString *)timeToMinute:(NSString *)time;

+(NSString*)hiddenMyInfoWithInfo:(NSString*)infoText tag:(NSInteger)tag;//隐藏信息

/*
 * 1-当天显示：HH: MM
 * 2-昨天显示：昨天 HH: MM
 * 3-近一周显示(不包含昨天)：星期* HH: MM
 * 4-一周之前显示：YYYY年MM月DD日 HH: MM
 */
+ (NSString *)standardDate2MYDate3:(NSString *)dateStr;

#pragma mark - deviceString
+ (NSString *)deviceString;
+ (NSString *)detailDeviceString;
+ (BOOL)isIPhone6;
+ (BOOL)isIPhone6Plus;

#pragma mark - setWebKitCacheModel
+ (void)setWebKitCacheModel;

#pragma mark - appVersion
+ (NSString *)appVersion;

#pragma mark - appName
+ (NSString *)appName;

#pragma mark - convertViewToImage
+ (UIImage *)snapshot;

#pragma mark - 跳转iTunes
+ (void)toItunes;

#pragma mark - getColorWithHexColor
+ (UIColor *) getColorWithHexColor:(NSString *)hexColor;

#pragma mark - setCodeFromStr
+ (NSString *)setCodeFromStr:(NSString *)str;

#pragma mark - 获取类名与类型
+ (NSDictionary *)classPropsFor:(Class)klass;
static const char *getPropertyType(objc_property_t property);

//KeyValues
+(id)analysisDatawithmodelClass:(Class)obj AndDic:(NSDictionary *)dic;
+(NSArray *)analysisDatawithmodelClass:(Class)obj AndArr:(NSArray *)arr;

// 设置不同步到iCloud
+ (BOOL)addSkipBackupAttributeToItemAtDocumentsDirectory:(NSString *)documentsDirectory;

+ (NSString *)getDocumentsPath:(NSString *)fileName;



//根据位数返回带单位字符串
+ (NSString *)convertLongToNSString:(long long)l;
+ (NSString *)convertLongToNSString:(long long)l pointNum:(int)point;
+ (NSString *)convertFloatToNSString:(double)f pointNum:(int)point;
+ (NSString *)newFloat:(double)value withNumber:(int)numberOfPlace;
+ (NSString *)newFloat:(double)value withNumber:(int)numberOfPlace setcode:(int)setcode;

+ (void)anotherToast:(UIView *)view message:(NSString *)msg;
+ (void)anotherHideToast:(UIView *)view;
+ (void)showLoadingHud:(UIView *)view;
+ (void)hideLoadingHud:(UIView *)view;


+(NSData *) LongToNSData:(long long)data;
+(uint32_t) NSDataToUInt:(NSData *)data;
+(short) NSDataToShort:(NSData *)data;
+ (NSData *)IntArrayToData:(NSArray *)arr pyl:(int)pyl;
+(NSData *) hexStrToNSData:(NSString *)data withSize:(NSInteger)size;
+(NSData *) hexStrToNSData:(NSString *)hexStr;
+(NSString *) NSDataToHexString:(NSData *)data;

//记录当天是否进行过操作的标记  -1 参数非法 0未记录 1已记录
+ (int)checkTodayHasRecord:(NSString *)key tag:(NSString *)tag;
+ (int)checkHasRecord:(NSString *)key tag:(NSString *)tag isToday:(BOOL)isToday;
+ (void)clearRecord:(NSString *)key;
+(UIImage *)imageWithColorUIImage:(UIImage *)img UIColor:(UIColor *)color;
+ (long long)getVersionFrom:(NSString *)string;
+ (void)buttonImageToRight:(UIButton *)button;

+ (UINavigationController *)getNav;
+ (UIViewController*)topPresentedViewController;

+ (NSAttributedString *)getBigAndSmallString:(NSString *)string font:(UIFont *)font zoom:(NSString*)zoome bigSize:(float)bigSize smallSize:(float)smallSize smallToBig:(BOOL)smallToBig BaselineOffset:(float)BaselineOffset;

+ (NSString *)uuidString;
//数字转汉字
+ (NSString *)getAmountInWords:(NSString *)money;
+ (NSString *)MD5Digest:(NSString *)string;

+ (CALayer *)flashPointLayer:(UIColor *)color centerWidth:(CGFloat)centerWidth spreadWidth:(CGFloat)spreadWidth frame:(CGRect)frame;
@end
