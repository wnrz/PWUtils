//
//  QuoTabButtonView.h
//  AFNetworking
//
//  Created by 王宁 on 2018/7/16.
//


@protocol GlobalErrorVCDelegate<NSObject>

@optional
- (void)globalErrorVCReTry;
@end

@interface GlobalErrorVC : UIViewController

@property(nonatomic,weak)id<GlobalErrorVCDelegate> delegate;
@property(nonatomic,assign)int top;
@property(nonatomic,assign)int bottom;
@property(nonatomic,assign)int left;
@property(nonatomic,assign)int right;

+ (GlobalErrorVC*)shareManager;

@end
