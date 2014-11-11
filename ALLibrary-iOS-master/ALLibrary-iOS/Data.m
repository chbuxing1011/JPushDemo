//
//  Data.m
//
//  Created by user  on 14-10-14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Data.h"


NSString *const kDataContext = @"context";
NSString *const kDataTime = @"time";
NSString *const kDataFtime = @"ftime";


@interface Data ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Data

@synthesize context = _context;
@synthesize time = _time;
@synthesize ftime = _ftime;


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
            self.context = [self objectOrNilForKey:kDataContext fromDictionary:dict];
            self.time = [self objectOrNilForKey:kDataTime fromDictionary:dict];
            self.ftime = [self objectOrNilForKey:kDataFtime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.context forKey:kDataContext];
    [mutableDict setValue:self.time forKey:kDataTime];
    [mutableDict setValue:self.ftime forKey:kDataFtime];

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

    self.context = [aDecoder decodeObjectForKey:kDataContext];
    self.time = [aDecoder decodeObjectForKey:kDataTime];
    self.ftime = [aDecoder decodeObjectForKey:kDataFtime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_context forKey:kDataContext];
    [aCoder encodeObject:_time forKey:kDataTime];
    [aCoder encodeObject:_ftime forKey:kDataFtime];
}

- (id)copyWithZone:(NSZone *)zone
{
    Data *copy = [[Data alloc] init];
    
    if (copy) {

        copy.context = [self.context copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.ftime = [self.ftime copyWithZone:zone];
    }
    
    return copy;
}


@end
