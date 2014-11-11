//
//  JPushServer.m
//
//  Created by user  on 14-11-11
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "JPushServer.h"
#import "Options.h"
#import "Notification.h"


NSString *const kJPushServerAudience = @"audience";
NSString *const kJPushServerOptions = @"options";
NSString *const kJPushServerNotification = @"notification";
NSString *const kJPushServerPlatform = @"platform";


@interface JPushServer ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JPushServer

@synthesize audience = _audience;
@synthesize options = _options;
@synthesize notification = _notification;
@synthesize platform = _platform;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.audience = [self objectOrNilForKey:kJPushServerAudience fromDictionary:dict];
            self.options = [Options modelObjectWithDictionary:[dict objectForKey:kJPushServerOptions]];
            self.notification = [Notification modelObjectWithDictionary:[dict objectForKey:kJPushServerNotification]];
            self.platform = [self objectOrNilForKey:kJPushServerPlatform fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.audience forKey:kJPushServerAudience];
    [mutableDict setValue:[self.options dictionaryRepresentation] forKey:kJPushServerOptions];
    [mutableDict setValue:[self.notification dictionaryRepresentation] forKey:kJPushServerNotification];
    [mutableDict setValue:self.platform forKey:kJPushServerPlatform];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.audience = [aDecoder decodeObjectForKey:kJPushServerAudience];
    self.options = [aDecoder decodeObjectForKey:kJPushServerOptions];
    self.notification = [aDecoder decodeObjectForKey:kJPushServerNotification];
    self.platform = [aDecoder decodeObjectForKey:kJPushServerPlatform];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_audience forKey:kJPushServerAudience];
    [aCoder encodeObject:_options forKey:kJPushServerOptions];
    [aCoder encodeObject:_notification forKey:kJPushServerNotification];
    [aCoder encodeObject:_platform forKey:kJPushServerPlatform];
}

- (id)copyWithZone:(NSZone *)zone
{
    JPushServer *copy = [[JPushServer alloc] init];
    
    if (copy) {

        copy.audience = [self.audience copyWithZone:zone];
        copy.options = [self.options copyWithZone:zone];
        copy.notification = [self.notification copyWithZone:zone];
        copy.platform = [self.platform copyWithZone:zone];
    }
    
    return copy;
}


@end
