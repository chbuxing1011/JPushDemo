//
//  RTSoapClient.h
//  WSDLDEMO
//
//  Created by Allen on 14-10-28.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "APIConfig.h"

@interface RTSoapClient : NSObject

/**
 *  RTSoapClient的单例调用
 *
 *  @return RTSoapClient的单例
 */
+ (RTSoapClient *)manager;

/**
 *  发送SOAP请求
 *
 *  @param url        请求地址
 *  @param method     请求方法
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
- (void)requestWithPath:(NSString *)url
                 method:(NSString *)method
             parameters:(NSDictionary *)parameters
                success:(void (^)(AFHTTPRequestOperation *operation,
                                  id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation,
                                  NSError *error))failure;
@end
