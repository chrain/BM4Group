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
    page.pageSize = 15;
    return page;
}

@end
