//
//  ATCommon.h
//  RTMPCDemo
//
//  Created by jh on 2017/9/20.
//  Copyright © 2017年 jh. All rights reserved.
//公共类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ATCommon : NSObject

//将字典转换为JSON对象
+ (NSString *)fromDicToJSONStr:(NSDictionary *)dic;

// 将字符串转换为字典
+ (id)fromJsonStr:(NSString*)jsonStrong;

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;

//随机字符串
+ (NSString*)randomString:(int)len;

// 随机anyrtc
+ (NSString*)randomAnyRTCString:(int)len;

// 将16进制颜色转换成UIColor
+(UIColor *)getColor:(NSString *)color;

//随机生成汉字
+ (NSMutableString*)randomCreatChinese:(NSInteger)count;

//隐藏界面上所有键盘
+ (void)hideKeyBoard;

//返回一张未被渲染图片
+ (UIImage *)applyColoursDrawing:(UIImage *)image;

// 拨打电话
+ (void)callPhone:(NSString *)phoneNum control:(UIButton *)sender;

//富文本(图片+文字)
+ (NSMutableAttributedString *)getAttributedString:(NSString *)textStr imageSize:(CGRect)imageSize image:(UIImage *)image index:(NSInteger)index;

//得到从1970年到现在的秒数
+(long)getSecondsSince1970;

//转换从1970年到现在的秒数为年月日
+ (NSString *)timeFormatted:(NSString *)totalSeconds;

//比较给定NSDate与当前时间的时间差，返回相差的秒数
+ (long)timeDifference:(NSDate *)date;

//传入 秒  得到  xx分钟xx秒
+ (NSString *)getMMSSFromSS:(NSString *)totalTime;

//字符串包含
+ (BOOL)isStringContains:(NSString *)str string:(NSString *)smallStr;

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;

//最上层视图
+ (UIViewController *)topViewController;

+ (void)basicAnimation:(UIView *)animView;

//P2P错误码
+ (NSString *)getErrorInfoWithCode:(int)code;

@end
