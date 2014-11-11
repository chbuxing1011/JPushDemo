//
//  ALNanoStore.h
//  iPhoneTest
//
//  Created by chendong on 14-10-15.
//
//

#import <Foundation/Foundation.h>
#import "NSFNanoObject.h"

typedef void (^CompleteHandlerBlock)(BOOL issuccess, NSError *error);
typedef void (^SearchHandlerBlock)(NSArray *array, NSError *error);
@interface ALNanoStore : NSObject {
}
/**
 *  创建单例
 *
 *  @return return value ALNanoStore object
 */
+ (instancetype)shareALNanoStore;
/**
 *  保存对象
 *
 *  @param object         object 对象
 *  @param completeHander completeHander description
 */
- (void)saveObject:(NSFNanoObject *)object
    completeHandler:(CompleteHandlerBlock)completeHander;

/**
 *  移除对象
 *
 *  @param nanoObject         对象
 *  @param completeHander completeHander description
 */
- (void)removeObject:(NSFNanoObject *)nanoObject
     completeHandler:(CompleteHandlerBlock)completeHander;

/**
 *  根据条件移除对象
 *
 *  @param conditionDic         conditionDic 对象条件
 *  @param classStr       class类型
 *  @param completeHander completeHander description
 */
- (void)removeObjectsWithCondition:(NSDictionary *)conditionDic
                   withClassString:(NSString *)classStr
                   completeHandler:(CompleteHandlerBlock)completeHander;

/**
 *  查询对象
 *
 *  @param conditionDic   查询条件
 *  @param classStr       class类型
 *  @param completeHander completeHander description
 */
- (void)searchObjects:(NSDictionary *)conditionDic
      withClassString:(NSString *)classStr
      completeHandler:(SearchHandlerBlock)completeHander;
/**
 *  删除所有对象，清空数据库
 *
 *  @param completeHander completeHander description
 */
- (void)removeAllObjectscompleteHandler:(CompleteHandlerBlock)completeHander;

@end
