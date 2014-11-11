//
//  RTSoapClient.m
//  WSDLDEMO
//
//  Created by Allen on 14-10-28.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "RTSoapClient.h"
#import "XMLParser.h"

@interface RTSoapClient ()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation RTSoapClient
@synthesize manager;

- (id)init {
    if (self = [super init]) {
        self.manager = [AFHTTPRequestOperationManager manager];
        self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        [self.manager.requestSerializer setValue:@"text/xml; charset=utf-8"
                              forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

+ (RTSoapClient *)manager {
    static RTSoapClient *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{ instance = [[self alloc] init]; });
    return instance;
}

- (void)requestWithPath:(NSString *)url
                 method:(NSString *)method
             parameters:(NSDictionary *)parameters
                success:(void (^)(AFHTTPRequestOperation *operation,
                                  id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation,
                                  NSError *error))failure {
    //转换请求体
    NSString *reqMsg = [self requestBody:parameters method:method];
    
    [self.manager.requestSerializer
     setQueryStringSerializationWithBlock:
     ^NSString * (NSURLRequest *request, NSDictionary *parameters,
                  NSError *__autoreleasing *error) { return reqMsg; }];
    
    [manager  POST:url
        parameters:reqMsg
           success: ^(AFHTTPRequestOperation *operation, id responseObject) {
               NSString *response =
               [[NSString alloc] initWithData:(NSData *)responseObject
                                     encoding:NSUTF8StringEncoding];
               
               //返回的消息体是包含XML的JSON字符串，通过XMLPARSER把XML完全转换成JSON
               NSData *xmlData = [response dataUsingEncoding:NSUTF8StringEncoding];
               XMLParser *xmlParser = [[XMLParser alloc] init];
               [xmlParser parseData:xmlData
                            success: ^(id parsedData) {
                                NSString *result = [self stringWithResultXML:parsedData];
                                NSData *resultData =
                                [result dataUsingEncoding:NSUTF8StringEncoding];
                                NSMutableDictionary *dic = [NSJSONSerialization
                                                            JSONObjectWithData:resultData
                                                            options:NSJSONReadingAllowFragments
                                                            error:nil];
                                
                                int status =
                                [[dic objectForKey:kSOAP_RETURN_STATUS] integerValue];
                                if (status ==
                                    [kERROR_STATUS_SESSTION_TIME_OUT integerValue]) {
                                    NSMutableDictionary *authParam =
                                    [[NSMutableDictionary alloc] init];
                                    [authParam setObject:kAUTH_USERNAME
                                                  forKey:kSOAP_PARAM_AUTH_ACCOUNT];
                                    [authParam setObject:kAUTH_PASSWORD
                                                  forKey:kSOAP_PARAM_AUTH_PASSWORD];
                                    
                                    [self requestWithPath:kSOAP_URL_AUTH
                                                   method:kSOAP_METHOD_AUTH
                                               parameters:authParam
                                                  success: ^(AFHTTPRequestOperation *operation,
                                                             id responseObject) {
                                                      [self requestWithPath:url
                                                                     method:method
                                                                 parameters:parameters
                                                                    success: ^(AFHTTPRequestOperation *operation,
                                                                               id responseObject) {
                                                                        success(operation, responseObject);
                                                                    }
                                                       
                                                                    failure: ^(AFHTTPRequestOperation *operation,
                                                                               NSError *error) {
                                                                        failure(operation, error);
                                                                    }];
                                                  }
                                     
                                                  failure: ^(AFHTTPRequestOperation *operation,
                                                             NSError *error) {
                                                      NSString *response = [[NSString alloc]
                                                                            initWithData:(NSData *)
                                                                            [operation responseObject]
                                                                            encoding:NSUTF8StringEncoding];
                                                      NSLog(@"%@, %@, %@", operation, response, error);
                                                  }];
                                }
                                else {
                                    success(operation, dic);
                                }
                            }
                
                            failure: ^(NSError *error) {}];
           }
     
           failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
               failure(operation, error);
           }];
}

/**
 *  根据返回的XML结节，递归获取CONTENT的值
 *
 *  @param dic 根据XML转换成的Dic
 *
 *  @return 返回参数
 */
- (NSString *)stringWithResultXML:(NSDictionary *)dic {
    NSString *result = nil;
    NSArray *array = [dic allKeys];
    for (NSString *key in array) {
        id object = [dic objectForKey:key];
        if ([object isKindOfClass:[NSDictionary class]]) {
            result = [self stringWithResultXML:object];
        }
        else {
            if ([key isEqualToString:@"content"]) {
                result = object;
            }
        }
    }
    
    return result;
}

/**
 *  根据参数生成请求体
 *
 *  @param param  请求参数
 *  @param method 请求方法
 *
 *  @return 添加请求体
 */
- (NSString *)requestBody:(NSDictionary *)param method:(NSString *)method {
    NSMutableString *soapReq = [[NSMutableString alloc] init];
    [soapReq appendString:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope "];
    [soapReq
     appendString:@"xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "];
    [soapReq appendString:@"xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "];
    [soapReq appendString:
     @"xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" "];
    [soapReq appendFormat:@"xmlns=\"%@\"><soap:Body>", kSOAP_XMLNS_NAME];
    [soapReq appendFormat:@"<%@ xmlns=\"%@\">", method, kSOAP_XMLNS_NAME];
    NSArray *allkeys = [param allKeys];
    for (NSString *key in allkeys) {
        [soapReq appendFormat:@"<%@>%@</%@>", key, [param objectForKey:key], key];
    }
    [soapReq appendFormat:@"</%@>", method];
    [soapReq appendString:@"</soap:Body></soap:Envelope>"];
    
    return soapReq;
}

@end
