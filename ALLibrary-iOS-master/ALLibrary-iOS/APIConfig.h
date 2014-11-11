//
//  APIConfig.h
//  ZLYDoc
//  API信息
//  Created by Ryan on 14-4-14.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVER_AUTH_USERNAME @"5a9d519e0779dce27b30ef6f"
#define SERVER_AUTH_PASSWORD @"76456e7a2e6ddf03d4fe357b"

/***************是否需要鉴权：1、需要 0、不需要***************/
#define SERVER_AUTH_ISNEEDAUTH 1

/***************SERVER HOST***************/

#define SERVER_HOST @"http://www.kuaidi100.com/"

/***************是否打开本地测试环境***************/
#define LOCAL_SERVER_ISOPEN NO

/***************SERVER API***************/
//登录
#define API_LOGIN @"query"

//============================鉴权用户名和密码============================
#define kAUTH_USERNAME @"epro"
#define kAUTH_PASSWORD @""

//============================NAMES============================
#define kSOAP_XMLNS_NAME @"http://api.dealextreme.com/mobile/2010"

//============================请求方法============================
#define kSOAP_METHOD_AUTH @"Authenticate"
#define KSOAP_METHOD_GETPROMOTIONSBYTIMESTAMP @"GetPromotionsByTimestamp"

//============================接口地址============================
#define kSOAP_URL_AUTH \
@"https://api.dealextreme.com/mobilev2/developerservice.asmx"
#define kSOAP_URL_PRODUCT \
@"http://api.dealextreme.com/mobilev2/productservice.asmx"

//============================参数键============================
#define kSOAP_PARAM_AUTH_ACCOUNT @"account"
#define kSOAP_PARAM_AUTH_PASSWORD @"password"
#define kSOAP_PARAM_GETPROMOTIONSBYTIMESTAMP_COUNT @"count"
#define kSOAP_RETURN_STATUS @"Status"

//============================错误码============================
#define kERROR_STATUS_SESSTION_TIME_OUT @"13"

@interface APIConfig : NSObject

+ (APIConfig *)manager;

- (NSString *)getAPIURL:(NSString *)apiName;
@end
