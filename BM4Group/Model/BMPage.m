//
//  BMPage.m
//  ZPM
//
//  Created by 陈宇 on 15/4/17.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//  需要分组显示的page对象；

#import "BMPage.h"

static NSUInteger _firstPage = 1;

static NSString *_pageKey = @"pageNo";
static NSString *_perPageKey = @"pageSize";

static NSString *_serverPageKey = @"pageNum";
static NSString *_serverPerPageKey = @"pageSize";
static NSString *_serverTotalPageCountKey = @"pageCount";
static NSString *_serverTotalCountKey = @"totalCount";


@interface BMPage ()

@property (nonatomic, assign, readwrite) NSUInteger totalPageCount;
@property (nonatomic, assign, readwrite) NSUInteger totalCount;

@end


@implementation BMPage

+ (void)setFirstPage:(NSUInteger)page
{
    _firstPage = page;
}

+ (void)setPageKey:(NSString *)pageKey perPageKey:(NSString *)perPageKey
{
    _pageKey = pageKey;
    _perPageKey = perPageKey;
}

+ (void)setServerPageKey:(NSString *)serverPageKey serverPerPageKey:(NSString *)serverPerPageKey serverTotalPageCountKey:(NSString *)serverTotalPageCountKey serverTotalCountKey:(NSString *)serverTotalCountKey
{
    _serverPageKey = serverPageKey;
    _serverPerPageKey = serverPerPageKey;
    _serverTotalPageCountKey = serverTotalPageCountKey;
    _serverTotalCountKey = serverTotalCountKey;
}

+ (instancetype)defaultPage
{
    BMPage *page = [self new];
    page.page = _firstPage;
    page.perPage = 20;
    return page;
}

#if __has_include(<MJExtension/MJExtension.h>)
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"page" : _pageKey, @"perPage" : _perPageKey, @"totalPageCount" : _serverTotalPageCountKey, @"totalCount" : _serverTotalCountKey };
}

- (void)mj_keyValuesDidFinishConvertingToObject
{
    _selected = YES;
}
#endif

- (NSMutableDictionary *)nextPage
{
    // _select代表不是第一次了
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    params[_perPageKey] = @(_perPage);
    
    if (_selected) {
        if (_page >= _totalCount) {
            return nil;
        } else {
            params[_pageKey] = @(_page + 1);
        }
    } else {
        _selected = YES;
        params[_pageKey] = @(_page);
    }
    return params;
}

@end
