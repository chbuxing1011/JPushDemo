//
//  BaseEntity.m
//  ZLYDoc
//
//  Created by Ryan on 14-4-3.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import "BaseEntity.h"

@implementation BaseEntity

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
  return nil;
}

/**
 *  根据返回值解析对象
 *
 *  @param dict
 *
 *  @return
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict {
  return nil;
}

/**
 *  根据对象生成字典
 *
 *
 *
 *  @return
 */
- (NSDictionary *)dictionaryRepresentation {
  return nil;
}

/**
 *  根据字典初始化
 *
 *  @param dict
 */
- (void)modelObjectWithDic:(NSDictionary *)dict {
}
@end
