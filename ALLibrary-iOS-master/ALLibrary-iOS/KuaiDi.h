//
//  KuaiDi.h
//
//  Created by user  on 14-10-14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KuaiDi : BaseEntity

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *nu;
@property (nonatomic, strong) NSString *ischeck;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *com;
@property (nonatomic, strong) NSString *state;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
