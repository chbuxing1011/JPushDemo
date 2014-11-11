//
//  UserEntity.m
//
//  Created by Allen  on 14-10-10
//  Copyright (c) 2014 Epro. All rights reserved.
//

#import "UserEntity.h"

NSString *const kUserEntityStatus = @"status";
NSString *const kUserEntityMsg = @"msg";
NSString *const kUserEntityData = @"data";

@interface UserEntity ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserEntity

@dynamic status, msg, data;

//@synthesize status = _status;
//@synthesize msg = _msg;
//@synthesize data = _data;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.status =
        [self objectOrNilForKey:kUserEntityStatus fromDictionary:dict];
        self.msg = [self objectOrNilForKey:kUserEntityMsg fromDictionary:dict];
        self.data = [self objectOrNilForKey:kUserEntityData fromDictionary:dict];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kUserEntityStatus];
    [mutableDict setValue:self.msg forKey:kUserEntityMsg];
    [mutableDict setValue:self.data forKey:kUserEntityData];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.status = [aDecoder decodeObjectForKey:kUserEntityStatus];
    self.msg = [aDecoder decodeObjectForKey:kUserEntityMsg];
    self.data = [aDecoder decodeObjectForKey:kUserEntityData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.status forKey:kUserEntityStatus];
    [aCoder encodeObject:self.msg forKey:kUserEntityMsg];
    [aCoder encodeObject:self.data forKey:kUserEntityData];
}

- (id)copyWithZone:(NSZone *)zone {
    UserEntity *copy = [[UserEntity alloc] init];
    
    if (copy) {
        copy.status = [self.status copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}

@end
