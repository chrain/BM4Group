//
//  HttpClient.m
//  ProjectStructure
//
//  Created by 陈宇 on 15/11/13.
//
//
#import "HttpClient.h"
#import "NSString+Exist.h"

#if __has_include(<AFNetworking/AFNetworking.h>)

NSString *const kHttpClientErrorDomain = @"com.chrain.errorDomain";

static HttpClient *_httpClient = nil;

@interface HttpClient ()

@property (nonatomic, strong, readwrite) AFHTTPSessionManager *manager;

@end

@implementation HttpClient

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _httpClient = [[HttpClient alloc] init];
    });
    return _httpClient;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = [HttpClientConfig sharedInstance].timeout;
        _manager= [[AFHTTPSessionManager alloc] initWithBaseURL:[HttpClientConfig sharedInstance].baseURL sessionConfiguration:configuration];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    }
    return self;
}

- (BMResponse *)responseWithJson:(id)responseObj {
    BMResponse *response = [BMResponse mj_objectWithKeyValues:responseObj];
    
    if (response.status != [HttpClientConfig sharedInstance].successStatus) {
        NSError *error = [NSError errorWithDomain:kHttpClientErrorDomain code:response.status userInfo:@{NSLocalizedDescriptionKey : [response.msg isExist] ? response.msg : @"出现未知错误了，请重试。"}];
        response.error = error;
        return response;
    }
    
    id result = responseObj[@"data"];
    
    if (result && ![result isKindOfClass:[NSNull class]] && [result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *pageDict = result[@"page"];
        if (pageDict) {
            response.page = [BMPage mj_objectWithKeyValues:pageDict];
        }
        response.rawResult = result;
        response.emptyResult = NO;
    } else {
        response.emptyResult = YES;
    }
    
    return response;
}

#pragma mark - ReactiveCocoa系列相关方法。
#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
- (RACSignal *)get:(BMRequest *)request {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        @strongify(self);
        NSURLSessionDataTask *task = [self.manager GET:request.path parameters:request.params success:^(NSURLSessionDataTask *_Nonnull task, id _Nonnull responseObject) {
            BMResponse *response = [self responseWithJson:responseObject];
            if (response.status != [HttpClientConfig sharedInstance].successStatus) {
                [subscriber sendError:response.error];
            } else {
                [subscriber sendNext:response];
                [subscriber sendCompleted];
            }
        } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (!responseData) {
                [subscriber sendError:error];
            } else {
                NSError *jsonError = nil;
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
                if (responseDict && [responseDict isKindOfClass:[NSDictionary class]]) {
                    BMResponse *response = [self responseWithJson:responseDict];
                    if (response.status != [HttpClientConfig sharedInstance].successStatus) {
                        [subscriber sendError:response.error];
                    } else {
                        [subscriber sendNext:response];
                        [subscriber sendCompleted];
                    }
                } else if (jsonError) {
                    [subscriber sendError:jsonError];
                } else {
                    [subscriber sendError:error];
                }
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            if (task.state != NSURLSessionTaskStateCompleted) {
                [task cancel];
            }
        }];
    }];
}

- (RACSignal *)post:(BMRequest *)request {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        @strongify(self);
        NSURLSessionDataTask *task = [self.manager POST:request.path parameters:request.params success:^(NSURLSessionDataTask *_Nonnull task, id _Nonnull responseObject) {
            BMResponse *response = [self responseWithJson:responseObject];
            if (response.status != [HttpClientConfig sharedInstance].successStatus) {
                [subscriber sendError:response.error];
            } else {
                [subscriber sendNext:response];
                [subscriber sendCompleted];
            }
        } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            if (!responseData) {
                [subscriber sendError:error];
            } else {
                NSError *jsonError = nil;
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
                if (responseDict && [responseDict isKindOfClass:[NSDictionary class]]) {
                    BMResponse *response = [self responseWithJson:responseDict];
                    if (response.status != [HttpClientConfig sharedInstance].successStatus) {
                        [subscriber sendError:response.error];
                    } else {
                        [subscriber sendNext:response];
                        [subscriber sendCompleted];
                    }
                } else if (jsonError) {
                    [subscriber sendError:jsonError];
                } else {
                    [subscriber sendError:error];
                }
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            if (task.state != NSURLSessionTaskStateCompleted) {
                [task cancel];
            }
        }];
    }];
}

