//
//  BaseTool.m
//  FAFViewTest
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseTool.h"
#import "sys/utsname.h"
#import <MJExtension/MJExtension.h>
#import "MBProgressHUD.h"
#import "Fonts.h"
#import <CommonCrypto/CommonDigest.h>

// 1万
#define TEN_THOUSAND  10000
// 1亿
#define A_THOUSAND_MILLION  100000000
// 1万亿
#define A_MILLION_MILLION  1000000000000

@implementation BaseTool

// common function
float EMA(float x, float ema, int n) {
    return (2 * x + (n - 1) * ema) / (n + 1);
}

float SMA(float x, float sma, int n, int m) {
    return (x * m + sma * (n - m)) / n;
}

float WMA(NSArray *arr, int idx, int n) {
    float v1 = 0;
    float v2 = 0;
    
    int start = idx - n + 1;
    if (start < 0) {
        start = 0;
    }
    
    for (int i = idx; i >= start; i--) {
        v1 += (n - (idx - i)) * [[arr objectAtIndex:i] doubleValue];
        v2 += (n - (idx - i));
    }
    
    return v1 / v2;
}

float MA(NSArray *arr, int idx, int n) {
    float v = 0;
    
    int start = idx - n + 1;
    if (start < 0) {
        start = 0;
    }
    
    for (int i = start; i <= idx; i++) {
        v += [[arr objectAtIndex:i] doubleValue];
    }
    
    return v / (idx - start + 1);
}

float SUM(NSArray *arr, int idx, int n) {
    float v = 0;
    
    int start = idx - n + 1;
    if (n == 0 || start < 0) {
        start = 0;
    }
    
    for (int i = start; i <= idx; i++) {
        v += [[arr objectAtIndex:i] doubleValue];
    }
    
    return v;
}

float HHV(NSArray *arr, int idx, int n) {
    float hhv = -1;
    
    int start = idx - n + 1;
    if (start < 0) {
        start = 0;
    }
    
    for (int i = start; i <= idx; i++) {
        float v = [[arr objectAtIndex:i] doubleValue];
        
        if (i == start) {
            hhv = v;
        }
        
        if (v > hhv) {
            hhv = v;
        }
    }
    
    return hhv;
}

float LLV(NSArray *arr, int idx, int n) {
    float llv = -1;
    
    int start = idx - n + 1;
    if (start < 0) {
        start = 0;
    }
    
    for (int i = start; i <= idx; i++) {
        float v = [[arr objectAtIndex:i] doubleValue];
        
        if (i == start) {
            llv = v;
        }
        
        if (v < llv) {
            llv = v;
        }
    }
    
    return llv;
}

float REF(NSArray *arr, int idx, int n) {
    if (arr.count == 0) {
        return 0;
    }
    
    int start = idx - n;
    if (start < 0) {
        return 0;
    }
    
    return [[arr objectAtIndex:start] doubleValue];
}

int EXIST(NSArray *arr, int idx, int n) {
    if (arr.count == 0) {
        return 0;
    }
    
    int start = idx - n + 1;
    if (start < 0) {
        start = 0;
    }
    
    for (int i = start; i <= idx; i++) {
        if ([[arr objectAtIndex:i] boolValue]) {
            return 1;
        }
    }
    
    return 0;
}

int CROSS(NSArray *arr1, NSArray *arr2, int idx) {
    if (idx == 0 || arr1.count == 0 || arr2.count == 0 || arr1.count != arr2.count) {
        return 0;
    }
    
    float v1_l = [[arr1 objectAtIndex:idx - 1] doubleValue];
    float v2_l = [[arr2 objectAtIndex:idx - 1] doubleValue];
    float v1 = [[arr1 objectAtIndex:idx] doubleValue];
    float v2 = [[arr2 objectAtIndex:idx] doubleValue];
    
    if (v1_l < v2_l && v1 >= v2) {
        return 1;
    }
    
    return 0;
}

int COUNT(NSArray *arr, int idx, int n) {
    if (arr.count == 0) {
        return 0;
    }
    
    int count = 0;
    
    int start = idx - n + 1;
    if (start < 0) {
        start = 0;
    }
    
    for (int i = start; i <= idx; i++) {
        if ([[arr objectAtIndex:i] boolValue]) {
            count++;
        }
    }
    
    return count;
}

int BARSLAST(NSArray *arr, int idx) {
    if (arr.count <= 1) {
        return 0;
    }
    
    int ret = 1;
    
    for (int i = (int)arr.count - 2; i >= 0; i--, ret++) {
        if ([[arr objectAtIndex:i] intValue] != 0) {
            break;
        }
    }
    
    return ret;
}

int PEAKBARS(NSArray *arr, int idx, int n) {
    for (int i = (int)arr.count - 1; i >= 0; i--) {
        int index = [[arr objectAtIndex:i] intValue];
        if (index < idx) {
            if (i - n - 1 >= 0) {
                return idx - [[arr objectAtIndex:i - n - 1] intValue];
            } else {
                return -1;
            }
        }
    }
    return -1;
}

float IFF(BOOL c, float v1, float v2) {
    return c ? v1 : v2;
}

NSArray *TFILTER(NSArray *arr1, NSArray *arr2) {
    if (arr1.count == 0 || arr2.count == 0 || arr1.count != arr2.count) {
        return nil;
    }
    
    NSMutableArray *arr_ret = [[NSMutableArray alloc] initWithCapacity:0];
    
    int p1 = -1;
    int p2 = -1;
    for (int i = 0; i < arr1.count; i++) {
        BOOL v1 = [[arr1 objectAtIndex:i] boolValue];
        BOOL v2 = false;//[[arr2 objectAtIndex:i] boolValue];
        
        if (v1) {
            p1 = i;
            while (i < arr1.count - 1) {
                i++;
                v2 = [[arr2 objectAtIndex:i] boolValue];
                if (v2) {
                    p2 = i;
                    [arr_ret addObject:@{ @"s" : [NSNumber numberWithInt:p1], @"e" : [NSNumber numberWithInt:p2] }];
                    break;
                }
            }
            if (p1 < i) {
                [arr_ret addObject:@{ @"s" : [NSNumber numberWithInt:p1] }];
            }
        }
    }
    
    return arr_ret;
}

NSDictionary *ZIG(NSArray *arr, float r) {
    if (arr.count == 0) {
        return nil;
    }
    
    NSMutableArray *arr_top = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *arr_bottom = [[NSMutableArray alloc] initWithCapacity:0];
    
    float vl = [[arr objectAtIndex:0] doubleValue];
    for (int i = 1; i < arr.count - 1; i++) {
        float v = [[arr objectAtIndex:i] doubleValue];
        // 找到第一个差距点
        if (ABS((v - vl) / vl) >= r) {
            int d = 0;
            // 判断上折还是下折
            if (v > vl) {
                d = 1;
            } else {
                d = -1;
            }
            vl = v;
            
            while (i < arr.count - 1) {
                if (d == 1) { // 上折算法
                    v = [[arr objectAtIndex:i] doubleValue];
                    float v_min = v;
                    int i_min = i;
                    while (i < arr.count - 1) {
                        i++;
                        v = [[arr objectAtIndex:i] doubleValue];
                        if (v < v_min) {
                            v_min = v;
                            i_min = i;
                        }
                        if (v > vl) {
                            if ((vl - v_min) / vl >= r) {
                                d = -1;
                                [arr_top addObject:[NSNumber numberWithInt:i]];
                                [arr_bottom addObject:[NSNumber numberWithInt:i_min]];
                                break;
                            }
                            vl = v;
                        }
                    }
                } else if (d == -1) { // 下折算法
                    v = [[arr objectAtIndex:i] doubleValue];
                    float v_max = v;
                    int i_max = i;
                    while (i < arr.count - 1) {
                        i++;
                        v = [[arr objectAtIndex:i] doubleValue];
                        if (v > v_max) {
                            v_max = v;
                            i_max = i;
                        }
                        if (v < vl) {
                            if ((v_max - vl) / vl >= r) {
                                d = 1;
                                [arr_top addObject:[NSNumber numberWithInt:i]];
                                [arr_bottom addObject:[NSNumber numberWithInt:i_max]];
                                break;
                            }
                            vl = v;
                        }
                    }
                }
            }
        }
    }
    
    return @{ @"top" : arr_top, @"bottom" : arr_bottom };
}

// tool funtion
float valid(float value) {
    return isnan(value) || isinf(value) ? 0 : value;
}

// string funtion
NSString *unit(float num) {
    if (fabs(num) > 100000000) {
        return [NSString stringWithFormat:@"%.2f亿", round(num / 1000000) / 100];
    } else if (fabs(num) > 10000) {
        return [NSString stringWithFormat:@"%.2f万", round(num / 100) / 100];
    } else {
        return [NSString stringWithFormat:@"%.2f", round(num)];
    }
}

