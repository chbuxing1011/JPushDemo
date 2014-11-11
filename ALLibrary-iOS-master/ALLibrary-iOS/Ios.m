//
//  Ios.m
//
//  Created by user  on 14-11-11
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Ios.h"


NSString *const kIosCategory = @"category";
NSString *const kIosContentAvailable = @"content-available";
NSString *const kIosAlert = @"alert";
NSString *const kIosBadge = @"badge";
NSString *const kIosSound = @"sound";


@interface Ios ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Ios

@synthesize category = _category;
@synthesize contentAvailable = _contentAvailable;
@synthesize alert = _alert;
@synthesize badge = _badge;
@synthesize sound = _sound;


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
            self.category = [self objectOrNilForKey:kIosCategory fromDictionary:dict];
            self.contentAvailable = [[self objectOrNilForKey:kIosContentAvailable fromDictionary:dict] doubleValue];
            self.alert = [self objectOrNilForKey:kIosAlert fromDictionary:dict];
            self.badge = [[self objectOrNilForKey:kIosBadge fromDictionary:dict] doubleValue];
            self.sound = [self objectOrNilForKey:kIosSound fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.category forKey:kIosCategory];
    [mutableDict setValue:[NSNumber numberWithDouble:self.contentAvailable] forKey:kIosContentAvailable];
    [mutableDict setValue:self.alert forKey:kIosAlert];
    [mutableDict setValue:[NSNumber numberWithDouble:self.badge] forKey:kIosBadge];
    [mutableDict setValue:self.sound forKey:kIosSound];

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

    self.category = [aDecoder decodeObjectForKey:kIosCategory];
    self.contentAvailable = [aDecoder decodeDoubleForKey:kIosContentAvailable];
    self.alert = [aDecoder decodeObjectForKey:kIosAlert];
    self.badge = [aDecoder decodeDoubleForKey:kIosBadge];
    self.sound = [aDecoder decodeObjectForKey:kIosSound];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_category forKey:kIosCategory];
    [aCoder encodeDouble:_contentAvailable forKey:kIosContentAvailable];
    [aCoder encodeObject:_alert forKey:kIosAlert];
    [aCoder encodeDouble:_badge forKey:kIosBadge];
    [aCoder encodeObject:_sound forKey:kIosSound];
}

- (id)copyWithZone:(NSZone *)zone
{
    Ios *copy = [[Ios alloc] init];
    
    if (copy) {

        copy.category = [self.category copyWithZone:zone];
        copy.contentAvailable = self.contentAvailable;
        copy.alert = [self.alert copyWithZone:zone];
        copy.badge = self.badge;
        copy.sound = [self.sound copyWithZone:zone];
    }
    
    return copy;
}


@end
