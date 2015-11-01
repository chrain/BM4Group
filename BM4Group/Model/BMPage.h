//
//  BMPage.h
//  ZPM
//
//  Created by 陈宇 on 15/4/17.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//  需要分组显示的page对象；

#import "BMBaseModel.h"

@interface BMPage : BMBaseModel

@property (nonatomic, assign) NSUInteger pageCount;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, assign) NSUInteger totalCount;

/**
 *  生成一个默认的page对象，默认pageSize为15，pageNo为1;
 */
+ (instancetype)defaultPage;

- (NSMutableDictionary *)nextPage;

@end
