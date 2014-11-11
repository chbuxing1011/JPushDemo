//
//  UserEntity.h
//
//  Created by Allen  on 14-10-10
//  Copyright (c) 2014 Epro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"

@interface UserEntity : BaseEntity <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *data;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
