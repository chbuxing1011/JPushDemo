//
//  Data.h
//
//  Created by user  on 14-10-14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : BaseEntity

@property (nonatomic, strong) NSString *context;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *ftime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
