//
//  ArCallCommon.h
//  ContactsCall
//
//  Created by 余生丶 on 2019/3/25.
//  Copyright © 2019 Ar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArCallCommon : NSObject

//将字典转换为JSON对象
+ (NSString *)fromDicToJSONStr:(NSDictionary *)dic;

// 将字符串转换为字典
+ (id)fromJsonStr:(NSString*)jsonStrong;

//隐藏界面上所有键盘
+ (void)hideKeyBoard;

//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(CGRect)frame fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;

// 将16进制颜色转换成UIColor
+ (UIColor *)colorWithHex:(NSString *)hexColor;

//传入 秒  得到  xx分钟xx秒
+ (NSString *)getMMSSFromSS:(NSString *)totalTime;

//将若干view等宽布局于容器containerView中
+ (void)makeEqualWidthViews:(NSArray *)views inView:(UIView *)containerView LRpadding:(CGFloat)LRpadding viewPadding :(CGFloat)viewPadding;

//富文本(图片+文字)
+ (NSMutableAttributedString *)getAttributedString:(NSString *)textStr imageSize:(CGRect)imageSize image:(UIImage *)image index:(NSInteger)index;

//间距
+ (NSDictionary *)setTextLineSpaceWithString:(NSString*)str withFont:(UIFont*)font withLineSpace:(CGFloat)lineSpace withTextlengthSpace:(NSNumber *)textlengthSpace paragraphSpacing:(CGFloat)paragraphSpacing;

//随机字符串
+ (NSString*)randomString:(int)len;

//最上层视图
+ (UIViewController *)topViewController;

//得到从1970年到现在的秒数
+(long)getSecondsSince1970;

//转换从1970年到现在的秒数为年月日
+ (NSString *)timeFormatted:(NSString *)totalSeconds;

+ (void)showAlertMessage:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
