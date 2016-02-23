//
//  StoreUtility.h
//  ProjectStructure
//
//  Created by 陈宇 on 15/12/5.
//
//  持久化存储工具类

#import <Foundation/Foundation.h>

/**
 *  总共分为两种方式：
 *  1:第一种直接存在Document/store下。
 *  2:第二种直接存在Document/store/(当前登录用户name)下。
 */
@interface StoreUtility <T> : NSObject

#pragma mark - 存储相关
+ (BOOL)storeToRootDirectory:(T)data key:(NSString *)key;
+ (BOOL)storeToUserDirectory:(T)data key:(NSString *)key;

#pragma mark - 提取相关
+ (T)fetchByRootDirectory:(NSString *)key;
+ (T)fetchByUserDirectory:(NSString *)key;

#pragma mark - 删除相关
+ (BOOL)deleteRootPatByKey:(NSString *)key;
+ (BOOL)deleteUserPathByKey:(NSString *)key;

@end
