//
//  BMRequest.m
//  ProjectStructure
//
//  Created by 陈宇 on 15/12/1.
//
//

#import "BMRequest.h"
#import "NSString+Exist.h"

@implementation BMRequest

+ (instancetype)requestWithPath:(NSString *)path {
    NSAssert1([path isExist], @"%@不能为空", @"path");
    
    if ([path hasPrefix:@"/"]) {
        path = [path substringFromIndex:1];
    }
    
    BMRequest *request = [[BMRequest alloc] init];
    request.path = path;
    return request;
}

+ (instancetype)requestWithPath:(NSString *)path contentKey:(NSString *)key {
    NSAssert1([key isExist], @"%@不能为空", @"contentKey");
    
    BMRequest *request = [self requestWithPath:path];
    [request setValue:key forKeyPath:@"contentKey"];
    return request;
}

@end
