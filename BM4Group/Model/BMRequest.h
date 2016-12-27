//
//  BMRequest.h
//  ProjectStructure
//
//  Created by 陈宇 on 15/12/1.
//
//

#import "BMBaseModel.h"

@protocol AFMultipartFormData;

typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);

typedef NS_ENUM(NSUInteger, BMRequestMethod) {
    BMRequestMethodGET,
    BMRequestMethodPOST,
};

typedef NS_ENUM(NSUInteger, BMRequestSerializerType) {
    BMRequestSerializerTypeHTTP,
    BMRequestSerializerTypeJSON,
};


@interface BMRequest : BMBaseModel

/**
 *  请求的路径，除去配置的baseURL。
 */
@property (nonatomic, copy) NSString *requestPath;

/**
 *  请求的方法，默认为POST。
 */
@property (nonatomic, assign) BMRequestMethod requestMethod;

/**
 *  参数发送到服务器的形式。
 */
@property (nonatomic, assign) BMRequestSerializerType requestSerializerType;

/**
 *  HTTP头中添加的自定义参数
 */
@property (nonatomic, strong) NSDictionary *requestHeaderFields;

/**
 *  请求参数。
 */
@property (nonatomic, strong) id requestParams;

/**
 *  发送文件到服务器使用
 */
@property (nonatomic, copy) AFConstructingBlock requestConstructingBodyBlock;

/**
 *  请求超时时间。
 */
@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval;

/**
 *  是否忽略缓存,直接请求新数据。
 */
@property (nonatomic, assign) BOOL ignoreCache;

/**
 *  服务器返回的结果直接在result里
 *
 *  @param path 接口路径
 *
 *  @return 返回该请求对象
 */
+ (instancetype)requestWithPath:(NSString *)path;

/// 添加当前接口过滤的Hook
- (void)addIgonreHookClass:(Class)clazz;

- (BOOL)shouldIgnoreHookClass:(Class)clazz;

@end
