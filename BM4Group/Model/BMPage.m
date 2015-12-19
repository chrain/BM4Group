//
//  BMPage.m
//  ZPM
//
//  Created by 陈宇 on 15/4/17.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//  需要分组显示的page对象；

#import "BMPage.h"

@implementation BMPage

+ (instancetype)defaultPage
{
    BMPage *page = [[self alloc] init];
    page.pageNo = 0;
    page.pageCount = page.pageNo + 1;
    return page;
}

- (instancetype)init
{
    if (self = [super init]) {
        _pageSize = 20;
    }
    return self;
}

- (NSMutableDictionary *)nextPage
{
    if (_pageNo >= _pageCount) {
        return nil;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    params[@"pageNo"] = @(_pageNo + 1);
    params[@"pageSize"] = @(_pageSize);
    return params;
}

@end
