//
//  JPushServer.h
//
//  Created by user  on 14-11-11
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Options, Notification;

@interface JPushServer : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *audience;
@property (nonatomic, strong) Options *options;
@property (nonatomic, strong) Notification *notification;
@property (nonatomic, strong) NSString *platform;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
