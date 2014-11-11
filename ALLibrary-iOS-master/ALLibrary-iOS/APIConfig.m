//
//  APIConfig.m
//  RTLibrary-ios
//
//  Created by user on 14-10-10.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIConfig.h"

@implementation APIConfig

+ (APIConfig *)manager {
    static APIConfig *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{ instance = [[self alloc] init]; });
    return instance;
}

- (NSString *)getAPIURL:(NSString *)apiName {
    NSString *absolutelyURL =
    [NSString stringWithFormat:@"%@%@", SERVER_HOST, apiName];
    return absolutelyURL;
}

@end
