//
//  ATNetWorkTool.m
//  P2PDemo
//
//  Created by jh on 2017/11/20.
//  Copyright © 2017年 jh. All rights reserved.
//

#import "ATNetWorkTool.h"

@implementation ATNetWorkTool

+ (ATNetWorkTool *)sharedManager{
    static ATNetWorkTool *shareManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        shareManager = [[self alloc]init];
    });
    return shareManager;
}

-(AFHTTPRequestOperationManager *)baseHttpRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置网络请求为忽略本地缓存  直接请求服务器
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    return manager;
}

- (void)postSendVercode:(NSDictionary *)info url:(NSString *)url successBlock:(SucessBlock)successBlock{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    url  = [NSString stringWithFormat:@"%@%@",requestUrl,url];
    
    [manager POST:url parameters:info success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = (NSDictionary *)[ATCommon fromJsonStr:responseString];
        successBlock(dict);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        NSLog(@"%@",errorStr);
        [XHToast showCenterWithText:@"网络异常"];
    }];
}

- (void)postCheckVercode:(NSDictionary *)info url:(NSString *)url successBlock:(SucessBlock)successBlock{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    url  = [NSString stringWithFormat:@"%@%@",requestUrl,url];
    
    [manager POST:url parameters:info success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = (NSDictionary *)[ATCommon fromJsonStr:responseString];
        successBlock(dict);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        NSLog(@"%@",errorStr);
        [XHToast showCenterWithText:@"网络异常"];
    }];
}

@end
