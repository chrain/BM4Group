//
//  AccountHelper.m
//  BM4GroupExample
//
//  Created by 陈宇 on 15/12/20.
//  Copyright © 2015年 陈宇. All rights reserved.
//

#import "AccountHelper.h"
#import "StoreUtility.h"

NSString *const kCurrentUserKey = @"kCurrentUserKey";

static AccountHelper *_accountHelper = nil;

@implementation AccountHelper

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _accountHelper = [[self alloc] init];
    });
    return _accountHelper;
}

+ (instancetype)new
{
    return nil;
}

- (instancetype)init
{
    if (self = [super init]) {
        _user = [StoreUtility fetchByRootDirectory:kCurrentUserKey];
    }
    return self;
}

- (BOOL)isLogin {
    return _user != nil;
}

- (BOOL)logout {
    return [StoreUtility deleteRootPatByKey:kCurrentUserKey];
}

@end