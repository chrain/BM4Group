//
//  HttpClient.h
//  ProjectStructure
//
//  Created by 陈宇 on 15/11/13.
//
//

#if __has_include(<AFNetworking/AFNetworking.h>)

#import <Foundation/Foundation.h>
#import "HttpClientConfig.h"
#import "BMRequest.h"
#import "BMResponse.h"
#import "AFNetworking.h"
#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
#import <ReactiveCocoa/ReactiveCocoa.h>
#endif

FOUNDATION_EXTERN NSString *const kHttpClientErrorDomain;

typedef void(^finishBlock)(BMResponse *response);

@interface HttpClient : NSObject

@property (nonatomic, strong, readonly) AFHTTPSessionManager *manager;

+ (instancetype)sharedInstance;

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
- (RACSignal *)get:(BMRequest *)request;

- (RACSignal *)post:(BMRequest *)request;

- (RACSignal *)uploadWith:(BMRequest *)request;
#else
- (NSURLSessionTask *)get:(BMRequest *)request finish:(finishBlock)reponse;

- (NSURLSessionTask *)post:(BMRequest *)request finish:(finishBlock)reponse;

- (NSURLSessionTask *)uploadWith:(BMRequest *)request finish:(finishBlock)reponse;
#endif

@end

#endif
