//
//  NSString+BM.m
//  BM4Group
//
//  Created by Chrain on 15/5/25.
//  Copyright (c) 2015年 蓝色互动. All rights reserved.
//

#import "NSString+Exist.h"


@implementation NSString (Exist)

- (BOOL)isExist
{
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0;
}

@end
