//
//  ArUserManager.m
//  RTMPCDemo
//
//  Created by 余生丶 on 2019/4/12.
//  Copyright © 2019 anyRTC. All rights reserved.
//

#import "ArUserManager.h"

#define Ar_Userinfo @"Ar_Userinfo"

@implementation ArUserInfo

MJCodingImplementation

- (instancetype)initWithName:(NSString *)nickname userId:(NSString *)userId {
    if (self = [super init]) {
        self.nickname = nickname;
        self.userid = userId;
    }
    return self;
}
@end

@implementation ArUserManager

+ (void)saveUserInfo:(ArUserInfo *)info {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:Ar_Userinfo];
    [NSKeyedArchiver archiveRootObject:info toFile:filePath];
}

+ (ArUserInfo *)getUserInfo {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:Ar_Userinfo];
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (void)removeUserInfo {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:Ar_Userinfo];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        [manager removeItemAtPath:filePath error:nil];
    }
}

@end
