//
//  Notification.h
//
//  Created by user  on 14-11-11
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ios;

@interface Notification : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) Ios *ios;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
