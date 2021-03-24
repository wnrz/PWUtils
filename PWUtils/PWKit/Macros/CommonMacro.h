//
//  CommonMacro.h
//  
//
//  Created by mac on 2018/4/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

#define NSLocalizedStringTableName @"Localizable"
#define UserLanguage @"userLanguage"
#define AppDidEnterBackground @"AppDidEnterBackground"
#define AppDidEnterForeground @"AppDidEnterForeground"

#define maxListCount 900
#define BtnCornerRadious 4.0f
#define ViewCornerRadious 6.0f

//网络请求单例
#define kNetworkUtil        [BaseNetworkUtil sharedInstance]
//拼接字符串
#define Append2Str(str1,str2) ([NSString stringWithFormat:@"%@%@",str1,str2])
// 提示文字
#define kShowWithString(str) [HUDUtil showStr:str];

#define kPage               @"page"

//token
#define KToken              @"token"
#define kUserAccount        @"userAccount"
#define kUserPassword       @"userPassword"

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//收起键盘
#define kDismissKeyboard    [kAppWindow endEditing:YES]

// 检查系统版本
#define iOS_SYSTEM_VERSION(VERSION) ([[UIDevice currentDevice].systemVersion doubleValue] >= VERSION)
#define iOS8OrLater kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0
#define iOS9OrLater kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_9_0


//系统屏幕的尺寸
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kNavBarStatusBarHeight (kStatusBarHeight + kNavBarHeight)
//获取屏幕宽高
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kBoundsWithOutNavStaBar  CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarStatusBarHeight)
//判断是否是iPhoneX
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size)) : NO)

//强弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

#define Version11AdjustTableView if (@available(iOS 11.0, *)) {\
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;\
} else {\
    self.automaticallyAdjustsScrollViewInsets = NO;\
}\
//self.tableView.contentInset = UIEdgeInsetsMake(kNavBarStatusBarHeight, 0, kTabBarHeight, 0);\
//self.tableView.scrollIndicatorInsets = _tableView.contentInset;\

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


//定义UIImage对象
#define ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]
#define kImageNamed(name) [UIImage imageNamed:name]

//判断非空
#define ValidStr(f) (f!=nil && ![f isKindOfClass:[NSNull class]] && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])
#define kNoneNilStr(str) str.length ? str : @" "

#define SafeStr(f) (ValidStr(f) ? f:@"")

// 判断是否为空
#define isNull(obj) (obj == nil || [obj isEqual:[NSNull null]] || [obj isKindOfClass:[NSNull class]])
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

#define IntToString(num) ([NSString stringWithFormat:@"%d",num])
#define IntegerToString(num) ([NSString stringWithFormat:@"%ld",num])


//自适应宽度
#define BoundingWidth(str,with,font) [str boundingRectWithSize:CGSizeMake(with, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil]


//自适应高度
#define BoundingHeight(str,with,font) [str boundingRectWithSize:CGSizeMake(with, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil]

#define BoundingHeightboldSystemFont(str,with,font) [str boundingRectWithSize:CGSizeMake(with, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:font]} context:nil]

//路径相关
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//控制台打印不全
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%d\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//属性是否有效判断
#define IsValidateArr(arr) ((arr && [arr isKindOfClass:[NSArray class]] && [arr count] > 0))
#define IsValidateResult(result) ((nil != result && [result isKindOfClass:[NSDictionary class]] && [[result objectForKey:@"result"] isEqualToString:REQUEST_SUCCESSFULLY]))
#define IsValidateDic(dic) (nil != dic && [dic isKindOfClass:[NSDictionary class]] && [dic count] > 0)
#define IsValidateString(str) ((nil != str) && ([str isKindOfClass:[NSString class]]) && ([str length] > 0) && (![str isEqualToString:@"(null)"]) && (![str isEqualToString:@"null"]) &&((NSNull *) str != [NSNull null]))
#define IsValidateBool(num) (num == 0 || num == 1)

#define IsValidateLenString(str , minLength) ((nil != str) && ([str isKindOfClass:[NSString class]]) && ([str length] >= minLength) && (![str isEqualToString:@"(null)"]) && (![str isEqualToString:@"null"]) &&((NSNull *) str != [NSNull null]))

