//
//  BMRequest.m
//  ProjectStructure
//
//  Created by 陈宇 on 15/12/1.
//
//

#import "BMRequest.h"
#import "NSString+Exist.h"

@interface BMRequest ()
@property (nonatomic, strong) NSMutableArray<Class> *ignoreHooks;
@end

@implementation BMRequest

+ (instancetype)requestWithPath:(NSString *)path
{
    NSAssert1([path isExist], @"%@不能为空", @"path");
    
    if ([path hasPrefix:@"/"]) {
        path = [path substringFromIndex:1];
    }
    
    BMRequest *request = [[BMRequest alloc] init];
    request.requestPath = path;
    return request;
}

+ (instancetype)requestWithPath:(NSString *)path contentKey:(NSString *)key
{
    NSAssert1([key isExist], @"%@不能为空", @"contentKey");
    
    BMRequest *request = [self requestWithPath:path];
    [request setValue:key forKeyPath:@"contentKey"];
    return request;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestMethod = BMRequestMethodPOST;
        _requestSerializerType = BMRequestSerializerTypeHTTP;
        _requestTimeoutInterval = 30.f;
    }
    return self;
}

- (void)addIgonreHookClass:(Class)clazz
{
    if (clazz != NULL) [self.ignoreHooks addObject:clazz];
}

- (BOOL)shouldIgnoreHookClass:(Class)clazz
{
    if (_ignoreHooks) {
        return [_ignoreHooks containsObject:clazz];
    } else {
        return NO;
    }
}

- (NSMutableArray *)ignoreHooks
{
    if (!_ignoreHooks) {
        _ignoreHooks = [NSMutableArray array];
    }
    return _ignoreHooks;
}

@end
