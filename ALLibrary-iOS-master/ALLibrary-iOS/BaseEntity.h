//
//  BaseEntity.h
//  ZLYDoc
//
//  Created by Ryan on 14-4-3.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSFNanoObject.h"
#define SUCCESS 0

@interface BaseEntity : NSFNanoObject

/**
 *  根据返回值解析对象
 *
 *  @param dict
 *
 *  @return
 */
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
/**
 *  根据返回值解析对象
 *
 *  @param dict
 *
 *  @return
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;

/**
 *  根据对象生成字典
 *
 *
 *
 *  @return
 */
- (NSDictionary *)dictionaryRepresentation;

/**
 *  根据字典初始化
 *
 *  @param dict
 */
- (void)modelObjectWithDic:(NSDictionary *)dict;
@end
