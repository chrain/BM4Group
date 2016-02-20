//
//  HttpClient.h
//  ProjectStructure
//
//  Created by 陈宇 on 15/11/13.
//
//

#if __has_include(<AFNetworking/AFNetworking.h>)

#import <Foundation/Foundation.h>
#import "BMRequest.h"
#import "BMResponse.h"
#import "AFNetworking.h"

FOUNDATION_EXTERN NSString *const kHttpClientErrorDomain;

typedef void(^finishBlock)(BMResponse *response);

@interface HttpClient : NSObject

@property (nonatomic, strong, readonly) AFHTTPSessionManager *manager;

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)get:(BMRequest *)request finish:(finishBlock)reponse;

- (NSURLSessionTask *)post:(BMRequest *)request finish:(finishBlock)reponse;

- (NSURLSessionTask *)uploadWith:(BMRequest *)request finish:(finishBlock)reponse;

@end

#endif
