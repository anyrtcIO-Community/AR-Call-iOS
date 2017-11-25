//
//  ATHistoryModel.m
//  P2PDemo
//
//  Created by jh on 2017/11/8.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "ATHistoryModel.h"

@implementation ATHistoryModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.phoneStr = [aDecoder decodeObjectForKey:@"phoneStr"];
        self.timer = [aDecoder decodeObjectForKey:@"timer"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.callMode = [[aDecoder decodeObjectForKey:@"callMode"] intValue];
        self.state = [aDecoder decodeObjectForKey:@"state"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.phoneStr forKey:@"phoneStr"];
    [aCoder encodeObject:self.timer forKey:@"timer"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.callMode] forKey:@"callMode"];
    [aCoder encodeObject:self.state forKey:@"state"];
}

@end