- (RACSignal *)uploadWith:(BMRequest *)request {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        @strongify(self);
        NSURLSessionDataTask *task = [self.manager POST:request.path parameters:request.params constructingBodyWithBlock:^(id <AFMultipartFormData> _Nonnull formData) {
            [request.uploadData enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSData *obj, BOOL *stop) {
                if ([key hasPrefix:@"audio"]) {
                    [formData appendPartWithFileData:obj name:key fileName:@"a.amr" mimeType:@"audio/amr"];
                } else {
                    [formData appendPartWithFileData:obj name:key fileName:@"a.jpg" mimeType:@"image/jpeg"];
                }
            }];
        } success:^(NSURLSessionDataTask *_Nonnull task, id _Nonnull responseObject) {
            BMResponse *response = [self responseWithJson:responseObject];
            if (response.status != [HttpClientConfig sharedInstance].successStatus) {
                [subscriber sendError:response.error];
            } else {
                [subscriber sendNext:response];
                [subscriber sendCompleted];
            }
        } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            if (task.state != NSURLSessionTaskStateCompleted) {
                [task cancel];
            }
        }];
    }];
}
#else
- (NSURLSessionTask *)get:(BMRequest *)request finish:(finishBlock)reponse;
{
    @weakify(self);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    NSURLSessionDataTask *task = [self.manager GET:request.path parameters:request.params success:^(NSURLSessionDataTask *_Nonnull task, id _Nonnull responseObject) {
#pragma clang diagnostic pop
        @strongify(self);
        BMResponse *response = [self responseWithJson:responseObject];
        reponse(response);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        @strongify(self);
        NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (!responseData) {
            BMResponse *response = [BMResponse new];
            response.error = error;
            reponse(response);
        } else {
            NSError *jsonError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
            if (responseDict && [responseDict isKindOfClass:[NSDictionary class]]) {
                BMResponse *response = [self responseWithJson:responseDict];
                reponse(response);
            } else if (jsonError) {
                BMResponse *response = [BMResponse new];
                response.error = jsonError;
                reponse(response);
            } else {
                BMResponse *response = [BMResponse new];
                response.error = error;
                reponse(response);
            }
        }
    }];
    return task;
}

- (NSURLSessionTask *)post:(BMRequest *)request finish:(finishBlock)reponse;
{
    @weakify(self);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    NSURLSessionDataTask *task = [self.manager POST:request.path parameters:request.params success:^(NSURLSessionDataTask *_Nonnull task, id _Nonnull responseObject) {
#pragma clang diagnostic pop
        @strongify(self);
        BMResponse *response = [self responseWithJson:responseObject];
        reponse(response);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        @strongify(self);
        NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (!responseData) {
            BMResponse *response = [BMResponse new];
            response.error = error;
            reponse(response);
        } else {
            NSError *jsonError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
            if (responseDict && [responseDict isKindOfClass:[NSDictionary class]]) {
                BMResponse *response = [self responseWithJson:responseDict];
                reponse(response);
            } else if (jsonError) {
                BMResponse *response = [BMResponse new];
                response.error = jsonError;
                reponse(response);
            } else {
                BMResponse *response = [BMResponse new];
                response.error = error;
                reponse(response);
            }
        }
    }];
    return task;
}

- (NSURLSessionTask *)uploadWith:(BMRequest *)request finish:(finishBlock)reponse;
{
    @weakify(self);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    NSURLSessionDataTask *task = [self.manager POST:request.path parameters:request.params constructingBodyWithBlock:request.constrauctingBlock success:^(NSURLSessionDataTask *_Nonnull task, id _Nonnull responseObject) {
#pragma clang diagnostic pop
        @strongify(self);
        BMResponse *response = [self responseWithJson:responseObject];
        reponse(response);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        @strongify(self);
        NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (!responseData) {
            BMResponse *response = [BMResponse new];
            response.error = error;
            reponse(response);
        } else {
            NSError *jsonError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
            if (responseDict && [responseDict isKindOfClass:[NSDictionary class]]) {
                BMResponse *response = [self responseWithJson:responseDict];
                reponse(response);
            } else if (jsonError) {
                BMResponse *response = [BMResponse new];
                response.error = jsonError;
                reponse(response);
            } else {
                BMResponse *response = [BMResponse new];
                response.error = error;
                reponse(response);
            }
        }
    }];
    return task;
}
#endif

@end

#endif
