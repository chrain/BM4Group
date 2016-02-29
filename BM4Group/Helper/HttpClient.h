//
//  HttpClient.h
//  ProjectStructure
//
//  Created by 陈宇 on 15/11/13.
//
//

#if __has_include(<AFNetworking/AFNetworking.h>)

#import "BMRequest.h"
#import "BMResponse.h"
#import "AFNetworking.h"

FOUNDATION_EXTERN NSString *const kHttpClientErrorDomain;

typedef void (^finishBlock)(BMResponse *response);
typedef void (^failureHandler)(NSError *error);


@interface HttpClient : NSObject

@property (nonatomic, strong, readonly) AFHTTPSessionManager *manager;

/**
 *  根URL，后拼接接口地址。
 */
+ (void)setBaseURL:(NSString *)baseURL;

/**
 *  设置服务器返回数据正确码。
 */
+ (void)setServerSuccessStatusCode:(NSInteger)successStatusCode;

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)startRequest:(BMRequest *)request finish:(finishBlock)finish failureHandler:(failureHandler)handler;

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

@end

@protocol HttpClientHook <NSObject>

- (void)doBefore:(BMRequest *)requset;

- (void)doAfterEnd:(BMResponse *)response error:(NSError *)error;

@end


@interface HttpClient (Hook)

- (void)addHook:(id<HttpClientHook>)hook;

@end

#endif
