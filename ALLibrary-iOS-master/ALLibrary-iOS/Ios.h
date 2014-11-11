//
//  Ios.h
//
//  Created by user  on 14-11-11
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Ios : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *category;
@property (nonatomic, assign) double contentAvailable;
@property (nonatomic, strong) NSString *alert;
@property (nonatomic, assign) double badge;
@property (nonatomic, strong) NSString *sound;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