// specify function


/**
 * sizeWithContent:font:width:
 *
 * 计算content的size
 */
+ (CGSize)sizeWithContent:(NSString *)content font:(UIFont *)font width:(CGFloat)width {
    if ( IsValidateString(content) && font && width > 0 ) {
        CGRect rect = [content boundingRectWithSize:CGSizeMake(width, 10000.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : font } context:nil];
        return rect.size;
    }
    return CGSizeMake(0, 0);
}

+ (CGSize)sizeWithContent:(NSString *)content options:(NSStringDrawingOptions)options attributes:(NSDictionary *)attributes width:(CGFloat)width {
    if ( IsValidateString(content) && width > 0 ) {
        CGRect rect = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:options attributes:attributes context:nil];
        return rect.size;
    }
    return CGSizeMake(0, 0);
}

+ (CGFloat)contentHeight:(NSDictionary *)dic isFold:(BOOL)isFold {
    if ( IsValidateDic(dic) ) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [[Fonts shareFonts] font16];
        label.numberOfLines = 0;
        label.attributedText = [self newsContent:dic];
        
        CGSize size = CGSizeMake((kScreenWidth - 80), 500000);
        CGSize labelSize = [label sizeThatFits:size];
        CGFloat contentHeight = labelSize.height;
        CGFloat baseHeight = 25;
        NSInteger factor = contentHeight/baseHeight;
        contentHeight = baseHeight * (factor + 1);
        if ( !isFold ) {        // 未展开
            if ( contentHeight > baseHeight * 5 ) {
                contentHeight = baseHeight * 5;
            }
        }
        label = nil;
        return contentHeight;
        
    }
    return 0;
}

+ (float)getMaxDiff:(NSArray *)array perClose:(float)perClose{
    float maxDiff = 0;
    if (IsValidateArr(array)) {
        for (int i = 0 ; i < array.count ; i++) {
            float value = [array[i] doubleValue];
            if (maxDiff < fabs(value - perClose)) {
                maxDiff = fabs(value - perClose);
            }
        }
    }
    return maxDiff;
}

+ (NSString *)getDataBasePath{
    NSString *dbPath = PathForDocumentsAppResource(StockDBFileName);
    
    return dbPath;
}

NSString* PathForBundleResource(NSString* relativePath) {
    NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
    return [resourcePath stringByAppendingPathComponent:relativePath];
}

NSString* PathForDocumentsResource(NSString* relativePath) {
    static NSString* documentsPath = nil;
    if (!documentsPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        if(dirs == nil || [dirs count] == 0)
        {
            dirs = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            if([dirs count] > 0)
            {
                NSString *path = [dirs objectAtIndex:0];
                path = [path stringByDeletingLastPathComponent];
                path = [path stringByAppendingPathComponent:@"Documents"];
                NSFileManager *filemanager = [NSFileManager defaultManager];
                if([filemanager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil])
                {
                    documentsPath = path;
                }
            }
        }
        else {
            documentsPath = [dirs objectAtIndex:0] ;
        }
    }
    return [documentsPath stringByAppendingPathComponent:relativePath];
}

NSString* DirectoryForDocumentsResource(NSString* DirectoryName)
{
    NSString *path = PathForDocumentsResource(DirectoryName);
    NSFileManager *filemanager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL isExit = [filemanager fileExistsAtPath:path isDirectory:&isDirectory];
    if( !isExit || !isDirectory)
    {
        if([filemanager createDirectoryAtPath:path
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:nil])
        {
            return path;
        }
    }
    return path;
}

NSString* PathForDocumentsAppResource(NSString* relativePath)
{
    NSString *path = DirectoryForDocumentsResource([[NSBundle mainBundle]bundleIdentifier]);
    return [path stringByAppendingPathComponent:relativePath];
}

BOOL PathCheckFileExit(NSString *path,BOOL * isDirectory)
{
    NSFileManager *filemanager = [NSFileManager defaultManager];
    BOOL isExit = [filemanager fileExistsAtPath:path isDirectory:isDirectory];
    return isExit;
}

NSString *TpflagString(NSInteger tpflag , NSString *string){
    if (tpflag < 0) {
        tpflag = 2;
    }
    NSString *s = [NSString stringWithFormat:@"%%.%lif" , tpflag];
    if (IsValidateString(string)) {
        s = [NSString stringWithFormat:s , [string doubleValue]];
    }else{
        s = [NSString stringWithFormat:s , 0];
    }
    return s;
}

NSString *StringWithTpflag(double p , NSInteger tpflag , NSString *string){
    NSString *s = [NSString stringWithFormat:TpflagString(tpflag, nil) , p];
    if (IsValidateString(string)) {
        s = [s stringByAppendingString:string];
    }
    return s;
}

+ (void)useConstraint:(NSArray *)constraints fromView:(UIView *)view{
    if (iOS8OrLater) {
        [NSLayoutConstraint activateConstraints:constraints];
        for (int i = 0 ; i < constraints.count ; i++) {
            NSLayoutConstraint *constraint = [constraints objectAtIndex:i];
            constraint.active = YES;
        }
    }else{
        [view addConstraints:constraints];
    }
}

