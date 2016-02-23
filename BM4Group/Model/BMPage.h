//
//  BMPage.h
//  ZPM
//
//  Created by 陈宇 on 15/4/17.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//  需要分组显示的page对象；

#import "BMBaseModel.h"


@interface BMPage : BMBaseModel

/**
 *  生成一个默认的page对象，默认page为1,perPage为20;
 */
+ (instancetype)defaultPage;

#pragma mark - 传送给服务器的字段。
@property (nonatomic, assign) NSUInteger page;    ///< 当前页码
@property (nonatomic, assign) NSUInteger perPage; ///< 每页数量

#pragma mark - 服务器端返回的数据，客户端仅做参考。
@property (nonatomic, assign, readonly) NSUInteger totalPageCount; ///< 服务器端根据perPage计算的总页数。
@property (nonatomic, assign, readonly) NSUInteger totalCount;     ///< 服务器端的数据总条数。

- (NSMutableDictionary *)nextPage;


#pragma mark - 用于默认设置。
/// 设置默认第一页。(有时服务器的第一页为0或者1)
+ (void)setFirstPage:(NSUInteger)page;

/// 默认pageNumberKey:pageNo  pageSizeKey:pageSize
+ (void)setPageKey:(NSString *)pageKey perPageKey:(NSString *)perPageKey;

/// 服务器端此四个字段的key，用于JSON转成对象。
+ (void)setServerPageKey:(NSString *)serverPageKey serverPerPageKey:(NSString *)serverPerPageKey serverTotalPageCountKey:(NSString *)serverTotalPageCountKey serverTotalCountKey:(NSString *)serverTotalCountKey;

@end
