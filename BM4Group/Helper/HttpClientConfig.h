//
//  HttpClientConfig.h
//  ProjectStructure
//
//  Created by 陈宇 on 15/12/20.
//
//

#import <Foundation/Foundation.h>

@interface HttpClientConfig : NSObject

/**
 *  根URL，后拼接接口地址。
 */
@property (nonatomic, copy) NSURL *baseURL;

/**
 *  统一的超时时间设置。默认15s。
 */
@property (nonatomic, assign) NSTimeInterval timeout;

/**
 *  服务器反悔成功的status码。默认为0；
 */
@property (nonatomic, assign) NSInteger successStatus;

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
+ (instancetype)new DEPRECATED_ATTRIBUTE;

/**
 *  不要使用此方法创建对象。
 *
 *  @return nil
 */
- (instancetype)init DEPRECATED_ATTRIBUTE;

@end