//随机数生成
+(NSString*)randomStringWithLength:(NSInteger)length
{
    NSString * random = @"";
    
    NSArray * array = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    
    for (int i=0; i<length; i++)
    {
        NSInteger row = arc4random()%10;
        random = [random stringByAppendingString:array[row]];
    }
    
    return random;
    
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    NSArray *a = [pinYin componentsSeparatedByString:@" "];
    if (IsValidateArr(a)) {
        NSString *s = @"";
        for (int i = 0; i < a.count; i++) {
            NSString *p = [a objectAtIndex:i];
            if (IsValidateString(p)) {
                s = [s stringByAppendingString:[p substringToIndex:1]];
            }
        }
        return s;
    }
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

#pragma mark - Date

+ (NSString *)currentDate:(NSString *)dateFormatter {
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    if ( nil == dateFormatter ) {
        dateFormatter = @"yyyy-MM-dd";
    }
    [dateformatter setDateFormat:dateFormatter];
    NSString *locationString = [dateformatter stringFromDate:senddate];
    return locationString;
}

+ (int)currentYear {
    NSString *date = [self currentDate:nil];
    if ( IsValidateString(date) ) {
        NSArray *components = [date componentsSeparatedByString:@"-"];
        if ( IsValidateArr(components) && 3 == components.count ) {
            return [[NSString stringWithFormat:@"%@", components[0]] intValue];
        }
    }
    return 0;
}

+ (int)currentMonth {
    NSString *date = [self currentDate:nil];
    if ( IsValidateString(date) ) {
        NSArray *components = [date componentsSeparatedByString:@"-"];
        if ( IsValidateArr(components) && 3 == components.count ) {
            return [[NSString stringWithFormat:@"%@", components[1]] intValue];
        }
    }
    return 0;
}

+ (int)currentDay {
    NSString *date = [self currentDate:nil];
    if ( IsValidateString(date) ) {
        NSArray *components = [date componentsSeparatedByString:@"-"];
        if ( IsValidateArr(components) && 3 == components.count ) {
            return [[NSString stringWithFormat:@"%@", components[2]] intValue];
        }
    }
    return 0;
}

+ (int)currentHour {
    NSString *time = [self currentDate:@"HH:mm:ss"];
    if ( IsValidateString(time) ) {
        NSArray *components = [time componentsSeparatedByString:@":"];
        if ( IsValidateArr(components) && 3 == components.count ) {
            return [[NSString stringWithFormat:@"%@", components[0]] intValue];
        }
    }
    return 0;
}

+ (int)currentMinute {
    NSString *time = [self currentDate:@"HH:mm:ss"];
    if ( IsValidateString(time) ) {
        NSArray *components = [time componentsSeparatedByString:@":"];
        if ( IsValidateArr(components) && 3 == components.count ) {
            return [[NSString stringWithFormat:@"%@", components[1]] intValue];
        }
    }
    return 0;
}

+ (int)currentSecond {
    NSString *time = [self currentDate:@"HH:mm:ss"];
    if ( IsValidateString(time) ) {
        NSArray *components = [time componentsSeparatedByString:@":"];
        if ( IsValidateArr(components) && 3 == components.count ) {
            return [[NSString stringWithFormat:@"%@", components[2]] intValue];
        }
    }
    return 0;
}

+ (NSString *)nowDateStr {
    NSString *date = [self currentDate:nil];
    if ( IsValidateString(date) ) {
        NSArray *components = [date componentsSeparatedByString:@"-"];
        if ( IsValidateArr(components) && 3 == components.count ) {
            int year = [[NSString stringWithFormat:@"%@", components[0]] intValue];
            int month = [[NSString stringWithFormat:@"%@", components[1]] intValue];
            int day = [[NSString stringWithFormat:@"%@", components[2]] intValue];
            return [NSString stringWithFormat:@"%i%02i%02i", year, month, day];
        }
    }
    return EmptyString;
}

+ (NSString *)dateStrFrom1990 {
    NSString *date = [self currentDate:nil];
    if ( IsValidateString(date) ) {
        NSArray *components = [date componentsSeparatedByString:@"-"];
        if ( IsValidateArr(components) && 3 == components.count ) {
            int year = [[NSString stringWithFormat:@"%@", components[0]] intValue];
            int month = [[NSString stringWithFormat:@"%@", components[1]] intValue];
            int day = [[NSString stringWithFormat:@"%@", components[2]] intValue];
            return [NSString stringWithFormat:@"%i%02i%02i", year - 1990, month, day];
        }
    }
    return EmptyString;
}

/**
 * dateFromDate:interval:
 *
 * 获取与date间隔某段时间的日期
 *
 * @Parameters:
 *          date - 原日期
 *          day  - 间隔天数
 */
+ (NSString *)dateFromDate:(NSDate *)date interval:(int)day withDateFormatter:(NSString *)df {
    NSDate * tempDate = [NSDate dateWithTimeInterval:24 * 60 * 60 * day sinceDate:date];
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    if ( nil == df ) {
        [dateformatter setDateFormat:@"yyyy-MM-dd"];
    } else {
        [dateformatter setDateFormat:df];
    }
    NSString *locationString = [dateformatter stringFromDate:tempDate];
    return locationString;
}

+ (NSDate *)string2Date:(NSString *)dateStr withDateFormatter:(NSString *)df {
    if ( !dateStr ) {
        return [NSDate date];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ( nil == df ) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else {
        [dateFormatter setDateFormat:df];
    }
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

+ (NSTimeInterval)standardTime2TimeStamp:(NSString *)standardTime {
    if ( standardTime ) {
        NSDate *datenow = [self string2Date:standardTime withDateFormatter:nil];
        return [datenow timeIntervalSince1970];
    }
    return 0;
}

+ (NSTimeInterval)standardTime2TimeStamp:(NSString *)standardTime withDateFormatter:(NSString *)df {
    if ( standardTime ) {
        NSDate *datenow = [self string2Date:standardTime withDateFormatter:df];
        return [datenow timeIntervalSince1970];
    }
    return 0;
}

+ (NSString *)timeStamp2StandardTime:(NSTimeInterval)timeStamp dateFormat:(NSString *)dateFormat {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp > powl(10, 10) ? timeStamp/1000 : timeStamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ( dateFormat ) {
        [dateFormatter setDateFormat:dateFormat];
    } else {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    NSString *standardTime = [dateFormatter stringFromDate:date];
    return standardTime;
}

+ (NSString *)timeIntervalSinceDate:(NSString *)data format:(NSString *)format{
    NSString *string;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *timeDate = [dateFormatter dateFromString:data];//model.created_at 时间
    //八小时时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:timeDate];
    NSDate *mydate = [timeDate dateByAddingTimeInterval:interval];
    NSDate *nowDate = [[NSDate date]dateByAddingTimeInterval:interval];
    //两个时间间隔
    NSTimeInterval timeInterval = [mydate timeIntervalSinceDate:nowDate];
    long temp = 0;
    //    NSString *time;
    if (timeInterval < 0) {
        timeInterval = -timeInterval;
        if (timeInterval<60) {
            string = [NSString stringWithFormat:@"刚刚"];
        }else if ((temp = timeInterval/60)<60){
            string = [NSString stringWithFormat:@"%ld分钟前",temp];
        }else if ((temp = timeInterval/(60*60))<24){
            string = [NSString stringWithFormat:@"%ld小时前",temp];
        }else if((temp = timeInterval/(24*60*60))<30){
            string = [NSString stringWithFormat:@"%ld天前",temp];
        }else if (((temp = timeInterval/(24*60*60*30)))<12){
            string = [NSString stringWithFormat:@"%ld月前",temp];
        }else {
            temp = timeInterval/(24*60*60*30*12);
            string = [NSString stringWithFormat:@"%ld年前",temp];
        }
    }else{
        if (timeInterval<60) {
            string = [NSString stringWithFormat:@"马上"];
        }else if ((temp = timeInterval/60)<60){
            string = [NSString stringWithFormat:@"%ld分钟后",temp];
        }else if ((temp = timeInterval/(60*60))<24){
            string = [NSString stringWithFormat:@"%ld小时后",temp];
        }else if((temp = timeInterval/(24*60*60))<30){
            string = [NSString stringWithFormat:@"%ld天后",temp];
        }else if (((temp = timeInterval/(24*60*60*30)))<12){
            string = [NSString stringWithFormat:@"%ld月后",temp];
        }else {
            temp = timeInterval/(24*60*60*30*12);
            string = [NSString stringWithFormat:@"%ld年后",temp];
        }
    }
    return string;
}
+ (NSString *)dayFromDate:(NSString *)data format:(NSString *)format{
    NSString *string;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *timeDate = [dateFormatter dateFromString:data];//model.created_at 时间
    //八小时时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:timeDate];
    NSDate *mydate = [timeDate dateByAddingTimeInterval:interval];
    NSDate *nowDate = [[NSDate date]dateByAddingTimeInterval:interval];
    //两个时间间隔
    NSTimeInterval timeInterval = [mydate timeIntervalSinceDate:nowDate];
    
    NSString *qh;
    qh = @"后";
    if (timeInterval < 0) {
        timeInterval = - timeInterval;
        qh = @"前";
        
    }else{
        
    }
    int y = timeInterval/(24*60*60*30*12);
    int m = (timeInterval-(y*12*24*30*60*60))/(24*60*60*30);
//    int d = (timeInterval-(m*24*30*60*60)-(y*12*24*30*60*60))/(24*60*60);
    int d = (timeInterval)/(24*60*60);
    int h = (timeInterval-(m*24*30*60*60)-(y*12*24*30*60*60)-(d*24*60*60))/(60*60);
    int mm = (timeInterval-(m*24*30*60*60)-(y*12*24*30*60*60)-(d*24*60*60)-h*60*60)/60;
    int s = (int)timeInterval%60;
    string = @"";
    //    [NSString stringWithFormat:@"%d%d%d%d%d%d后",y,m,d,h,mm,s];
    NSArray *arrayU = @[@"日",@"时",@"分",@"秒"];//@"年" ,@"月",
    NSArray *arrayN = @[@(d),@(h),@(mm),@(s)];//@(y) ,@(m),
    for (int i = 0; i < arrayU.count; i++) {
        int num = [[arrayN objectAtIndex:i] intValue];
        NSString *unit = [arrayU objectAtIndex:i];
//        if (num != 0 || string.length > 0) {
            string = [string stringByAppendingFormat:@"%02i%@",num,unit];
//        }
    }
    string = [string stringByAppendingString:qh];
    return string;
}

+ (NSString *)yearFromDate:(NSString *)data format:(NSString *)format{
    NSString *string;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *timeDate = [dateFormatter dateFromString:data];//model.created_at 时间
    //八小时时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:timeDate];
    NSDate *mydate = [timeDate dateByAddingTimeInterval:interval];
    NSDate *nowDate = [[NSDate date]dateByAddingTimeInterval:interval];
    //两个时间间隔
    NSTimeInterval timeInterval = [mydate timeIntervalSinceDate:nowDate];
    
    NSString *qh;
    qh = @"后";
    if (timeInterval < 0) {
        timeInterval = - timeInterval;
        qh = @"前";

    }else{
    
    }
    int y = timeInterval/(24*60*60*30*12);
    int m = (timeInterval-(y*12*24*30*60*60))/(24*60*60*30);
    int d = (timeInterval-(m*24*30*60*60)-(y*12*24*30*60*60))/(24*60*60);
    int h = (timeInterval-(m*24*30*60*60)-(y*12*24*30*60*60)-(d*24*60*60))/(60*60);
    int mm = (timeInterval-(m*24*30*60*60)-(y*12*24*30*60*60)-(d*24*60*60)-h*60*60)/60;
    int s = (int)timeInterval%60;
    string = @"";
//    [NSString stringWithFormat:@"%d%d%d%d%d%d后",y,m,d,h,mm,s];
    NSArray *arrayU = @[@"年" ,@"月",@"日",@"时",@"分",@"秒"];
    NSArray *arrayN = @[@(y) ,@(m),@(d),@(h),@(mm),@(s)];
    for (int i = 0; i < arrayU.count; i++) {
        int num = [[arrayN objectAtIndex:i] intValue];
        NSString *unit = [arrayU objectAtIndex:i];
//        if (num != 0 || string.length > 0) {
            string = [string stringByAppendingFormat:@"%02i%@",num,unit];
//        }
    }
    string = [string stringByAppendingString:qh];
    return string;
}

/**
 * stringStamp2Date:
 *
 * 时间戳转为标准时间
 */
+ (NSString *)stringStamp2Date:(NSString *)dateStr {
    if ( !dateStr ) {
        return @"";
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateStr.longLongValue > powl(10, 10) ? dateStr.longLongValue/1000 : dateStr.longLongValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *locationString = [dateFormatter stringFromDate:confromTimesp];
    return locationString;
}

+ (NSString *)stringStamp2Date:(NSString *)dateStr format:(NSString *)format{
    if ( !dateStr ) {
        return @"";
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateStr.longLongValue > powl(10, 10) ? dateStr.longLongValue/1000 : dateStr.longLongValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *locationString = [dateFormatter stringFromDate:confromTimesp];
    return locationString;
}

//时间戳字符串1469193006001（毫秒）1469193006.001（毫秒，1469193006001234（微秒）1469193006.001234（微秒）转 UTC时间2016-08-11T07:00:55.611Z
+ (NSString *)stringStamp2UTCDate:(NSString *)timesp format:(NSString *)format
{
    return [BaseTool stringStamp2UTCDate:timesp format:format gmt:0];
}

+ (NSString *)stringStamp2UTCDate:(NSString *)timesp format:(NSString *)format gmt:(float)gmt
{
    NSString *timeString = [timesp stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (timeString.length >= 10) {
        NSString *second = [timeString substringToIndex:10];
        NSString *milliscond = [timeString substringFromIndex:10];
        NSString * timeStampString = [NSString stringWithFormat:@"%@.%@",second,milliscond];
        NSTimeInterval _interval=[timeStampString doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:gmt*60*60];//timeZoneWithName:@"UTC"
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:format]; //@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        return dateString;
    }
    return @"";
}

+ (NSString *)stringStamp2Time:(NSString *)dateStr {
    if (!IsValidateString(dateStr)){
        return @"";
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateStr.longLongValue > powl(10, 10) ? dateStr.longLongValue/1000 : dateStr.longLongValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *locationString = [dateFormatter stringFromDate:confromTimesp];
    return locationString;
}

+ (NSString *)stringStamp2Time:(NSString *)dateStr gmt:(int)gmt{
    if (!IsValidateString(dateStr)){
        return @"";
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateStr.longLongValue > powl(10, 10) ? dateStr.longLongValue/1000 : dateStr.longLongValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:gmt*60*60]];//直接指定时区，这里是东8区
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *locationString = [dateFormatter stringFromDate:confromTimesp];
    return locationString;
}

+ (NSString *)date2StringStamp:(NSString *)dateStr format:(NSString *)format{
    if (!IsValidateString(dateStr)){
        return @"0";
    }
    // theTime __@"%04d-%02d-%02d %02d:%02d:00"
    // 转换为时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    // NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    // [formatter setTimeZone:timeZone];
    NSDate* dateTodo = [formatter dateFromString:dateStr];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[dateTodo timeIntervalSince1970]];
    return timeSp;
}
/**
 * standardDate2MYDate:
 *
 * 将标准时间转为客户端需要的形式：不是当天的就显示日期（mm-dd），当天的则显示时间（hh-mm）
 */
+ (NSString *)standardDate2MYDate:(NSString *)string {
    NSString *MYDate = @"";
    if ( string ) {
        NSString *today = [self currentDate:nil];
        NSString *tempStr = @"";
        if ( string.length > 10 ) {
            tempStr = [string substringToIndex:10];
        }
        
        // 当天
        if ( NSOrderedSame == [tempStr compare:today] )
        {
            if ( string.length > 11 ){
                MYDate = [string substringFromIndex:11];
                if ( MYDate.length > 5 ) {
                    MYDate = [MYDate substringToIndex:5];
                }
            }
        }
        // 非当天
        else
        {
            if ( string.length > 10 ){
                MYDate = [string substringToIndex:10];
                MYDate = [MYDate substringFromIndex:5];
            }
        }
    }
    return MYDate;
}

+ (NSString *)standardDate2MYDate2:(NSString *)string {
    NSString *MYDate = @"";
    if ( string ) {
        NSString *today = [self currentDate:nil];
        NSString *tempStr = @"";
        if ( string.length > 10 ) {
            tempStr = [string substringToIndex:10];
        }
        
        // 当天
        if ( NSOrderedSame == [tempStr compare:today] )
        {
            if ( string.length > 11 ){
                MYDate = [string substringFromIndex:11];
                if ( MYDate.length > 5 ) {
                    MYDate = [MYDate substringToIndex:5];
                }
            }
        }
        // 非当天
        else
        {
            if ( NSOrderedSame == [[tempStr substringToIndex:4] compare:[today substringToIndex:4]] ){
                MYDate = [string substringToIndex:10];
                MYDate = [MYDate substringFromIndex:5];
            }else if ( string.length > 10 ){
                MYDate = [string substringToIndex:10];
            }
        }
    }
    return MYDate;
}

/*
 * 1-当天显示：HH: MM
 * 2-昨天显示：昨天 HH: MM
 * 3-近一周显示(不包含昨天)：星期* HH: MM
 * 4-一周之前显示：YYYY年MM月DD日 HH: MM
 */
+ (NSString *)standardDate2MYDate3:(NSString *)dateStr {
    if (!IsValidateString(dateStr)) {
        return @"";
    }
    
    // 原始日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFrome = [dateFormatter dateFromString:dateStr];
    NSString  *dateFromeStr = [dateFormatter stringFromDate:dateFrome];
    
    // 今天
    NSDate *dateNow = [NSDate date];
    NSString *dateNowStr = [dateFormatter stringFromDate:dateNow];
    
    // 昨天
    NSDate *dateYesterday = [NSDate dateWithTimeIntervalSinceNow:-24 * 60 * 60];
    NSString *dateYesterdayStr = [dateFormatter stringFromDate:dateYesterday];
    
    if (!dateFrome) {
        return @"";
    }
    
    if ([[dateNowStr substringToIndex:10] isEqualToString:[dateFromeStr substringToIndex:10]]) { // 当天
        return [dateFromeStr substringWithRange:NSMakeRange(11, 5)];
    }else if([[dateYesterdayStr substringToIndex:10] isEqualToString:[dateFromeStr substringToIndex:10]]){ // 昨天
        return [NSString stringWithFormat:@"昨天 %@", [dateFromeStr substringWithRange:NSMakeRange(11, 5)]];
    }else if((-[dateFrome timeIntervalSinceNow]) < 7 * 24 * 60 * 60 ){ // 一周内
        NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
        [calendar setTimeZone: timeZone];
        NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
        
        NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:dateFrome];
        
        return [NSString stringWithFormat:@"%@ %@", [weekdays objectAtIndex:theComponents.weekday], [dateFromeStr substringWithRange:NSMakeRange(11, 5)]];
    }else{
        [dateFormatter setDateFormat: @"yyyy年MM月dd日 HH:mm"];
        return [dateFormatter stringFromDate:dateFrome];
    }
    
    return @"";
}

+ (NSString *)timeToMinute:(NSString *)time{
    NSString *min = @"0";
    NSArray *timeArray = [time componentsSeparatedByString:@":"];
    if (IsValidateArr(timeArray)) {
        for (int i = 0 ; i < timeArray.count ; i++) {
            int t = [timeArray[i] intValue];
            t = t * pow(60, timeArray.count - 1 - i);
            min = [NSString stringWithFormat:@"%d" , [min intValue] + t];
        }
    }
    return min;
}

+(NSString*)hiddenMyInfoWithInfo:(NSString*)infoText tag:(NSInteger)tag
{
    switch (tag) {
        case 0://手机号
        {
            if (infoText.length>0)
            {
                NSString * preStr = [infoText substringWithRange:NSMakeRange(0, 3)];
                NSString * middleStr = @"****";
                NSString * suffStr = [infoText substringWithRange:NSMakeRange(infoText.length-4, 4)];
                NSString * returnStr = [[preStr stringByAppendingString:middleStr] stringByAppendingString:suffStr];
                
                return returnStr;
            }else
            {
                return @"";
            }
            
        }
            break;
        case 1://邮箱
        {
            if (infoText.length>0)
            {
                NSString * preStr = [infoText substringWithRange:NSMakeRange(0, 1)];
                NSString * middleStr = @"***";
                
                NSArray * tempArray = [infoText componentsSeparatedByString:@"@"];
                
                NSString * suffStr = [@"@" stringByAppendingString:[tempArray objectAtIndex:1]];
                NSString * returnStr = [[preStr stringByAppendingString:middleStr] stringByAppendingString:suffStr];
                
                return returnStr;
            }else
            {
                return @"";
            }
            
        }
            break;
        case 2://实名
        {
            
            if (infoText.length>0)
            {
                NSString * suffStr = [infoText substringWithRange:NSMakeRange(1, infoText.length-1)];
                NSString * returnStr = [@"*" stringByAppendingString:suffStr];
                return returnStr;
            }else
            {
                return @"";
            }
            
        }
            break;
        case 3://银行账户
        {
            // 账号(银行)
            
            
            NSArray * tempArray = [infoText componentsSeparatedByString:@"("];
            
            NSString * preStr = @"****";
            NSString * middleStr = [[tempArray objectAtIndex:0] substringWithRange:NSMakeRange([[tempArray objectAtIndex:0] length]-4, 4)];//银行卡账号
            
            
            NSString * suffStr = [tempArray objectAtIndex:1];
            
            NSString * returnStr = [preStr stringByAppendingFormat:@"%@(%@",middleStr,suffStr];
            return returnStr;
            
        }
            break;
            
            
            
        default:
            break;
    }
    
    return @"";
}

#pragma mark - deviceString

+ (NSString *)deviceString {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return platform;
}

+ (NSString *)detailDeviceString {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([deviceString isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([deviceString isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([deviceString isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([deviceString isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([deviceString isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([deviceString isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    
    //iPod Touch
    if ([deviceString isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([deviceString isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([deviceString isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([deviceString isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([deviceString isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    if ([deviceString isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([deviceString isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([deviceString isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([deviceString isEqualToString:@"iPad3,6"])   return @"iPad4";
    
    //iPad Air
    if ([deviceString isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([deviceString isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([deviceString isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([deviceString isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([deviceString isEqualToString:@"iPad5,4"])   return @"iPadAir2";
    
    //iPad mini
    if ([deviceString isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([deviceString isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([deviceString isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([deviceString isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([deviceString isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([deviceString isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([deviceString isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([deviceString isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([deviceString isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([deviceString isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([deviceString isEqualToString:@"iPad5,2"])   return @"iPadmini4";
    
    if ([deviceString isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([deviceString isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return deviceString;
}

+ (BOOL)isIPhone6 {
    return [[self deviceString] isEqual:@"iPhone7,2"];
}

+ (BOOL)isIPhone6Plus {
    return [[self deviceString] isEqual:@"iPhone7,1"];
}

#pragma mark - setWebKitCacheModel

+ (void)setWebKitCacheModel {
    [[NSUserDefaults standardUserDefaults] setInteger:0
                                               forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO
                                            forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - appVersion

+ (NSString *)appVersion {
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if ( !IsValidateString(appVersion) ) {
        appVersion = @"";
    }
    return appVersion;
}

#pragma mark - appName

+ (NSString *)appName {
//    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];

    if ( !IsValidateString(appName) ) {
        appName = @"";
    }
    return appName;
}


#pragma mark - convertViewToImage

+ (UIImage *)snapshot {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ( [[UIScreen mainScreen] respondsToSelector:@selector(scale)] )
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(window.bounds.size);
    
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 跳转iTunes
+ (void)toItunes{
    NSString * url = [NSString stringWithFormat:@"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",@"1173379910"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

#pragma mark - getColorWithHexColor
+ (UIColor *) getColorWithHexColor:(NSString *)hexColor
{
    if (!hexColor || hexColor.length != 6) {
        return nil;
    }
    
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    
    range.location =0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:1.0f];
}

#pragma mark - setCodeFromStr
+ (NSString *)setCodeFromStr:(NSString *)str{
    if ([str isEqualToString:@"SZ"]) { // 深圳
        return @"0";
    } else if ([str isEqualToString:@"SH"]){// 上海
        return @"1";
    } else if ([str isEqualToString:@"HK"]){// 港股
        return @"2";
    } else if ([str isEqualToString:@"CF"]){// 股指期货
        return @"3";
    } else if ([str isEqualToString:@"SF"]){// 上海商品期货
        return @"4";
    } else if ([str isEqualToString:@"DF"]){// 大连商品期货
        return @"5";
    } else if ([str isEqualToString:@"ZF"]){// 郑州商品期货
        return @"6";
    } else if ([str isEqualToString:@"BC"]){// 渤海商品
        return @"7";
    } else if ([str isEqualToString:@"SG"]){// 上海金
        return @"8";
    } else if ([str isEqualToString:@"LG"]){// 伦敦金
        return @"9";
    } else if ([str isEqualToString:@"TP"]){// 天津贵金属
        return @"10";
    } else if ([str isEqualToString:@"DY"]){// 大圆银泰
        return @"11";
    } else if ([str isEqualToString:@"GP"]){// 广东贵金属
        return @"12";
    } else if ([str isEqualToString:@"NA"]){// 纳斯达克
        return @"13";
    } else if ([str isEqualToString:@"NY"]){// 纽交所
        return @"14";
    } else if ([str isEqualToString:@"AM"]){// 美交所
        return @"15";
    } else if ([str isEqualToString:@"HI"]){// 港股指数
        return @"16";
    } else if ([str isEqualToString:@"UI"]){// 美股指数
        return @"17";
    } else {
        return @"0";
    }
}

#pragma mark - 获取类名与类型
//获取属性名称数组
+ (NSDictionary *)classPropsFor:(Class)klass
{
    if (klass == NULL) {
        return nil;
    }
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    int i;
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithFormat:@"%s" , propName];
            NSString *propertyType = [NSString stringWithFormat:@"%s" , propType];
            
//            NSLog(@"propertyName %@ propertyType %@", propertyName, propertyType);
            
            [results setObject:propertyType forKey:propertyName];
        }
    }
    free(properties);
    
    // returning a copy here to make sure the dictionary is immutable
    return [NSDictionary dictionaryWithDictionary:results];
}

//获取属性的方法
static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    //printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            
            // if you want a list of what will be returned for these primitives, search online for
            // "objective-c" "Property Attribute Description Examples"
            // apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
            
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}
//抽离mjExtension 根据需求独立封装解析model方法
+(id)analysisDatawithmodelClass:(Class)obj AndDic:(NSDictionary *)dic;{
    
    id model =  nil;//[[obj alloc]init];
    model = [obj mj_objectWithKeyValues:dic];
    NSDictionary *propertyDic = [BaseTool classPropsFor:obj] != nil?[BaseTool classPropsFor:obj]:[NSDictionary dictionary];
    model = [BaseTool returnValuePropertyWithDic:propertyDic AndModel:model];
    return model;
}

+(NSArray *)analysisDatawithmodelClass:(Class)obj AndArr:(NSArray *)arr{
    
    NSMutableArray *disposeArr = [NSMutableArray array];
    id model = [[obj alloc]init];
    NSArray *modelArr = [obj mj_objectArrayWithKeyValuesArray:arr];
    NSDictionary *propertyDic = [BaseTool classPropsFor:obj] != nil?[BaseTool classPropsFor:obj]:[NSDictionary dictionary];
    for (model in modelArr) {

        [disposeArr addObject:[BaseTool returnValuePropertyWithDic:propertyDic AndModel:model]];
    }
    NSArray *returnArr = [disposeArr copy];
    return returnArr;
}

+ (id)returnValuePropertyWithDic:(NSDictionary *)dic AndModel:(id)model{
    
    unsigned count = 0;
    id value;
    objc_property_t *properties = class_copyPropertyList([model class], &count);
    if (properties == NULL) {
        return model;
    }
    for (int i = 0; i < [[dic allKeys]count]; i++) {
        objc_property_t propertyValue = properties[i];
        const char *propertyName = property_getName(propertyValue);
        NSString *name = [NSString stringWithFormat:@"%s",propertyName];
        NSString *type = [dic objectForKey:name];
        SEL getSeletor = NSSelectorFromString([NSString stringWithUTF8String:propertyName]);
        
        if ([model respondsToSelector:getSeletor]) {
            NSMethodSignature *signature = [model methodSignatureForSelector:getSeletor];//方法签名
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];//调用对象
            [invocation setTarget:model];//设置target
            [invocation setSelector:getSeletor];//设置selector
            NSObject *__unsafe_unretained returnValue = nil;//设置返回值
            [invocation invoke];//开始调用
            [invocation getReturnValue:&returnValue];//接收返回值
            if (returnValue == nil || [returnValue isEqual:[NSNull null]] || [returnValue isEqual:nil] || [returnValue isKindOfClass:[NSNull class]] || returnValue == NULL || [returnValue isEqual:@"null"]) {
            if ([type isEqualToString:@"NSString"]) {
                value = @"--";
            }else if ([type isEqualToString:@"NSDictionary"]){
                value = [NSDictionary dictionary];
            }else if ([type isEqualToString:@"NSArray"]){
                value = [NSArray array];
            }else{
                value = returnValue;
            }
                if(!IsValidateString(value)){
                    value = @"";
                }
            [model setValue:value forKey:name];
        }
        }
    }
    free(properties);
    return model;
}

/**
 * addSkipBackupAttributeToItemAtDocumentsDirectory:
 *
 * 存储在Documents目录下的文件会被自动同步到iCloud，故需设置其不被同步到iCloud
 */
+ (BOOL)addSkipBackupAttributeToItemAtDocumentsDirectory:(NSString *)documentsDirectory {
    NSURL *url = [NSURL fileURLWithPath:documentsDirectory];
    if ( [[NSFileManager defaultManager] fileExistsAtPath:[url path]] ) {
        NSError *error = nil;
        BOOL success = [url setResourceValue:[NSNumber numberWithBool:YES]
                                      forKey:NSURLIsExcludedFromBackupKey
                                       error:&error];
        if( !success ) {
        }
        return success;
    }
    return NO;
}

+ (NSString *)getDocumentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:fileName];
    return path;
}

+ (NSMutableAttributedString *)newsContent:(NSDictionary *)dic {
    if ( IsValidateDic(dic) ) {
        // 分类、标题及正文内容
//        NSString *tn = [NSString stringWithFormat:@"%@", dic[@"tn"]];
//        if ( !IsValidateString(tn) ) {
//            tn = @"";
//        }
//        NSString *subj = [NSString stringWithFormat:@"%@", dic[@"subj"]];
//        if ( !IsValidateString(subj) ) {
//            subj = @"";
//        } else {
//            subj = [NSString stringWithFormat:@"%@：", subj];
//        }
        NSString *content = [NSString stringWithFormat:@"%@", dic[@"txt"]];
        content = [BaseTool filterHTML:content];
        //        content = [NSString stringWithFormat:@"【%@%@】%@", subj, tn, content];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
        [attributedString addAttribute:NSFontAttributeName value:[[Fonts shareFonts] font16] range:NSMakeRange(0, attributedString.length)];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
        
        return attributedString;
    }
    return [[NSMutableAttributedString alloc] initWithString:EmptyString];
}

/*html*/
+ (NSString *)filterHTML:(NSString *)html {
    if ( !IsValidateString(html) ) {
        return @"";
    }
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while( [scanner isAtEnd] == NO )
    {
        // 找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        // 找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        // 替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    
    return [self removeNBSPAndSpaceAndEnterSymbol:html];
}

+ (NSString *)removeNBSPSymbol:(NSString *)html {
    return [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
}

+ (NSString *)removeNBSPAndSpaceAndEnterSymbol:(NSString *)html {
    NSString * result = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    result = [result stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    result = [result stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    return result;
}


/**
 * convertLongToNSString:
 *
 * 将整数值转换为字符串，规则如下：
 * 1 - 没超过6位数的，直接显示全部数字字段；
 * 2 - 超过6位数没超过9位数的数值，以万为单位如75463159应显示为7546.32万，保留到小数点后2位；
 * 3 - 超过亿的数字以亿为单位，如2546459873，应显示为：25.46亿，保留到小数点后两位。四舍五入取值显示法。
 */
+ (NSString *)convertLongToNSString:(long long)l
{
    BOOL isNegative = NO;
    if ( l < 0 ) {
        isNegative = YES;
        l = -l;
    }
    NSString * lStr = [NSString stringWithFormat:@"%lld", l];
    NSString * tempStr = [NSString stringWithFormat:@"%lld", l];
    if (tempStr.length < 5) {
        return [NSString stringWithFormat:@"%@%@", isNegative ? @"-" : @"", lStr];
    } else if (tempStr.length >= 5 && tempStr.length < 9) {
        lStr = [NSString stringWithFormat:@"%.2f万", (float)l/TEN_THOUSAND];
    } else if (tempStr.length >= 9 && tempStr.length < 13) {
        lStr = [NSString stringWithFormat:@"%.2f亿", (float)l/A_THOUSAND_MILLION];
    } else {
        lStr = [NSString stringWithFormat:@"%.2f万亿", (float)l/A_MILLION_MILLION];
    }
    
    return [NSString stringWithFormat:@"%@%@", isNegative ? @"-" : @"", lStr];
}

+ (NSString *)convertLongToNSString:(long long)l pointNum:(int)point
{
    BOOL isNegative = NO;
    if ( l < 0 ) {
        isNegative = YES;
        l = -l;
    }
    NSString * lStr = [NSString stringWithFormat:@"%lld", l];
    NSString * tempStr = [NSString stringWithFormat:@"%lld", l];
    NSString *formatStr = @"%.";
    if (tempStr.length < 5) {
        return [NSString stringWithFormat:@"%@%@", isNegative ? @"-" : @"", lStr];
    } else if (tempStr.length >= 5 && tempStr.length < 9) {
        formatStr = [formatStr stringByAppendingFormat:@"%dlf万", point];
        lStr = [NSString stringWithFormat:formatStr, (float)l/TEN_THOUSAND];
    } else if (tempStr.length >= 9 && tempStr.length < 13) {
        formatStr = [formatStr stringByAppendingFormat:@"%dlf亿", point];
        lStr = [NSString stringWithFormat:formatStr, (float)l/A_THOUSAND_MILLION];
    }else {
        formatStr = [formatStr stringByAppendingFormat:@"%dlf万亿", point];
        lStr = [NSString stringWithFormat:formatStr, (float)l/A_MILLION_MILLION];
    }
    
    return [NSString stringWithFormat:@"%@%@", isNegative ? @"-" : @"", lStr];
}

/**
 * convertFloatToNSString:pointNum:
 *
 * 将浮点数的值转换为字符串，规则如下：
 * 1 - 没超过6位数的，直接显示全部数字字段；
 * 2 - 超过6位数没超过9位数的数值，以万为单位如75463159应显示为7546.32万，保留到小数点后2位；
 * 3 - 超过亿的数字以亿为单位，如2546459873，应显示为：25.46亿，保留到小数点后两位。四舍五入取值显示法。
 */
+ (NSString *)convertFloatToNSString:(double)f pointNum:(int)point
{
    BOOL isNegative = NO;
    if ( f < 0.f ) {
        isNegative = YES;
        f = -f;
    }
    if ( fabs(f) < 10000.f ) {
        //        return [NSString stringWithFormat:@"%@%@", isNegative ? @"-" : @"", [self retainTwoDecimalPointOfAFloatVale:&f pointNum:point]];
        return [NSString stringWithFormat:@"%@%@", isNegative ? @"-" : @"", [self newFloat:f withNumber:point]];
    }
    
    NSString *formatStr = @"%.";
    NSString *fStr = nil;//[NSString stringWithFormat:@"%f", f];
    NSString *tempStr = [NSString stringWithFormat:@"%.0f", f];
    if (tempStr.length < 5) {
        return [self newFloat:f withNumber:point];
        //        return [NSString stringWithFormat:@"%@%@", isNegative ? @"-" : @"", [self retainTwoDecimalPointOfAFloatVale:&f pointNum:point]];
        //        return [NSString stringWithFormat:@"%@%@", isNegative ? @"-" : @"", fStr];
    } else if (tempStr.length >= 5 && tempStr.length < 9) {
        long long l = (long long)f;
        if (l >= TEN_THOUSAND) {
            formatStr = [formatStr stringByAppendingFormat:@"%dlf万", point];
            fStr = [NSString stringWithFormat:formatStr, f/TEN_THOUSAND];
            //            fStr = [NSString stringWithFormat:@"%.2f万", f/TEN_THOUSAND];
        } else {
            formatStr = [formatStr stringByAppendingFormat:@"%dlf", point];
            fStr = [NSString stringWithFormat:formatStr, f];
            //            fStr = [NSString stringWithFormat:@"%.2f", f];
        }
    } else {
        long long l = (long long)f;
        if (l >= A_MILLION_MILLION) {
            formatStr = [formatStr stringByAppendingFormat:@"%dlf万亿", point];
            fStr = [NSString stringWithFormat:formatStr, f/A_MILLION_MILLION];
            //            fStr = [NSString stringWithFormat:@"%.2f亿", f/A_THOUSAND_MILLION];
        } else if (l >= A_THOUSAND_MILLION) {
            formatStr = [formatStr stringByAppendingFormat:@"%dlf亿", point];
            fStr = [NSString stringWithFormat:formatStr, f/A_THOUSAND_MILLION];
            //            fStr = [NSString stringWithFormat:@"%.2f亿", f/A_THOUSAND_MILLION];
        } else if (l >= TEN_THOUSAND && l <= A_THOUSAND_MILLION) {
            formatStr = [formatStr stringByAppendingFormat:@"%dlf万", point];
            fStr = [NSString stringWithFormat:formatStr, f/TEN_THOUSAND];
            //            fStr = [NSString stringWithFormat:@"%.2f万", f/TEN_THOUSAND];
        } else {
            formatStr = [formatStr stringByAppendingFormat:@"%dlf", point];
            fStr = [NSString stringWithFormat:formatStr, f];
            //            fStr = [NSString stringWithFormat:@"%.2f", f];
        }
    }
    
    return [NSString stringWithFormat:@"%@%@", isNegative ? @"-" : @"", fStr];
}

/**
 * newFloat:withNumber:
 *
 * 通过一个整型的变量来控制数值保留的小数点位数,以往用@"%.2f"来指定保留2位小数位，现在可通过一个变量来控制保留的位数
 *
 * @Parameters:
 *          value           - 浮点数
 *          numberOfPlace   - 指定的小数点位数
 *
 * @return - 保留指定的小数点位数后的字符串
 */
+ (NSString *)newFloat:(double)value withNumber:(int)numberOfPlace
{
    NSString *formatStr = @"%.";
    formatStr = [formatStr stringByAppendingFormat:@"%dlf", numberOfPlace];
    formatStr = [NSString stringWithFormat:formatStr, value];
    return formatStr;
}
/**
 * newFloat:withNumber:setcode:
 *
 * 通过一个整型的变量来控制数值保留的小数点位数,以往用@"%.2f"来指定保留2位小数位，现在可通过一个变量来控制保留的位数
 *
 * @Parameters:
 *          value           - 浮点数
 *          numberOfPlace   - 指定的小数点位数
 *          setcode         - 市场代码
 *
 * @return - 保留指定的小数点位数后的字符串
 */
+ (NSString *)newFloat:(double)value withNumber:(int)numberOfPlace setcode:(int)setcode
{
    // 广东贵金属需要做特别处理
    if ( 12 == setcode ) {
        value = value - 5 / pow(10, numberOfPlace + 1);
    }
    return [self newFloat:value withNumber:numberOfPlace];
}

/**
 * anotherToast:message:
 *
 * 显示一个Toast提示
 *
 * @Parameters:
 *          view - 需要显示提示的ViewController
 *          message - 显示的Toast消息
 */
+ (void)anotherToast:(UIView *)view message:(NSString *)msg
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.tag = MBTag;
    hud.labelText = msg;
    //    hud.margin = 10.f;
    //    hud.yOffset = 5.f;
}

/**
 * anotherHideToast:
 *
 * 隐藏Toast提示
 *
 * @Parameters:
 *          view - 显示提示的ViewController
 */
+ (void)anotherHideToast:(UIView *)view
{
    MBProgressHUD * mb = (MBProgressHUD *) [view viewWithTag:MBTag];
    if (nil != mb || ![mb isHidden]) {
        [mb removeFromSuperview];
    }
}

+ (void)showLoadingHud:(UIView *)view
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.tag = MBTag;
    hud.mode = MBProgressHUDModeIndeterminate;
    //    hud.margin = 10.f;
    //    hud.yOffset = 5.f;
}

+ (void)hideLoadingHud:(UIView *)view
{
    MBProgressHUD * mb = (MBProgressHUD *) [view viewWithTag:MBTag];
    if (nil != mb || ![mb isHidden]) {
        [mb removeFromSuperview];
    }
}

+(NSData *) LongToNSData:(long long)data
{
    Byte *buf = (Byte*)malloc(8);
    for (int i=7; i>=0; i--) {
        buf[i] = data & 0x00000000000000ff;
        data = data >> 8;
    }
    
    NSData *result =[NSData dataWithBytes:buf length:8];
    return result;
}

//unsigned
+(uint32_t) NSDataToUInt:(NSData *)data
{
    unsigned char bytes[4];
    [data getBytes:bytes length:4];
    uint32_t n = (int)bytes[0] << 24;
    n |= (int)bytes[1] << 16;
    n |= (int)bytes[2] << 8;
    n |= (int)bytes[3];
    return n;
}

+(short) NSDataToShort:(NSData *)data
{
    unsigned char bytes[2];
    [data getBytes:bytes length:2];
    uint32_t n = (int)bytes[0] << 8;
    n |= (int)bytes[1];
    return n;
}

+ (NSData *)IntArrayToData:(NSArray *)arr pyl:(int)pyl{
    unsigned c = arr.count;
    uint8_t *bytes = (uint8_t*)malloc(sizeof(*bytes) * c);
    
    unsigned i;
    for (i = 0; i < c; i++)
    {
        NSNumber *str = [arr objectAtIndex:i];
        int byte = [str intValue] + pyl;
        bytes[i] = (uint8_t)byte;
    }
    
    NSData *fileData = [NSData dataWithBytesNoCopy:bytes length:c freeWhenDone:YES];
    return fileData;
}
//十六進位字串轉bytes，可以設定size，padding在左邊
+(NSData *) hexStrToNSData:(NSString *)data withSize:(NSInteger)size
{
    int add = size*2 - data.length;
    
    if (add > 0) {
        NSString* tmp = [[NSString string] stringByPaddingToLength:add withString:@"0" startingAtIndex:0];
        data = [tmp stringByAppendingString:data];
    }
    
    return [self hexStrToNSData:data];
}

//十六進位字串轉bytes
+(NSData *) hexStrToNSData:(NSString *)hexStr
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= hexStr.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* ch = [hexStr substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:ch];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

//bytes轉十六進位字串，不是base64哦，別搞混了
+(NSString *) NSDataToHexString:(NSData *)data
{
    if (data == nil) {
        return nil;
    }
    NSMutableString* hexString = [NSMutableString string];
    const unsigned char *p = [data bytes];
    for (int i=0; i < [data length]; i++) {
        [hexString appendFormat:@"%02x", *p++];
    }
    return hexString;
}

+ (int)checkTodayHasRecord:(NSString *)key tag:(NSString *)tag{
    return [BaseTool checkHasRecord:key tag:tag isToday:YES];
}

+ (int)checkHasRecord:(NSString *)key tag:(NSString *)tag isToday:(BOOL)isToday{
    if (IsValidateString(key) && IsValidateString(tag)) {
        NSDictionary *records = [[NSUserDefaults standardUserDefaults] objectForKey:@"app_checkTodayRecord"];
        NSMutableDictionary *rec = [[NSMutableDictionary alloc] init];
        if (IsValidateDic(records)) {
            rec = [[NSMutableDictionary alloc] initWithDictionary:records];
        }
        NSString *string = [NSString stringWithFormat:@"%@_%d/%d/%d" , tag , [BaseTool currentYear] , [BaseTool currentMonth] , [BaseTool currentDay]];
        if (!isToday) {
            string = tag;
        }
        if (!IsValidateArr(records[key]) || ![records[key] containsObject:string]) {
            NSMutableArray *array;
            if (!records[key]) {
                array = [[NSMutableArray alloc] init];
            }else{
                array = [[NSMutableArray alloc] initWithArray:records[key]];
                for (int i = (int)array.count - 1 ; i >= 0 ; i--) {
                    if ([array[i] rangeOfString:tag].length > 0) {
                        [array removeObjectAtIndex:i];
                    }
                }
            }
            [array addObject:string];
            [rec setObject:array forKey:key];
            [[NSUserDefaults standardUserDefaults] setObject:rec forKey:@"app_checkTodayRecord"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return 0;
        }
        return 1;
    }
    return -1;
}

+ (void)clearRecord:(NSString *)key{
    if (IsValidateString(key)) {
        NSDictionary *records = [[NSUserDefaults standardUserDefaults] objectForKey:@"app_checkTodayRecord"];
        NSMutableDictionary *rec = nil;[[NSMutableDictionary alloc] init];
        if (IsValidateDic(records)) {
            rec = [[NSMutableDictionary alloc] initWithDictionary:records];
            [rec removeObjectForKey:key];
            [[NSUserDefaults standardUserDefaults] setObject:rec forKey:@"app_checkTodayRecord"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

+(UIImage *)imageWithColorUIImage:(UIImage *)img UIColor:(UIColor *)color{
    UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextClipToMask(context, rect, img.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (long long)getVersionFrom:(NSString *)string{
    long long version = 0;
    NSArray *a = [string componentsSeparatedByString:@"."];
    if (IsValidateArr(a)) {
        NSString *versionNow = @"";
        for (int i = 0 ; i < a.count ; i++) {
            versionNow = [versionNow stringByAppendingFormat:@"%05i" , [a[i] intValue]];
        }
        version = [versionNow longLongValue];
    }
    return version;
}

+ (void)buttonImageToRight:(UIButton *)button{
    //在使用一次titleLabel和imageView后才能正确获取titleSize
    CGSize titleSize = button.titleLabel.bounds.size;
    CGSize imageSize = button.imageView.bounds.size;
    CGFloat interval = 1.0;
    button.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
}

+ (UINavigationController *)getNav{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)vc;
    } else if (vc.navigationController) {
        return vc.navigationController;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UIViewController *vc2 = ((UITabBarController *)vc).selectedViewController;
        if ([vc2 isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)vc2;
        } else if (vc2.navigationController) {
            return vc2.navigationController;
        }
    }
    return nil;
}

+ (UIViewController*)topPresentedViewController{
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
    }
    return viewController;
}

-(NSAttributedString*)scaleZoom:(NSString*)value zoom:(NSString*)zoome{
    
    NSInteger from = [[[zoome componentsSeparatedByString:@"#"] firstObject] integerValue];
    NSInteger to = [[[zoome componentsSeparatedByString:@"#"] lastObject] integerValue];
    
    if (to <= 0) {
        
        NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:value];
        return result;
    }
    
    NSRange scaleRange = NSMakeRange(value.length - from - 1, to);
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:value];
    [result addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25.0f] range:scaleRange];
    
    return result;
}

+ (NSAttributedString *)getBigAndSmallString:(NSString *)string font:(UIFont *)font zoom:(NSString*)zoome bigSize:(float)bigSize smallSize:(float)smallSize smallToBig:(BOOL)smallToBig BaselineOffset:(float)BaselineOffset{
    if (!string) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    if (!zoome || [zoome rangeOfString:@"#"].length == 0) {
        NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:string];
        return result;
    }
    NSInteger begin = [[[zoome componentsSeparatedByString:@"#"] firstObject] integerValue];
    NSInteger length = [[[zoome componentsSeparatedByString:@"#"] lastObject] integerValue];
    if (length <= 0) {
        NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:string];
        return result;
    }
    UIFont * font1 = [UIFont fontWithName:[font fontName] size:smallToBig ? smallSize : bigSize];
    UIFont * font2 = [UIFont fontWithName:[font fontName] size:smallToBig ? bigSize : smallSize];
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc] init];
    NSString *str = string.length > begin ? [string substringToIndex:begin] : string;
    NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName :font1}];
    str = string.length > begin ? [string substringWithRange:NSMakeRange(begin, string.length >= begin + length ? length : string.length - begin)] : @"";
    NSAttributedString * att2 = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font2}];
    str = string.length > begin + length ? [string substringFromIndex:begin + length] : @"";
    NSAttributedString * att3 = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font1,NSBaselineOffsetAttributeName:@(BaselineOffset)}];
    [att appendAttributedString:att1];
    [att appendAttributedString:att2];
    [att appendAttributedString:att3];
    return att;
}

+ (NSString *)uuidString

{
    
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    
    CFRelease(uuid_ref);
    
    CFRelease(uuid_string_ref);
    
    return [uuid lowercaseString];
    
}

+ (NSString *)getAmountInWords:(NSString *)money{
    if (money.length == 0) {
        return @"";
    }
    if (money.floatValue == 0) {
        return @"零圆整";
    }
    //大写数字
    NSArray *upperArray = @[ @"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖" ];
    /** 整数部分的单位 */
    NSArray *measureArray = @[ @"", @"拾", @"佰", @"仟"];
    /** 整数部分的单位 */
    NSArray *intUnit = @[@"圆", @"万", @"亿"];
    /** 小数部分的单位 */
    NSArray *floatUnitArray = @[ @"角", @"分" ];
    
    NSString *upIntNum = [NSString string];
    NSString *upFloatNum = [NSString string];
    NSArray *numArray = [money componentsSeparatedByString:@"."];
    
    NSString *str1 = [numArray objectAtIndex:0];
    NSInteger num1 = str1.integerValue;
    for (int i = 0; i < intUnit.count && num1 > 0; i++) {//这一部分就是单纯的转化
        NSString *temp = @"";
        int tempNum = num1%10000;
        if (tempNum != 0 || i == 0) {
            for (int j = 0; j < measureArray.count && num1 > 0; j++) {
                temp = [NSString stringWithFormat:@"%@%@%@", [upperArray objectAtIndex:num1%10], [measureArray objectAtIndex:j],temp];//每次转化最后一位数
                num1 = num1/10;//数字除以10
            }
            upIntNum = [[temp stringByAppendingString:[intUnit objectAtIndex:i]] stringByAppendingString:upIntNum];
        } else {
            num1 /= 10000;
            temp = @"零";
            upIntNum = [temp stringByAppendingString:upIntNum];
        }
        
    }
    
    for (int m = 1; m < measureArray.count; m++) { //把零佰零仟这种情况转为零
        NSString *lingUnit = [@"零" stringByAppendingString:[measureArray objectAtIndex:m]];
        upIntNum = [upIntNum stringByReplacingOccurrencesOfString:lingUnit withString:@"零"];
    }
    
    while ([upIntNum rangeOfString:@"零零"].location != NSNotFound) {//多个零相邻的保留一个零
        upIntNum = [upIntNum stringByReplacingOccurrencesOfString:@"零零" withString:@"零"];
    }
    for (int k = 0; k < intUnit.count * 2; k++) { //零万、零亿这种情况转化为万零
        NSString *unit = [intUnit objectAtIndex:k%intUnit.count];
        NSString *lingUnit = [@"零" stringByAppendingString:unit];
        upIntNum = [upIntNum stringByReplacingOccurrencesOfString:lingUnit withString:[unit stringByAppendingString:@"零"]];
    }
    
    if (numArray.count == 2) {//小数部分转化
        NSString *floatStr = [numArray objectAtIndex:1];
        for (NSInteger i = floatStr.length; i > 0; i--) {
            NSString *temp = [floatStr substringWithRange:NSMakeRange(floatStr.length - i, 1)];
            NSInteger tempNum = temp.integerValue;
            if (tempNum == 0) continue;
            NSString *upNum = [upperArray objectAtIndex:tempNum];
            NSString *unit = [floatUnitArray objectAtIndex:floatStr.length - i];
            if (i < floatStr.length && upFloatNum.length == 0 && upIntNum.length > 0) {
                upFloatNum = @"零";
            }
            upFloatNum = [NSString stringWithFormat:@"%@%@%@", upFloatNum, upNum, unit];
        }
    }
    if (upFloatNum.length == 0) {
        upFloatNum = @"整";
    }
    
    NSString *amountInWords = [NSString stringWithFormat:@"%@%@", upIntNum, upFloatNum];
    
    while ([amountInWords rangeOfString:@"零零"].location != NSNotFound) {//再次除去多余的零
        amountInWords = [amountInWords stringByReplacingOccurrencesOfString:@"零零" withString:@"零"];
    }
    
    if ([amountInWords rangeOfString:@"零整"].location != NSNotFound) {
        amountInWords = [amountInWords stringByReplacingOccurrencesOfString:@"零整" withString:@"整"];
    }
    
    return amountInWords;
    
}

+ (NSString *)MD5Digest:(NSString *)string
{
    const char* input = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

+ (CALayer *)flashPointLayer:(UIColor *)color centerWidth:(CGFloat)centerWidth spreadWidth:(CGFloat)spreadWidth frame:(CGRect)frame{
    int duration = 2;
    CALayer * spreadLayer;
    spreadLayer = [CALayer layer];
    CGFloat diameter = spreadWidth; //扩散的大小
    spreadLayer.bounds = CGRectMake(0,0, diameter, diameter);
    spreadLayer.cornerRadius = diameter/2; //设置圆角变为圆形
    //    spreadLayer.position = personImageButton.center;
    spreadLayer.position = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    spreadLayer.backgroundColor = color.CGColor;
    CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = duration;
    animationGroup.repeatCount = INFINITY;//重复无限次
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = defaultCurve;
    //尺寸比例动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.7;//开始的大小
    scaleAnimation.toValue = @1.0;//最后的大小
    scaleAnimation.duration = duration;//动画持续时间
    //透明度动画
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = duration;
    opacityAnimation.values = @[@0.4, @0.45,@0];//透明度值的设置
    opacityAnimation.keyTimes = @[@0, @0.2,@1];//关键帧
    opacityAnimation.removedOnCompletion = NO;
    animationGroup.animations = @[scaleAnimation, opacityAnimation];//添加到动画组
    [spreadLayer addAnimation:animationGroup forKey:@"pulse"];
    
    CALayer *_flashPointLayer = [[CALayer alloc] init];
    CGFloat width = centerWidth;
    _flashPointLayer.bounds = CGRectMake(0, 0, width, width);
    _flashPointLayer.cornerRadius = width/2;
    _flashPointLayer.backgroundColor = color.CGColor;
    _flashPointLayer.position = CGPointMake(frame.size.width/2, frame.size.height/2);
    
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = UIColor.clearColor.CGColor;
    layer.bounds = CGRectMake(0,0, frame.size.width, frame.size.height);
    [layer addSublayer:spreadLayer];
    [layer addSublayer:_flashPointLayer];
    return layer;
}
@end
