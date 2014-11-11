//
//  KuaiDi.m
//
//  Created by user  on 14-10-14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "KuaiDi.h"
#import "Data.h"


NSString *const kKuaiDiStatus = @"status";
NSString *const kKuaiDiNu = @"nu";
NSString *const kKuaiDiIscheck = @"ischeck";
NSString *const kKuaiDiCondition = @"condition";
NSString *const kKuaiDiData = @"data";
NSString *const kKuaiDiMessage = @"message";
NSString *const kKuaiDiCom = @"com";
NSString *const kKuaiDiState = @"state";


@interface KuaiDi ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation KuaiDi

@synthesize status = _status;
@synthesize nu = _nu;
@synthesize ischeck = _ischeck;
@synthesize condition = _condition;
@synthesize data = _data;
@synthesize message = _message;
@synthesize com = _com;
@synthesize state = _state;


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
            self.status = [self objectOrNilForKey:kKuaiDiStatus fromDictionary:dict];
            self.nu = [self objectOrNilForKey:kKuaiDiNu fromDictionary:dict];
            self.ischeck = [self objectOrNilForKey:kKuaiDiIscheck fromDictionary:dict];
            self.condition = [self objectOrNilForKey:kKuaiDiCondition fromDictionary:dict];
    NSObject *receivedData = [dict objectForKey:kKuaiDiData];
    NSMutableArray *parsedData = [NSMutableArray array];
    if ([receivedData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedData addObject:[Data modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedData isKindOfClass:[NSDictionary class]]) {
       [parsedData addObject:[Data modelObjectWithDictionary:(NSDictionary *)receivedData]];
    }

    self.data = [NSArray arrayWithArray:parsedData];
            self.message = [self objectOrNilForKey:kKuaiDiMessage fromDictionary:dict];
            self.com = [self objectOrNilForKey:kKuaiDiCom fromDictionary:dict];
            self.state = [self objectOrNilForKey:kKuaiDiState fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kKuaiDiStatus];
    [mutableDict setValue:self.nu forKey:kKuaiDiNu];
    [mutableDict setValue:self.ischeck forKey:kKuaiDiIscheck];
    [mutableDict setValue:self.condition forKey:kKuaiDiCondition];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kKuaiDiData];
    [mutableDict setValue:self.message forKey:kKuaiDiMessage];
    [mutableDict setValue:self.com forKey:kKuaiDiCom];
    [mutableDict setValue:self.state forKey:kKuaiDiState];

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

    self.status = [aDecoder decodeObjectForKey:kKuaiDiStatus];
    self.nu = [aDecoder decodeObjectForKey:kKuaiDiNu];
    self.ischeck = [aDecoder decodeObjectForKey:kKuaiDiIscheck];
    self.condition = [aDecoder decodeObjectForKey:kKuaiDiCondition];
    self.data = [aDecoder decodeObjectForKey:kKuaiDiData];
    self.message = [aDecoder decodeObjectForKey:kKuaiDiMessage];
    self.com = [aDecoder decodeObjectForKey:kKuaiDiCom];
    self.state = [aDecoder decodeObjectForKey:kKuaiDiState];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kKuaiDiStatus];
    [aCoder encodeObject:_nu forKey:kKuaiDiNu];
    [aCoder encodeObject:_ischeck forKey:kKuaiDiIscheck];
    [aCoder encodeObject:_condition forKey:kKuaiDiCondition];
    [aCoder encodeObject:_data forKey:kKuaiDiData];
    [aCoder encodeObject:_message forKey:kKuaiDiMessage];
    [aCoder encodeObject:_com forKey:kKuaiDiCom];
    [aCoder encodeObject:_state forKey:kKuaiDiState];
}

- (id)copyWithZone:(NSZone *)zone
{
    KuaiDi *copy = [[KuaiDi alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.nu = [self.nu copyWithZone:zone];
        copy.ischeck = [self.ischeck copyWithZone:zone];
        copy.condition = [self.condition copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.message = [self.message copyWithZone:zone];
        copy.com = [self.com copyWithZone:zone];
        copy.state = [self.state copyWithZone:zone];
    }
    
    return copy;
}


@end
