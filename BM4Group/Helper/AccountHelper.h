//
//  AccountHelper.h
//  BM4GroupExample
//
//  Created by 陈宇 on 15/12/20.
//  Copyright © 2015年 陈宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BMBaseModel.h"

FOUNDATION_EXTERN NSString *const kCurrentUserKey;


@interface AccountHelper < T : BMBaseModel * > : NSObject

/**
 *  用户是否登录
 */
@property(nonatomic, assign, readonly, getter=isLogin) BOOL login;

/**
 *  当前登录的用户，必须实现NSCoding协议。
 */
@property (nonatomic, strong, readonly) T user;

/**
 *  手机定位位置。
 */
@property (nonatomic, strong, readonly) CLLocation *location;

/**
 *  请使用次方法获取实例，并网络请求前设置好相关配置。
 *
 *  @return Config对象。
 */
+ (instancetype)sharedInstance;

/**
 *  不要使用此方法创建对象。
 *
 *  @return nil
 */
+ (instancetype) new DEPRECATED_ATTRIBUTE;

/**
 *  不要使用此方法创建对象。
 *
 *  @return nil
 */
- (instancetype)init DEPRECATED_ATTRIBUTE;

/**
 *  退出登录
 *
 */
- (BOOL)logout;

@end
