//
//  HttpClient.m
//  ProjectStructure
//
//  Created by 陈宇 on 15/11/13.
//
//
#import "HttpClient.h"
#import "BM4GroupMacro.h"
#import "NSString+Exist.h"
#import "BMToast.h"

#if __has_include(<AFNetworking/AFNetworking.h>)

NSString *const kHttpClientErrorDomain = @"com.chrain.errorDomain";

static HttpClient *_httpClient = nil;
static NSString *_baseURL = nil;
static NSInteger _successStatusCode = 0;

@interface HttpClient ()

@property (nonatomic, strong, readwrite) AFHTTPSessionManager *manager;

@end

@implementation HttpClient

+ (void)setBaseURL:(NSString *)baseURL
{
    _baseURL = baseURL;
}

+ (void)setServerSuccessStatusCode:(NSInteger)successStatusCode
{
    _successStatusCode = successStatusCode;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        _httpClient = [[HttpClient alloc] init];
#pragma clang diagnostic pop
    });
    return _httpClient;
}

+ (instancetype)new
{
    return nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _manager= [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:_baseURL]];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    }
    return self;
}

- (NSURLSessionTask *)startRequest:(BMRequest *)request finish:(finishBlock)finish failureHandler:(failureHandler)handler
{
    BMRequestMethod method = [request requestMethod];
    NSString *url = [self buildRequestUrl:request];
    id param = [request params];
    AFConstructingBlock constructingBlock = [request constrauctingBlock];
    
    if (request.requestSerializerType == BMRequestSerializerTypeHTTP) {
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    } else if (request.requestSerializerType == BMRequestSerializerTypeJSON) {
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    _manager.requestSerializer.timeoutInterval = [request requestTimeoutInterval];
    
    // if api need add custom value to HTTPHeaderField
    NSDictionary *headerFieldValueDictionary = [request requestHeaderFields];
    for (id httpHeaderField in headerFieldValueDictionary.allKeys) {
        id value = headerFieldValueDictionary[httpHeaderField];
        if ([httpHeaderField isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
            [_manager.requestSerializer setValue:(NSString *)value forHTTPHeaderField:(NSString *)httpHeaderField];
        } else {
            BMError(@"Error, class of key/value in headerFieldValueDictionary should be NSString.");
        }
    }
    
    @weakify(self);
    
    void (^handleErrorBlock)(NSError *error) = ^(NSError *error) {
        if (handler) {
            handler(error);
        } else {
            [BMToast makeText:error.localizedDescription];
        }
    };
    
    void (^handleSuccess)(NSURLSessionTask *task, id responseObject) = ^(NSURLSessionTask *task, id responseObject) {
        @strongify(self);
        BMResponse *response = [self responseWithJson:responseObject];
        if (response.error) {
            handleErrorBlock(response.error);
        } else {
            finish(response);
        }
    };
    
    void (^handleFailure)(NSURLSessionTask *task, NSError *error) = ^(NSURLSessionTask *task, NSError *error) {
        @strongify(self);
        NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (!responseData) {
            handleErrorBlock(error);
        } else {
            NSError *jsonError = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
            if (responseDict && [responseDict isKindOfClass:[NSDictionary class]]) {
                BMResponse *response = [self responseWithJson:responseDict];
                finish(response);
            } else if (jsonError) {
                handleErrorBlock(jsonError);
            } else {
                handleErrorBlock(error);
            }
        }
    };
    
    switch (method) {
        case BMRequestMethodGET: {
            return [_manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                handleSuccess(task, responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                handleFailure(task, error);
            }];
        }
        case BMRequestMethodPOST: {
            if (constructingBlock) {
                return [_manager POST:url parameters:param constructingBodyWithBlock:constructingBlock progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    handleSuccess(task, responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    handleFailure(task, error);
                }];
            } else {
                return [_manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    handleSuccess(task, responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    handleFailure(task, error);
                }];
            }
        }
        default:
            BMError(@"Error, unsupport method type");
            return nil;
    }
}

#pragma mark - 私有方法
- (NSString *)buildRequestUrl:(BMRequest *)request {
    NSString *detailUrl = [request path];
    if ([detailUrl hasPrefix:@"http"]) {
        return detailUrl;
    }
    return [_baseURL stringByAppendingPathComponent:request.path];
}

- (BMResponse *)responseWithJson:(id)responseObj {
    BMResponse *response = [BMResponse mj_objectWithKeyValues:responseObj];
    
    if (response.status != _successStatusCode) {
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

@end

#endif
