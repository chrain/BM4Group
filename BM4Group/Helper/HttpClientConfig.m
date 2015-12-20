//
//  HttpClientConfig.m
//  ProjectStructure
//
//  Created by 陈宇 on 15/12/20.
//
//

#import "HttpClientConfig.h"

static HttpClientConfig *_config = nil;

@implementation HttpClientConfig

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _config = [[self alloc] init];
    });
    return _config;
}

+ (instancetype)new
{
    return nil;
}

- (instancetype)init
{
    if (self = [super init]) {
        _timeout = 15;
    }
    return self;
}

@end
