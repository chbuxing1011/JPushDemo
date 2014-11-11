//
//  Notification.m
//
//  Created by user  on 14-11-11
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Notification.h"
#import "Ios.h"


NSString *const kNotificationIos = @"ios";


@interface Notification ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Notification

@synthesize ios = _ios;


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
            self.ios = [Ios modelObjectWithDictionary:[dict objectForKey:kNotificationIos]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.ios dictionaryRepresentation] forKey:kNotificationIos];

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

    self.ios = [aDecoder decodeObjectForKey:kNotificationIos];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_ios forKey:kNotificationIos];
}

- (id)copyWithZone:(NSZone *)zone
{
    Notification *copy = [[Notification alloc] init];
    
    if (copy) {

        copy.ios = [self.ios copyWithZone:zone];
    }
    
    return copy;
}


@end
