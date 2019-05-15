//
//  ATCommon.m
//  RTMPCDemo
//
//  Created by jh on 2017/9/20.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "ATCommon.h"

@implementation ATCommon

//将字典转换为JSON对象
+ (NSString *)fromDicToJSONStr:(NSDictionary *)dic{
    NSString *JSONStr;
    //判断对象是否可以构造为JSON对象
    if ([NSJSONSerialization isValidJSONObject:dic]){
        NSError *error;
        //转换为NSData对象
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        //转换为字符串，即为JSON对象
        JSONStr=[[NSMutableString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return JSONStr;
}
+ (id)fromJsonStr:(NSString*)jsonStrong {
    
    if ([jsonStrong isKindOfClass:[NSDictionary class]]) {
        return jsonStrong;
    }
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)jsonStrong, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    NSData* data = [decodedString dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile{
    if (mobile.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|73|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobile] == YES)
        || ([regextestcm evaluateWithObject:mobile] == YES)
        || ([regextestct evaluateWithObject:mobile] == YES)
        || ([regextestcu evaluateWithObject:mobile] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//随机字符串
+ (NSString*)randomString:(int)len {
    char* charSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    char* temp = malloc(len + 1);
    for (int i = 0; i < len; i++) {
        int randomPoz = (int) floor(arc4random() % strlen(charSet));
        temp[i] = charSet[randomPoz];
    }
    temp[len] = '\0';
    NSMutableString* randomString = [[NSMutableString alloc] initWithUTF8String:temp];
    free(temp);
    return randomString;
}
+ (NSString*)randomAnyRTCString:(int)len {
    char* charSet = "0123456789";
    char* temp = malloc(len + 1);
    for (int i = 0; i < len; i++) {
        int randomPoz = (int) floor(arc4random() % strlen(charSet));
        temp[i] = charSet[randomPoz];
    }
    temp[len] = '\0';
    NSMutableString* randomString = [[NSMutableString alloc] initWithUTF8String:temp];
    free(temp);
    return randomString;
}

/**
 * 将16进制颜色转换成UIColor
 *
 **/
+(UIColor *)getColor:(NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip "0X" or "#" if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

//随机生成汉字
+ (NSMutableString*)randomCreatChinese:(NSInteger)count{
    
    NSMutableString*randomChineseString =@"".mutableCopy;
    
    for(NSInteger i=0; i < count; i++){
        
        NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        //随机生成汉字高位
        NSInteger randomH = 0xA1+arc4random()%(0xFE - 0xA1+1);
        
        //随机生成汉子低位
        NSInteger randomL =0xB0+arc4random()%(0xF7 - 0xB0+1);
        
        //组合生成随机汉字
        NSInteger number = (randomH<<8)+randomL;
        
        NSData*data = [NSData dataWithBytes:&number length:2];
        
        NSString*string = [[NSString alloc]initWithData:data encoding:gbkEncoding];
        
        [randomChineseString appendString:string];
    }
    
    return randomChineseString;
    
}

/**
 *  关闭所有键盘
 */
+ (void)hideKeyBoard{
    for (UIWindow* window in [UIApplication sharedApplication].windows)
    {
        for (UIView* view in window.subviews)
        {
            [self dismissAllKeyBoardInView:view];
        }
    }
}

+(BOOL) dismissAllKeyBoardInView:(UIView *)view
{
    if([view isFirstResponder])
    {
        [view resignFirstResponder];
        return YES;
    }
    for(UIView *subView in view.subviews)
    {
        if([self dismissAllKeyBoardInView:subView])
        {
            return YES;
        }
    }
    return NO;
}

+ (UIImage *)applyColoursDrawing:(UIImage *)image{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

// 拨打电话
+ (void)callPhone:(NSString *)phoneNum control:(UIButton *)sender{
    
    if (phoneNum.length == 0) {
        return;
    }
    sender.enabled = NO;
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNum];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:^(BOOL success) {
            
        }];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
}

//富文本
+ (NSMutableAttributedString *)getAttributedString:(NSString *)textStr imageSize:(CGRect)imageSize image:(UIImage *)image index:(NSInteger)index{
    if (textStr.length == 0) {
        return nil;
    }
    
    NSMutableAttributedString *attri =  [[NSMutableAttributedString alloc] initWithString:textStr];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    //图片
    attch.image = image;
    //大小
    attch.bounds = imageSize;
    
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:index];
    return attri;
}

//比较给定NSDate与当前时间的时间差，返回相差的秒数
+ (long)timeDifference:(NSDate *)date
{
    NSDate *localeDate = [NSDate date];
    //long difference =fabs([localeDate timeIntervalSinceDate:date]);
    long difference = [localeDate timeIntervalSinceDate:date];
    return difference;
}

//传入 秒  得到  xx分钟xx秒
+ (NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02zd",seconds/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02zd",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    return format_time;
}

//得到从1970年到现在的秒数
+(long)getSecondsSince1970 {
    NSTimeInterval time =[[NSDate date] timeIntervalSince1970];
    long second = time;
    return second;
}

//转换从1970年到现在的秒数为年月日
+ (NSString *)timeFormatted:(NSString *)totalSeconds
{
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:[totalSeconds intValue]];
    NSTimeZone *zone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //yyyy-MM-dd a HH:mm:ss EEEE
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * str = [NSString stringWithFormat:@"%@",localeDate];
    str = [formatter stringFromDate:localeDate];
    return str;
}

//字符串包含
+ (BOOL)isStringContains:(NSString *)str string:(NSString *)smallStr{
    if ([str rangeOfString:smallStr].location == NSNotFound) {
        return NO;
    }
    return YES;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    return currentVC;
}

+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (void)basicAnimation:(UIView *)animView{
    CABasicAnimation *animation;
    animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration=1;
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.0];
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [animView.layer addAnimation:animation forKey:@"animateOpacity"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [animView removeFromSuperview];
    });
}

+ (NSString *)getErrorInfoWithCode:(int)code {
    switch (code) {
        case ARP2P_OK: return @"对方挂断通话";
            
        case ARP2P_PEER_BUSY: return @"对方忙";
            
        case ARP2P_OFFLINE: return @"对方不在线";
        
        case ARP2P_NOT_SELF: return @"不能呼叫自己";
        
        case ARP2P_EXP_OFFLINE: return @"通话中对方意外掉线";
        
        case ARP2P_EXP_EXIT: return @"对方异常退出";

        case ARP2P_TIMEOUT: return @"呼叫超时";

        case ARP2P_NOT_SURPPORT: return @"被呼叫方只支持Android";
        
        case 203: return @"开发者配置信息错误";
        
        default:  return @"未知错误";
        break;
    }
}

@end
