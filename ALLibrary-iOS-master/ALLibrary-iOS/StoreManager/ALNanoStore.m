//
//  ALNanoStore.m
//  iPhoneTest
//
//  Created by chendong on 14-10-15.
//
// https://github.com/tciuro/NanoStore

#import "ALNanoStore.h"

#import "NanoStore.h"
#import "NSFNanoGlobals_Private.h"
#import "BaseEntity.h"
#import "KuaiDi.h"

@interface ALNanoStore () {
  NSFNanoStore *m_nanoStore;
}
@end

@implementation ALNanoStore

static ALNanoStore *s_ALNanoStore = nil;
+ (instancetype)shareALNanoStore {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
      s_ALNanoStore = [[self alloc] init];

  });
  return s_ALNanoStore;
}

- (instancetype)init {
  if (self = [super init]) {
    NSString *docs = [NSSearchPathForDirectoriesInDomains(
        NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docs stringByAppendingPathComponent:@"nanostore.sqlite"];
    NSLog(@"path: %@", path);

    NSError *outError = nil;

    m_nanoStore =
        [NSFNanoStore createAndOpenStoreWithType:NSFPersistentStoreType
                                            path:path
                                           error:&outError];
  }
  return self;
}

- (void)dealloc {
  NSError *outError = nil;
  [m_nanoStore closeWithError:&outError];
}
/**
 *  保存对象
 *
 *  @param object         object 对象
 *  @param completeHander completeHander description
 */
- (void)saveObject:(NSFNanoObject *)object
    completeHandler:(CompleteHandlerBlock)completeHander {

  NSError *outError = nil;

  BOOL isSuccess = [m_nanoStore addObject:object error:&outError];
  BOOL isSaved = NO;
  if (isSuccess) {
    isSaved = [m_nanoStore saveStoreAndReturnError:&outError];
  }
  completeHander(isSuccess && isSaved, outError);
}

/**
 *  移除对象
 *
 *  @param nanoObject         对象
 *  @param completeHander completeHander description
 */
- (void)removeObject:(NSFNanoObject *)nanoObject
     completeHandler:(CompleteHandlerBlock)completeHander {
  NSError *outError;
  BOOL success = [m_nanoStore removeObject:nanoObject error:&outError];
  completeHander(success, outError);
}

/**
 *  根据条件移除对象
 *
 *  @param conditionDic         conditionDic 对象条件
 *  @param completeHander completeHander description
 */
- (void)removeObjectsWithCondition:(NSDictionary *)conditionDic
                   withClassString:(NSString *)classStr
                   completeHandler:(CompleteHandlerBlock)completeHander {
  NSFNanoSearch *search = [NSFNanoSearch searchWithStore:m_nanoStore];
  NSMutableArray *experssionArray = [NSMutableArray new];
  for (NSString *conditionKey in [conditionDic allKeys]) {
    NSFNanoPredicate *attribete =
        [NSFNanoPredicate predicateWithColumn:NSFAttributeColumn
                                     matching:NSFEqualTo
                                        value:conditionKey];
    NSFNanoPredicate *value = [NSFNanoPredicate
        predicateWithColumn:NSFValueColumn
                   matching:NSFEqualTo
                      value:[conditionDic objectForKey:conditionKey]];

    NSFNanoExpression *expression =
        [NSFNanoExpression expressionWithPredicate:attribete];
    [expression addPredicate:value withOperator:NSFAnd];
    [experssionArray addObject:expression];
  }
  [search setExpressions:[NSArray arrayWithArray:experssionArray]];
  [search setFilterClass:classStr];

  NSError *outError = nil;
  // Obtain the matching objects
  NSArray *matchingKeys =
      [search searchObjectsWithReturnType:NSFReturnKeys error:&outError];
  NSLog(@"searchKeyResults: %@", matchingKeys);

  // Remove the NanoObjects matching the selected UUIDs

  if (YES ==
      [m_nanoStore removeObjectsWithKeysInArray:matchingKeys error:&outError]) {
    completeHander(YES, outError);
    NSLog(@"The matching objects have been removed.");
  } else {
    completeHander(NO, outError);
    NSLog(@"An error has occurred while removing the matching objects. Reason: "
          @"%@",
          [outError localizedDescription]);
  }
}
/**
 *  查询对象
 *
 *  @param conditionDic   查询条件
 *  @param completeHander completeHander description
 */
- (void)searchObjects:(NSDictionary *)conditionDic
      withClassString:(NSString *)classStr
      completeHandler:(SearchHandlerBlock)completeHander {
  NSFNanoSearch *search = [NSFNanoSearch searchWithStore:m_nanoStore];
  NSMutableArray *experssionArray = [NSMutableArray new];
  for (NSString *conditionKey in [conditionDic allKeys]) {
    NSFNanoPredicate *attribete =
        [NSFNanoPredicate predicateWithColumn:NSFAttributeColumn
                                     matching:NSFEqualTo
                                        value:conditionKey];
    NSFNanoPredicate *value = [NSFNanoPredicate
        predicateWithColumn:NSFValueColumn
                   matching:NSFEqualTo
                      value:[conditionDic objectForKey:conditionKey]];

    NSFNanoExpression *expression =
        [NSFNanoExpression expressionWithPredicate:attribete];
    [expression addPredicate:value withOperator:NSFAnd];
    [experssionArray addObject:expression];
  }
  [search setExpressions:[NSArray arrayWithArray:experssionArray]];
  [search setFilterClass:classStr];

  NSError *outError = nil;
  // Obtain the matching objects
  NSDictionary *searchResults =
      [search searchObjectsWithReturnType:NSFReturnObjects error:&outError];
  NSLog(@"searchResults: %@", searchResults);

  NSMutableArray *nanoObjectArr = [[NSMutableArray alloc] initWithCapacity:0];
  for (NSString *key in searchResults) {
    NSFNanoObject *object = [searchResults objectForKey:key];
    NSLog(@"key: %@, object: %@", key, object.info);
    if ([object isKindOfClass:[BaseEntity class]]) {
      [(BaseEntity *)object modelObjectWithDic:object.info];

      [nanoObjectArr addObject:object];
    };
  }
  completeHander(nanoObjectArr, outError);
}

/**
 *  删除所有对象，清空数据库
 *
 *  @param completeHander completeHander description
 */
- (void)removeAllObjectscompleteHandler:(CompleteHandlerBlock)completeHander {
  NSError *outError;
  BOOL isSuccess =
      [m_nanoStore removeAllObjectsFromStoreAndReturnError:&outError];
  completeHander(isSuccess, outError);
}
@end