#define kScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight   [[UIScreen mainScreen] bounds].size.height

#define iOS8OrLater kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0
#define iOS9OrLater kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_9_0

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size)) : NO)

// 定义一个空字符串
#define EmptyString     ([NSString stringWithFormat:@""])
#define ZeroString      (@"0")
#define kDefaultValue    @"--"
#define DownIdentifer   ([NSString stringWithFormat:@"↓"])
#define UpIdentifer     ([NSString stringWithFormat:@"↑"])
#define InfoString(str)  ValidString(str,kDefaultValue)
#define ValidString(str,defaultStr)  (IsValidateString(str))?str:(IsValidateString(defaultStr)?defaultStr:@"")

/******************************************************************
 Get Location String
 *****************************************************************/
#define GetLocalizedString(str) ([NSString stringWithFormat:@"%@", NSLocalizedString(str, nil)])
#define PullRefreshHintStr (GetLocalizedString(@"Pull Down Refreshing Hint"))

// 下拉刷新、上拉刷新的动画延时时间
#define RefreshDelayTime (0.1)

#define MBTag                           9899

#define k30Days     (24 * 60 * 60 * 30)

#define StockDBFileName @"ENOStock.db"

// -----------------------------------------------------------------
// 判断系统版本
// -----------------------------------------------------------------
#define IS_IOS7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)
#define IOS_SYSTEM_VERSION  ([[[UIDevice currentDevice] systemVersion] doubleValue])

#define textFont(x) [UIFont systemFontOfSize:x] //Font设置
#define textBoldFont(x) [UIFont boldSystemFontOfSize:x]
#define OBJWidth(x)  x.frame.size.width
#define OBJHeight(x) x.frame.size.height
#define OBJOriginX(obj) obj.frame.origin.x
#define OBJOriginY(obj) obj.frame.origin.y
#define OBJMAXY(obj) CGRectGetMaxY(obj.frame)
#define OBJMAXX(obj) CGRectGetMaxX(obj.frame)
#define OBJMINY(obj) CGRectGetMinY(obj.frame)
#define OBJMINX(obj) CGRectGetMinX(obj.frame)


//适配


#define UmeWidth(width) (ScreenWidth>320?(width)*ScreenWidth/320:(width))
#define UmeHeight(height) (ScreenHeight<667?(height):(height)*ScreenWidth/320)
#define UmeFontNumber(font) (ScreenWidth>320?floor((font)*ScreenWidth/320):(font))

//弧度
#define Radian(angle) (angle*M_PI/180)


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define StatusBarHeight 20.0

#define TopHeaderHeight 64.0  //20 + 44..
#define HeaderViewHeight 44.0 //头部高度

#define TabControllerHeight 50 //UmeHeight(50)//底部控制高度
#define ChatRoomCellHeight 100.0


#define LandscapeScreenWidth [UIScreen mainScreen].bounds.size.height
#define LandscapeScreenHeight [UIScreen mainScreen].bounds.size.width

#define ENOLogInt(x)  // stop1 NSLog(@"Log_Int = %i",x)
#define ENOLogString(x)  // stop1 NSLog(@"Log_String = %@",x)
#define ENOLogFloat(x)  // stop1 NSLog(@"Log_Float = %f",x)

#define TopVersionHeight [[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0? 20.0:0.0
#define IOS7 [[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0? YES:NO
#define AddIntoArray(array,obj)  if (obj) {[array addObject:obj];}else{[array addObject:@"--"];}
#define AddIntoDictionary(dictionary,obj,key) if(obj){[dictionary setObject:obj forKey:key];}


#define AutoRefreshTimes @"AutoRefreshTimes"

#define ENOColor(r,g,b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1]

/**
 *  单例
 *
 *  使用的时候需要在.h文件中加  AS_SINGLETON(类名);
 *   .m文件中加  DEF_SINGLETON(类名);
 *
 */
#undef    AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

#define WeakSelf(weakSelf) __weak typeof(self) weakSelf = self;
#define StrongSelf(strongSelf) __strong typeof(weakSelf) strongSelf = weakSelf;

#endif /* CommonMacro_h */
